part of 'database.dart';

@DriftAccessor(
  tables: [Orders, OrderLines],
)
class OrdersDao extends DatabaseAccessor<AppDataStore> with _$OrdersDaoMixin {
  OrdersDao(AppDataStore db) : super(db);

  Future<void> loadOrders(List<Order> orderList) async {
    await batch((batch) {
      batch.deleteWhere(orders, (row) => const Constant(true));
      batch.insertAll(orders, orderList);
    });
  }

  Future<void> loadOrderLines(List<OrderLine> orderLineList) async {
    await batch((batch) {
      batch.deleteWhere(orderLines, (row) => const Constant(true));
      batch.insertAll(orderLines, orderLineList);
    });
  }

  Future<List<OrderEx>> getOrderExList() async {
    final storageFrom = alias(storages, 'from_storage');
    final storageTo = alias(storages, 'to_storage');
    final ordersQuery = select(orders)
      .join(
        [
          leftOuterJoin(storageFrom, storageFrom.id.equalsExp(orders.storageFromId)),
          leftOuterJoin(storageTo, storageTo.id.equalsExp(orders.storageToId))
        ],
      )
      ..orderBy([OrderingTerm(expression: orders.trackingNumber)]);
    final orderLinesRes = await (select(orderLines)..orderBy([(u) => OrderingTerm(expression: u.name)])).get();

    return (await ordersQuery.get()).map((orderRow) {
      return OrderEx(
        orderRow.readTable(orders),
        orderLinesRes.where((element) => element.orderId == orderRow.readTable(orders).id).toList(),
        orderRow.readTableOrNull(storageFrom),
        orderRow.readTableOrNull(storageTo)
      );
    }).toList();
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
    await Future.forEach<OrderLine>(orderEx.lines, (e) => upsertOrderLine(orderEx.order.id, e.toCompanion(false)));
  }

  Future<OrderEx> getOrderEx(int id) async {
    return (await _getOrderEx(orders.id.equals(id)))!;
  }

  Future<OrderEx?> getOrderExByTrackingNumber(String trackingNumber) async {
    return _getOrderEx(orders.trackingNumber.equals(trackingNumber));
  }

  Future<OrderEx?> _getOrderEx(Expression<bool> whereExp) async {
    final storageFrom = alias(storages, 'from_storage');
    final storageTo = alias(storages, 'to_storage');
    final orderQuery = select(orders)
      .join(
        [
          leftOuterJoin(storageFrom, storageFrom.id.equalsExp(orders.storageFromId)),
          leftOuterJoin(storageTo, storageTo.id.equalsExp(orders.storageToId))
        ],
      )
      ..where(whereExp);
    final orderRow = await orderQuery.getSingleOrNull();

    if (orderRow == null) return null;

    final id = orderRow.readTable(orders).id;
    final orderLinesQuery = select(orderLines)
      ..where((t) => t.orderId.equals(id))
      ..orderBy([(u) => OrderingTerm(expression: u.name)]);

    return OrderEx(
      orderRow.readTable(orders),
      await orderLinesQuery.get(),
      orderRow.readTableOrNull(storageFrom),
      orderRow.readTableOrNull(storageTo)
    );
  }
}

class OrderEx {
  final Order order;
  final List<OrderLine> lines;
  final Storage? storageFrom;
  final Storage? storageTo;

  OrderEx(this.order, this.lines, this.storageFrom, this.storageTo);
}
