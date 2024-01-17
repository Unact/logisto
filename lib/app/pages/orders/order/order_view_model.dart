part of 'order_page.dart';

class OrderViewModel extends PageViewModel<OrderState, OrderStateStatus> {
  final OrdersRepository ordersRepository;
  final StoragesRepository storagesRepository;
  final UsersRepository usersRepository;

  StreamSubscription<OrderEx?>? orderExSubscription;
  StreamSubscription<List<Storage>>? storagesSubscription;
  StreamSubscription<User>? userSubscription;

  OrderViewModel(
    this.ordersRepository,
    this.storagesRepository,
    this.usersRepository,
    {
      required OrderEx orderEx
    }
  ) :
    super(OrderState(orderEx: orderEx, confirmationCallback: () {}));

  @override
  OrderStateStatus get status => state.status;

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    orderExSubscription = ordersRepository.watchOrderEx(state.order.id)
      .listen((event) {
        emit(state.copyWith(status: OrderStateStatus.dataLoaded, orderEx: event));
      });
    storagesSubscription = storagesRepository.watchStorages().listen((event) {
      emit(state.copyWith(status: OrderStateStatus.dataLoaded, storages: event));
    });
    userSubscription = usersRepository.watchUser().listen((event) {
      emit(state.copyWith(status: OrderStateStatus.dataLoaded, user: event));
    });
  }

  @override
  Future<void> close() async {
    await super.close();

    await orderExSubscription?.cancel();
    await storagesSubscription?.cancel();
    await userSubscription?.cancel();
  }

  Future<void> updateOrderLineAmount(OrderLineEx orderLine, String amount) async {
    int? intAmount = int.tryParse(amount);

    await ordersRepository.upsertOrderLine(
      orderLine.line.id,
      factAmount: intAmount
    );
  }

  Future<void> updateWeight(String value) async {
    double? parsedWeight = Parsing.parseFormattedDouble(value);

    if (parsedWeight == null) {
      emit(state.copyWith(status: OrderStateStatus.failure, message: 'Указано не корректное число'));
      return;
    }

    try {
      await ordersRepository.updateOrder(state.orderEx, weight: (parsedWeight * 1000).toInt());
    } on AppError catch(e) {
      emit(state.copyWith(status: OrderStateStatus.failure, message: e.message));
    }
  }

  Future<void> updateVolume(String value) async {
    double? parsedVolume = Parsing.parseFormattedDouble(value);

    if (parsedVolume == null) {
      emit(state.copyWith(status: OrderStateStatus.failure, message: 'Указано не корректное число'));
      return;
    }

    try {
      await ordersRepository.updateOrder(state.orderEx, volume: (parsedVolume * 1000000).toInt());
    } on AppError catch(e) {
      emit(state.copyWith(status: OrderStateStatus.failure, message: e.message));
    }
  }

  Future<void> transferOrder(Storage storage) async {
    emit(state.copyWith(status: OrderStateStatus.inProgress));

    try {
      await ordersRepository.transferOrder(state.orderEx, storage);

      emit(state.copyWith(status: OrderStateStatus.success, message: 'Заказ успешно передан'));
    } on AppError catch(e) {
      emit(state.copyWith(status: OrderStateStatus.failure, message: e.message));
    }
  }

  Future<void> acceptOrder(
    bool docConfirmed,
    String weightStr,
    String volumeStr,
    Storage newStorage
  ) async {
    emit(state.copyWith(status: OrderStateStatus.inProgress));

    try {
      await _acceptAndUpdateOrder(docConfirmed, weightStr, volumeStr);
      await ordersRepository.acceptOrder(state.orderEx, newStorage);

      emit(state.copyWith(status: OrderStateStatus.success, message: 'Заказ успешно принят'));
    } on AppError catch(e) {
      emit(state.copyWith(status: OrderStateStatus.failure, message: e.message));
    }
  }

  Future<void> acceptStorageTransferOrder(
    bool docConfirmed,
    String weightStr,
    String volumeStr
  ) async {
    emit(state.copyWith(status: OrderStateStatus.inProgress));

    try {
      await _acceptAndUpdateOrder(docConfirmed, weightStr, volumeStr);
      await ordersRepository.acceptStorageTransferOrder(state.orderEx);

      emit(state.copyWith(status: OrderStateStatus.success, message: 'Заказ успешно принят'));
    } on AppError catch(e) {
      emit(state.copyWith(status: OrderStateStatus.failure, message: e.message));
    }
  }

  Future<void> acceptTransferOrder() async {
    emit(state.copyWith(status: OrderStateStatus.inProgress));

    try {
      await ordersRepository.acceptTransferOrder(state.orderEx);

      emit(state.copyWith(status: OrderStateStatus.success, message: 'Заказ успешно принят'));
    } on AppError catch(e) {
      emit(state.copyWith(status: OrderStateStatus.failure, message: e.message));
    }
  }

  Future<void> confirmOrder(bool confirmed) async {
    if (!confirmed) return;

    emit(state.copyWith(status: OrderStateStatus.inProgress));

    try {
      await ordersRepository.confirmOrder(state.orderEx);

      emit(state.copyWith(status: OrderStateStatus.success, message: 'Заказ успешно выдан'));
    } on AppError catch(e) {
      emit(state.copyWith(status: OrderStateStatus.failure, message: e.message));
    }
  }

  Future<void> cancelOrder(bool confirmed) async {
    if (!confirmed) return;

    emit(state.copyWith(status: OrderStateStatus.inProgress));

    try {
      await ordersRepository.cancelOrder(state.orderEx);

      emit(state.copyWith(status: OrderStateStatus.success, message: 'Заказ успешно передан на возврат'));
    } on AppError catch(e) {
      emit(state.copyWith(status: OrderStateStatus.failure, message: e.message));
    }
  }

  void startScan() {
    emit(state.copyWith(status: OrderStateStatus.scanStarted, scanned: false));
  }

  Future<void> finishScan(bool result) async {
    emit(state.copyWith(
      status: OrderStateStatus.scanFinished,
      scanned: result,
      message: result ? 'Позиции успешно отсканированы' : 'Сканирование было прервано'
    ));
  }

  void tryConfirmOrder() {
    emit(state.copyWith(
      status: OrderStateStatus.needUserConfirmation,
      confirmationCallback: confirmOrder,
      message: 'Вы действительно хотите выдать заказ?',
    ));
  }

  void tryCancelOrder() {
    emit(state.copyWith(
      status: OrderStateStatus.needUserConfirmation,
      confirmationCallback: cancelOrder,
      message: 'Вы действительно хотите вернуть заказ?',
    ));
  }

  void tryStartPayment(bool cardPayment) {
    emit(state.copyWith(
      status: OrderStateStatus.needUserConfirmation,
      confirmationCallback: startPayment,
      message: 'Вы действительно хотите оплатить заказ ${cardPayment ? 'картой' : 'наличными'}?',
      cardPayment: cardPayment
    ));
  }

  Future<void> startPayment(bool confirmed) async {
    if (!confirmed) return;

    emit(state.copyWith(status: OrderStateStatus.paymentStarted));
  }

  void finishPayment(String result) {
    emit(state.copyWith(status: OrderStateStatus.paymentFinished, message: result));
  }

  Future<void> _acceptAndUpdateOrder(bool docConfirmed, String weightStr, String volumeStr) async {
    if (state.order.documentsReturn && !docConfirmed) throw AppError('Нельзя принять заказ без документов');

    double? parsedWeight = Parsing.parseFormattedDouble(weightStr);
    double? parsedVolume = Parsing.parseFormattedDouble(volumeStr);

    if (parsedVolume == null || parsedWeight == null) throw AppError('Указано не корректное число');

    await ordersRepository.updateOrder(
      state.orderEx,
      volume: (parsedVolume * 1000000).toInt(),
      weight: (parsedWeight * 1000).toInt()
    );
  }
}
