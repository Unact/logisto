part of 'orders_page.dart';

class OrdersViewModel extends PageViewModel<OrdersState, OrdersStateStatus> {
  final OrdersRepository ordersRepository;
  final UsersRepository usersRepository;

  StreamSubscription<List<OrderEx>>? orderExListSubscription;
  StreamSubscription<User>? userSubscription;

  OrdersViewModel(this.ordersRepository, this.usersRepository) : super(OrdersState());

  @override
  OrdersStateStatus get status => state.status;

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    orderExListSubscription = ordersRepository.watchOrderExList()
      .listen((event) {
        emit(state.copyWith(status: OrdersStateStatus.dataLoaded, orderExList: event));
      });
    userSubscription = usersRepository.watchUser().listen((event) {
      emit(state.copyWith(status: OrdersStateStatus.dataLoaded, user: event));
    });
  }

  @override
  Future<void> close() async {
    await super.close();

    await orderExListSubscription?.cancel();
  }

  Future<void> findOrder(String trackingNumber) async {
    emit(state.copyWith(status: OrdersStateStatus.inProgress));

    try {
      OrderEx? orderEx = await ordersRepository.findOrder(trackingNumber);

      emit(state.copyWith(status: OrdersStateStatus.success, foundOrderEx: Optional.fromNullable(orderEx)));
    } on AppError catch(e) {
      emit(state.copyWith(status: OrdersStateStatus.failure, message: e.message));
    }
  }
}
