part of 'orders_page.dart';

class OrdersViewModel extends PageViewModel<OrdersState, OrdersStateStatus> {
  OrdersViewModel(BuildContext context) : super(context, OrdersState());

  @override
  OrdersStateStatus get status => state.status;

  @override
  TableUpdateQuery get listenForTables => TableUpdateQuery.onAllTables([
    dataStore.users,
    dataStore.orders,
    dataStore.orderLines,
    dataStore.storages,
  ]);

  @override
  Future<void> loadData() async {
    emit(state.copyWith(
      status: OrdersStateStatus.dataLoaded,
      orderExList: await store.ordersRepo.getOrderExList(),
      user: await store.usersRepo.getUser()
    ));
  }

  Future<Order?> findOrder(String trackingNumber) async {
    emit(state.copyWith(status: OrdersStateStatus.inProgress));

    try {
      OrderEx? orderEx = await store.ordersRepo.findOrder(trackingNumber);

      emit(state.copyWith(status: OrdersStateStatus.success, foundOrderEx: Optional.fromNullable(orderEx)));
    } on AppError catch(e) {
      emit(state.copyWith(status: OrdersStateStatus.failure, message: e.message));
    }

    return null;
  }
}
