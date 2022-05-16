part of 'orders_page.dart';

class OrdersViewModel extends PageViewModel<OrdersState, OrdersStateStatus> {
  OrdersViewModel(BuildContext context) : super(context, OrdersState());

  @override
  OrdersStateStatus get status => state.status;

  @override
  TableUpdateQuery get listenForTables => TableUpdateQuery.onAllTables([
    app.storage.users,
    app.storage.orders,
    app.storage.orderLines,
    app.storage.orderStorages,
  ]);

  @override
  Future<void> loadData() async {
    emit(state.copyWith(
      status: OrdersStateStatus.dataLoaded,
      orderExtendedList: await app.storage.ordersDao.getOrderExtendedList(),
      hasScanner: await Misc.hasScanner(),
      user: await app.storage.usersDao.getUser()
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
      OrderExtended? orderExtended = await _findOrder(trackingNumber);

      emit(state.copyWith(
        status: orderExtended != null ? OrdersStateStatus.success : OrdersStateStatus.failure,
        foundOrderExtended: Optional.fromNullable(orderExtended),
        message: orderExtended != null ? '' : 'Заказ не найден'
      ));
    } on AppError catch(e) {
      emit(state.copyWith(status: OrdersStateStatus.failure, message: e.message));
    }

    return null;
  }

  Future<OrderExtended?> _findOrder(String trackingNumber) async {
    try {
      OrderExtended? orderExtended = await app.storage.ordersDao.getOrderExtendedByTrackingNumber(trackingNumber);
      if (orderExtended != null) return orderExtended;

      ApiOrder? apiOrder = await Api(storage: app.storage).findOrder(trackingNumber: trackingNumber);
      orderExtended = apiOrder?.toDatabaseEnt();

      if (orderExtended != null) {
        await app.storage.transaction(() async {
          await app.storage.ordersDao.addOrder(orderExtended!.order);
          await Future.forEach<OrderLine>(orderExtended.lines, (e) => app.storage.ordersDao.addOrderLine(e));

          if (orderExtended.storageFrom != null) {
            await app.storage.orderStoragesDao.addOrderStorage(orderExtended.storageFrom!);
          }

          if (orderExtended.storageTo != null) {
            await app.storage.orderStoragesDao.addOrderStorage(orderExtended.storageTo!);
          }
        });

        return orderExtended;
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
