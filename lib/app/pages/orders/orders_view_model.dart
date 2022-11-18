part of 'orders_page.dart';

class OrdersViewModel extends PageViewModel<OrdersState, OrdersStateStatus> {
  OrdersViewModel(BuildContext context) : super(context, OrdersState());

  @override
  OrdersStateStatus get status => state.status;

  @override
  TableUpdateQuery get listenForTables => TableUpdateQuery.onAllTables([
    app.dataStore.users,
    app.dataStore.orders,
    app.dataStore.orderLines,
    app.dataStore.storages,
  ]);

  @override
  Future<void> loadData() async {
    emit(state.copyWith(
      status: OrdersStateStatus.dataLoaded,
      orderExList: await app.dataStore.ordersDao.getOrderExList(),
      user: await app.dataStore.usersDao.getUser()
    ));
  }

  Future<Order?> findOrder(String trackingNumber) async {
    emit(state.copyWith(status: OrdersStateStatus.inProgress));

    try {
      OrderEx? orderEx = await _findOrder(trackingNumber);

      emit(state.copyWith(status: OrdersStateStatus.success, foundOrderEx: Optional.fromNullable(orderEx)));
    } on AppError catch(e) {
      emit(state.copyWith(status: OrdersStateStatus.failure, message: e.message));
    }

    return null;
  }

  Future<OrderEx> _findOrder(String trackingNumber) async {
    try {
      OrderEx? orderEx = await app.dataStore.ordersDao.getOrderExByTrackingNumber(trackingNumber);
      if (orderEx != null) return orderEx;

      ApiOrder apiOrder = await Api(dataStore: app.dataStore).findOrder(trackingNumber: trackingNumber);
      orderEx = apiOrder.toDatabaseEnt();

      await app.dataStore.transaction(() async {
        await app.dataStore.ordersDao.updateOrderEx(orderEx!);
        if (orderEx.storageFrom != null) await app.dataStore.storagesDao.addStorage(orderEx.storageFrom!);
        if (orderEx.storageTo != null) await app.dataStore.storagesDao.addStorage(orderEx.storageTo!);
      });

      return orderEx;
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await app.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }
}
