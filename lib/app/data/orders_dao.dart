part of 'database.dart';

@DriftAccessor(
  tables: [Orders, OrderLines],
)
class OrdersDao extends DatabaseAccessor<AppStorage> with _$OrdersDaoMixin {
  OrdersDao(AppStorage db) : super(db);

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

  Future<List<OrderExtended>> getOrderExtendedList() async {
    final storageFrom = alias(orderStorages, 'from_storage');
    final storageTo = alias(orderStorages, 'to_storage');
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
      return OrderExtended(
        orderRow.readTable(orders),
        orderLinesRes.where((element) => element.orderId == orderRow.readTable(orders).id).toList(),
        orderRow.readTableOrNull(storageFrom),
        orderRow.readTableOrNull(storageTo)
      );
    }).toList();
  }

  Future<void> addOrder(Order order) async {
    await into(orders).insert(order, mode: InsertMode.insertOrReplace);
  }

  Future<void> addOrderLine(OrderLine orderLine) async {
    await into(orderLines).insert(orderLine);
  }

  Future<void> updateOrder(int id, OrdersCompanion order) {
    return (update(orders)..where((t) => t.id.equals(id))).write(order);
  }

  Future<void> updateOrderLine(int id, OrderLinesCompanion orderLine) {
    return (update(orderLines)..where((t) => t.id.equals(id))).write(orderLine);
  }

  Future<OrderExtended> getOrderExtended(int id) async {
    final storageFrom = alias(orderStorages, 'from_storage');
    final storageTo = alias(orderStorages, 'to_storage');
    final orderQuery = select(orders)
      .join(
        [
          leftOuterJoin(storageFrom, storageFrom.id.equalsExp(orders.storageFromId)),
          leftOuterJoin(storageTo, storageTo.id.equalsExp(orders.storageToId))
        ],
      )
      ..where(orders.id.equals(id));
    final orderLinesQuery = select(orderLines)
      ..where((t) => t.orderId.equals(id))
      ..orderBy([(u) => OrderingTerm(expression: u.name)]);
    final orderRow = await orderQuery.getSingle();

    return OrderExtended(
      orderRow.readTable(orders),
      await orderLinesQuery.get(),
      orderRow.readTableOrNull(storageFrom),
      orderRow.readTableOrNull(storageTo)
    );
  }

  Future<OrderExtended?> getOrderExtendedByTrackingNumber(String trackingNumber) async {
    final storageFrom = alias(orderStorages, 'from_storage');
    final storageTo = alias(orderStorages, 'to_storage');
    final orderQuery = select(orders)
      .join(
        [
          leftOuterJoin(storageFrom, storageFrom.id.equalsExp(orders.storageFromId)),
          leftOuterJoin(storageTo, storageTo.id.equalsExp(orders.storageToId))
        ],
      )
      ..where(orders.trackingNumber.equals(trackingNumber));
    final orderRow = await orderQuery.getSingleOrNull();

    if (orderRow == null) return null;

    final orderLinesQuery = select(orderLines)
      ..where((t) => t.orderId.equals(orderRow.readTable(orders).id))
      ..orderBy([(u) => OrderingTerm(expression: u.name)]);

    return OrderExtended(
      orderRow.readTable(orders),
      await orderLinesQuery.get(),
      orderRow.readTableOrNull(storageFrom),
      orderRow.readTableOrNull(storageTo)
    );
  }
}

class OrderExtended {
  final Order order;
  final List<OrderLine> lines;
  final OrderStorage? storageFrom;
  final OrderStorage? storageTo;

  OrderExtended(this.order, this.lines, this.storageFrom, this.storageTo);
}
