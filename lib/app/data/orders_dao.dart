part of 'database.dart';

@DriftAccessor(
  tables: [Orders, OrderLines, OrderLineNewCodes, Products],
)
class OrdersDao extends DatabaseAccessor<AppDataStore> with _$OrdersDaoMixin {
  OrdersDao(AppDataStore db) : super(db);

  Future<void> loadOrders(List<Order> orderList) async {
    await batch((batch) {
      batch.deleteWhere(orders, (row) => const Constant(true));
      batch.insertAll(orders, orderList, mode: InsertMode.insertOrReplace);
    });
  }

  Future<void> loadOrderLines(List<OrderLine> orderLineList) async {
    await batch((batch) {
      batch.deleteWhere(orderLines, (row) => const Constant(true));
      batch.insertAll(orderLines, orderLineList, mode: InsertMode.insertOrReplace);
    });
  }

  Stream<List<OrderEx>> watchOrderExList() {
    final storageFrom = alias(storages, 'from_storage');
    final storageTo = alias(storages, 'to_storage');
    final ordersStream = (
      select(orders)
        .join(
          [
            leftOuterJoin(storageFrom, storageFrom.id.equalsExp(orders.storageFromId)),
            leftOuterJoin(storageTo, storageTo.id.equalsExp(orders.storageToId))
          ],
        )
        ..orderBy([OrderingTerm(expression: orders.trackingNumber)])
    ).watch();
    final orderLinesStream = (
      select(orderLines)
      .join([leftOuterJoin(products, products.id.equalsExp(orderLines.productId))])
      ..orderBy([OrderingTerm(expression: orderLines.name)])
    ).watch();

    return Rx.combineLatest2(
      ordersStream,
      orderLinesStream,
      (ordersRes, orderLinesRes) {
        return ordersRes.map((orderRow) {
          final orderLinesEx = orderLinesRes
            .where((element) => element.readTable(orderLines).orderId == orderRow.readTable(orders).id)
            .map((element) => OrderLineEx(element.readTable(orderLines), element.readTableOrNull(products)))
            .toList();

          return OrderEx(
            orderRow.readTable(orders),
            orderLinesEx,
            orderRow.readTableOrNull(storageFrom),
            orderRow.readTableOrNull(storageTo)
          );
        }).toList();
      }
    );
  }

  Future<int> upsertOrder(int id, OrdersCompanion order) {
    return into(orders).insertOnConflictUpdate(order);
  }

  Future<int> upsertOrderLine(int id, OrderLinesCompanion orderLine) {
    return into(orderLines).insertOnConflictUpdate(orderLine);
  }

  Future<void> updateOrderEx(OrderEx orderEx) async {
    await (delete(orders)..where((tbl) => tbl.id.equals(orderEx.order.id))).go();
    await upsertOrder(orderEx.order.id, orderEx.order.toCompanion(false));
    await Future.forEach<OrderLine>(
      orderEx.lines.map((e) => e.line),
      (e) => upsertOrderLine(orderEx.order.id, e.toCompanion(false))
    );
  }

  Future<void> addOrderLineNewCode(OrderLineNewCodesCompanion newCode) async {
    await into(orderLineNewCodes).insert(newCode, mode: InsertMode.insertOrReplace);
  }

  Future<void> deleteOrderLineNewCode(OrderLineNewCode newCode) async {
    await (delete(orderLineNewCodes)..where((e) => e.id.equals(newCode.id))).go();
  }

  Future<void> cleareOrderLineNewCodes() async {
    await delete(orderLineNewCodes).go();
  }

  Stream<OrderEx?> watchOrderEx(int id) {
    return _getOrderEx(orders.id.equals(id));
  }

  Stream<OrderEx?> getOrderExByTrackingNumber(String trackingNumber) {
    return _getOrderEx(orders.trackingNumber.equals(trackingNumber));
  }

  Stream<OrderEx?> _getOrderEx(Expression<bool> whereExp) {
    final orderIdQuery = selectOnly(orders)
      ..addColumns([orders.id])
      ..where(whereExp);

    final storageFrom = alias(storages, 'from_storage');
    final storageTo = alias(storages, 'to_storage');
    final orderStream = (
      select(orders)
        .join(
          [
            leftOuterJoin(storageFrom, storageFrom.id.equalsExp(orders.storageFromId)),
            leftOuterJoin(storageTo, storageTo.id.equalsExp(orders.storageToId))
          ],
        )
        ..where(whereExp)
    ).watchSingleOrNull();
    final orderLinesStream = (
      select(orderLines)
        .join([leftOuterJoin(products, products.id.equalsExp(orderLines.productId))])
        ..where(orderLines.orderId.isInQuery(orderIdQuery))
        ..orderBy([OrderingTerm(expression: orderLines.name)])
    ).watch();

    return Rx.combineLatest2(
      orderStream,
      orderLinesStream,
      (orderRow, orderLinesRes) {
        if (orderRow == null) return null;

        final orderLinesEx = orderLinesRes
        .where((element) => element.readTable(orderLines).orderId == orderRow.readTable(orders).id)
        .map((element) => OrderLineEx(element.readTable(orderLines), element.readTableOrNull(products)))
        .toList();

        return OrderEx(
          orderRow.readTable(orders),
          orderLinesEx,
          orderRow.readTableOrNull(storageFrom),
          orderRow.readTableOrNull(storageTo)
        );
      });
  }

  Stream<List<OrderLineNewCodeEx>> watchOrderLineNewCodesEx(int orderId) {
    final orderLineNewCodesQuery = select(orderLineNewCodes)
      .join([
        innerJoin(orderLines, orderLines.id.equalsExp(orderLineNewCodes.orderLineId)),
        innerJoin(products, products.id.equalsExp(orderLines.productId)),
      ])
      ..where(orderLines.orderId.equals(orderId))
      ..orderBy([OrderingTerm(expression: products.name)]);

    return orderLineNewCodesQuery.watch().map((event) => event.map((orderLineCode) {
      return OrderLineNewCodeEx(
        orderLineCode.readTable(orderLineNewCodes),
        OrderLineEx(orderLineCode.readTable(orderLines), orderLineCode.readTable(products))
      );
    }).toList());
  }
}

class OrderEx {
  final Order order;
  final List<OrderLineEx> lines;
  final Storage? storageFrom;
  final Storage? storageTo;

  OrderEx(this.order, this.lines, this.storageFrom, this.storageTo);
}

class OrderLineEx {
  final OrderLine line;
  final Product? product;

  OrderLineEx(this.line, this.product);
}

class OrderLineNewCodeEx {
  final OrderLineNewCode newCode;
  final OrderLineEx line;

  OrderLineNewCodeEx(this.newCode, this.line);
}
