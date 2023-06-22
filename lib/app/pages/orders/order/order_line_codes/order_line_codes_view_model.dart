part of 'order_line_codes_page.dart';

class OrderLineCodesViewModel extends PageViewModel<OrderLineCodesState, OrderLineCodesStateStatus> {
  OrderLineCodesViewModel(BuildContext context, { required OrderEx orderEx }) :
    super(context, OrderLineCodesState(orderEx: orderEx, confirmationCallback: () {}));

  @override
  OrderLineCodesStateStatus get status => state.status;

  @override
  TableUpdateQuery get listenForTables => TableUpdateQuery.onAllTables([
    dataStore.orders,
    dataStore.orderLines,
    dataStore.orderLineNewCodes,
  ]);

  @override
  Future<void> loadData() async {
    int orderId = state.orderEx.order.id;

    emit(state.copyWith(
      status: OrderLineCodesStateStatus.dataLoaded,
      orderEx: await store.ordersRepo.getOrderEx(orderId),
      newCodes: await store.ordersRepo.getOrderLineNewCodesEx(orderId)
    ));
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
      await store.ordersRepo.saveOrderLineCodes(state.orderEx, state.newCodes);

      emit(state.copyWith(status: OrderLineCodesStateStatus.success, message: 'Коды успешно сохранены'));
    } on AppError catch(e) {
      emit(state.copyWith(status: OrderLineCodesStateStatus.failure, message: e.message));
    }
  }

  Future<void> deleteOrderLineNewCodes(OrderLineEx orderLineEx) async {
    await Future.forEach<OrderLineNewCodeEx>(
      state.newCodes.where((e) => e.line.line == orderLineEx.line),
      (e) => store.ordersRepo.deleteOrderLineNewCode(e.newCode)
    );
  }
}
