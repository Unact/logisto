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

  Future<List<OrderWithLines>> getOrdersWithLines() async {
    final ordersQuery =  await (select(orders)..orderBy([(u) => OrderingTerm(expression: u.trackingNumber)])).get();
    final orderLinesQuery = await (select(orderLines)..orderBy([(u) => OrderingTerm(expression: u.name)])).get();

    return ordersQuery.map((Order order) {
      return OrderWithLines(order, orderLinesQuery.where((element) => element.orderId == order.id).toList());
    }).toList();
  }

  Future<void> addOrder(Order order) async {
    await into(orders).insert(order);
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

  Future<OrderWithLines> getOrderWithLines(int id) async {
    final orderQuery = select(orders)..where((tbl) => tbl.id.equals(id));
    final orderLinesQuery = select(orderLines)
      ..where((t) => t.orderId.equals(id))
      ..orderBy([(u) => OrderingTerm(expression: u.name)]);

    return OrderWithLines(await orderQuery.getSingle(), await orderLinesQuery.get());
  }

  Future<OrderWithLines?> getOrderWithLinesByTrackingNumber(String trackingNumber) async {
    final order = await (select(orders)..where((tbl) => tbl.trackingNumber.equals(trackingNumber))).getSingleOrNull();

    if (order == null) return null;

    final orderLinesQuery = select(orderLines)
      ..where((t) => t.orderId.equals(order.id))
      ..orderBy([(u) => OrderingTerm(expression: u.name)]);

    return OrderWithLines(order, await orderLinesQuery.get());
  }
}

class OrderWithLines {
  final Order order;
  final List<OrderLine> lines;

  OrderWithLines(this.order, this.lines);
}
