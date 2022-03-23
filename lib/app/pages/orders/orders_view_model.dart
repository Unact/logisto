part of 'orders_page.dart';

class OrdersViewModel extends PageViewModel<OrdersState, OrdersStateStatus> {
  OrdersViewModel(BuildContext context) : super(context, OrdersState());

  @override
  OrdersStateStatus get status => state.status;

  @override
  TableUpdateQuery get listenForTables => TableUpdateQuery.onAllTables([
    app.storage.orders,
    app.storage.orderLines,
    app.storage.orderStorages,
  ]);

  @override
  Future<void> loadData() async {
    emit(state.copyWith(
      status: OrdersStateStatus.dataLoaded,
      ordersWithLines: await app.storage.ordersDao.getOrdersWithLines()
    ));
  }

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    emit(state.copyWith(status: OrdersStateStatus.startLoad));
  }

  Future<Order?> findOrder(String trackingNumber) async {
    emit(state.copyWith(status: OrdersStateStatus.inProgress));

    try {
      OrderWithLines? orderWithLines = await _findOrder(trackingNumber);

      emit(state.copyWith(
        status: orderWithLines != null ? OrdersStateStatus.success : OrdersStateStatus.failure,
        foundOrderWithLine: Optional.fromNullable(orderWithLines),
        message: orderWithLines != null ? '' : 'Заказ не найден'
      ));
    } on AppError catch(e) {
      emit(state.copyWith(status: OrdersStateStatus.failure, message: e.message));
    }

    return null;
  }

  Future<OrderWithLines?> _findOrder(String trackingNumber) async {
    try {
      OrderWithLines? orderWithLines = await app.storage.ordersDao.getOrderWithLinesByTrackingNumber(trackingNumber);
      if (orderWithLines != null) return orderWithLines;

      ApiOrder? apiOrder = await Api(storage: app.storage).findOrder(trackingNumber: trackingNumber);
      orderWithLines = apiOrder?.toDatabaseEnt();

      if (orderWithLines != null) {
        await app.storage.transaction(() async {
          await app.storage.ordersDao.addOrder(orderWithLines!.order);
          await Future.forEach<OrderLine>(orderWithLines.lines, (e) => app.storage.ordersDao.addOrderLine(e));
        });

        return orderWithLines;
      }

      return null;
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await app.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }
}
