part of 'order_page.dart';

class OrderViewModel extends PageViewModel<OrderState, OrderStateStatus> {
  OrderViewModel(BuildContext context, { required OrderEx orderEx }) :
    super(context, OrderState(orderEx: orderEx, confirmationCallback: () {}));

  @override
  OrderStateStatus get status => state.status;

  @override
  TableUpdateQuery get listenForTables => TableUpdateQuery.onAllTables([
    app.dataStore.orders,
    app.dataStore.orderLines,
    app.dataStore.storages,
    app.dataStore.users
  ]);

  @override
  Future<void> loadData() async {
    emit(state.copyWith(
      status: OrderStateStatus.dataLoaded,
      storages: await app.dataStore.storagesDao.getStorages(),
      orderEx: await app.dataStore.ordersDao.getOrderEx(state.order.id),
      user: await app.dataStore.usersDao.getUser()
    ));
  }

  Future<void> updateOrderLineAmount(OrderLine orderLine, String amount) async {
    int? intAmount = int.tryParse(amount);

    await app.dataStore.ordersDao.updateOrderLine(
      orderLine.id,
      OrderLinesCompanion(factAmount: Value(intAmount))
    );
  }

  Future<void> updateWeight(String value) async {
    double? parsedWeight = Parsing.parseFormattedDouble(value);

    if (parsedWeight == null) {
      emit(state.copyWith(status: OrderStateStatus.failure, message: 'Указано не корректное число'));
      return;
    }

    try {
      await _updateOrder({'weight': (parsedWeight * 1000).toInt()});
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
      await _updateOrder({'volume': (parsedVolume * 1000000).toInt()});
    } on AppError catch(e) {
      emit(state.copyWith(status: OrderStateStatus.failure, message: e.message));
    }
  }

  Future<void> transferOrder(Storage storage) async {
    emit(state.copyWith(status: OrderStateStatus.inProgress));

    try {
      await _transferOrder(storage);

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
      await _acceptOrder(newStorage);

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
      await _acceptStorageTransferOrder();

      emit(state.copyWith(status: OrderStateStatus.success, message: 'Заказ успешно принят'));
    } on AppError catch(e) {
      emit(state.copyWith(status: OrderStateStatus.failure, message: e.message));
    }
  }

  Future<void> acceptTransferOrder() async {
    emit(state.copyWith(status: OrderStateStatus.inProgress));

    try {
      await _acceptTransferOrder();

      emit(state.copyWith(status: OrderStateStatus.success, message: 'Заказ успешно принят'));
    } on AppError catch(e) {
      emit(state.copyWith(status: OrderStateStatus.failure, message: e.message));
    }
  }

  Future<void> confirmOrder(bool confirmed) async {
    if (!confirmed) return;

    emit(state.copyWith(status: OrderStateStatus.inProgress));

    try {
      await _confirmOrder();

      emit(state.copyWith(status: OrderStateStatus.success, message: 'Заказ успешно выдан'));
    } on AppError catch(e) {
      emit(state.copyWith(status: OrderStateStatus.failure, message: e.message));
    }
  }

  Future<void> cancelOrder(bool confirmed) async {
    if (!confirmed) return;

    emit(state.copyWith(status: OrderStateStatus.inProgress));

    try {
      await _cancelOrder();

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

  Future<void> _updateOrder(Map<String, dynamic> data) async {
    try {
      ApiOrder newOrder = await Api(dataStore: app.dataStore).updateOrder(id: state.order.id, data: data);

      await _saveApiOrder(newOrder);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await app.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> _confirmOrder() async {
    try {
      List<Map<String, int>> lines = state.lines
        .map((e) => { 'id': e.id, 'factAmount': e.factAmount ?? e.amount })
        .toList();
      ApiOrder newOrder = await Api(dataStore: app.dataStore).confirmOrder(id: state.order.id, lines: lines);

      await _saveApiOrder(newOrder);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await app.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> _cancelOrder() async {
    try {
      ApiOrder newOrder = await Api(dataStore: app.dataStore).cancelOrder(id: state.order.id);

      await _saveApiOrder(newOrder);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await app.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> _transferOrder(Storage storage) async {
    try {
      ApiOrder newOrder = await Api(dataStore: app.dataStore).transferOrder(
        id: state.order.id,
        storageId: storage.id
      );

      await _saveApiOrder(newOrder);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await app.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> _acceptOrder(Storage storage) async {
    try {
      ApiOrder newOrder = await Api(dataStore: app.dataStore).acceptOrder(id: state.order.id, storageId: storage.id);

      await _saveApiOrder(newOrder);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await app.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> _acceptStorageTransferOrder() async {
    try {
      ApiOrder newOrder = await Api(dataStore: app.dataStore).acceptStorageTransferOrder(id: state.order.id);

      await _saveApiOrder(newOrder);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await app.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> _acceptTransferOrder() async {
    try {
      ApiOrder newOrder = await Api(dataStore: app.dataStore).acceptTransferOrder(id: state.order.id);

      await _saveApiOrder(newOrder);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await app.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> _saveApiOrder(ApiOrder apiOrder) async {
    OrderEx orderEx = apiOrder.toDatabaseEnt();

    await app.dataStore.transaction(() async {
      await app.dataStore.ordersDao.updateOrderEx(orderEx);
      if (orderEx.storageFrom != null) await app.dataStore.storagesDao.addStorage(orderEx.storageFrom!);
      if (orderEx.storageTo != null) await app.dataStore.storagesDao.addStorage(orderEx.storageTo!);
    });
  }

  Future<void> _acceptAndUpdateOrder(bool docConfirmed, String weightStr, String volumeStr) async {
    if (state.order.documentsReturn && !docConfirmed) throw AppError('Нельзя принять заказ без документов');

    double? parsedWeight = Parsing.parseFormattedDouble(weightStr);
    double? parsedVolume = Parsing.parseFormattedDouble(volumeStr);

    if (parsedVolume == null || parsedWeight == null) throw AppError('Указано не корректное число');

    await _updateOrder({'volume': (parsedVolume * 1000000).toInt(), 'weight': (parsedWeight * 1000).toInt()});
  }
}
