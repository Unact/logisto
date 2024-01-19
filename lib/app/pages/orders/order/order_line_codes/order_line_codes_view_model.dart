part of 'order_line_codes_page.dart';

class OrderLineCodesViewModel extends PageViewModel<OrderLineCodesState, OrderLineCodesStateStatus> {
  final OrdersRepository ordersRepository;

  StreamSubscription<List<OrderLineNewCodeEx>>? orderLineNewCodesExListSubscription;
  StreamSubscription<OrderEx?>? orderExSubscription;

  OrderLineCodesViewModel(this.ordersRepository, {required OrderEx orderEx}) :
    super(OrderLineCodesState(orderEx: orderEx, confirmationCallback: () {}));

  @override
  OrderLineCodesStateStatus get status => state.status;

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    int orderId = state.orderEx.order.id;

    orderLineNewCodesExListSubscription = ordersRepository.watchOrderLineNewCodesEx(orderId)
      .listen((event) {
        emit(state.copyWith(status: OrderLineCodesStateStatus.dataLoaded, newCodes: event));
      });
    orderExSubscription = ordersRepository.watchOrderEx(orderId)
      .listen((event) {
        emit(state.copyWith(status: OrderLineCodesStateStatus.dataLoaded, orderEx: event));
      });
  }

  @override
  Future<void> close() async {
    await super.close();

    await orderLineNewCodesExListSubscription?.cancel();
  }

  Future<void> trySaveOrderLineCodes() async {
    for (var orderLineEx in state.productOrderLinesEx) {
      int total = orderLineEx.line.factAmount ?? orderLineEx.line.amount;
      int codesLen = state.newCodes.where((e) => e.line.line == orderLineEx.line).length;

      if (total != codesLen) {
        emit(state.copyWith(
          status: OrderLineCodesStateStatus.needUserConfirmation,
          confirmationCallback: saveOrderLineCodes,
          message: 'Отсканированы не все коды. Вы действительно хотите завершить сканирование кодов?',
        ));
        return;
      }
    }

    await saveOrderLineCodes(true);
  }

  Future<void> saveOrderLineCodes(bool confirmed) async {
    if (!confirmed) return;

    emit(state.copyWith(status: OrderLineCodesStateStatus.inProgress));

    try {
      await ordersRepository.saveOrderLineCodes(state.orderEx, state.newCodes);

      emit(state.copyWith(status: OrderLineCodesStateStatus.success, message: 'Коды успешно сохранены'));
    } on AppError catch(e) {
      emit(state.copyWith(status: OrderLineCodesStateStatus.failure, message: e.message));
    }
  }

  Future<void> deleteOrderLineNewCodes(OrderLineEx orderLineEx) async {
    await Future.forEach<OrderLineNewCodeEx>(
      state.newCodes.where((e) => e.line.line == orderLineEx.line),
      (e) => ordersRepository.deleteOrderLineNewCode(e.newCode)
    );
  }
}
