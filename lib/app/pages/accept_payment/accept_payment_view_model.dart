part of 'accept_payment_page.dart';

class AcceptPaymentViewModel extends PageViewModel<AcceptPaymentState, AcceptPaymentStateStatus> {
  Iboxpro iboxpro = Iboxpro();

  AcceptPaymentViewModel(BuildContext context, {
    required bool cardPayment,
    required Order order
  }) : super(context, AcceptPaymentState(
    message: 'Инициализация платежа',
    cardPayment: cardPayment,
    order: order
  ));

  @override
  AcceptPaymentStateStatus get status => state.status;

  @override
  Future<void> loadData() async {}

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    if (!state.cardPayment) {
      _savePayment();
    } else {
      _connectToDevice();
    }
  }

  Future<void> cancelPayment() async {
    await iboxpro.cancelPayment();

    emit(state.copyWith(message: 'Платеж отменен', canceled: true, status: AcceptPaymentStateStatus.failure));
  }

  Future<void> _connectToDevice() async {
    if (!await _checkBluetoothPermissions()) {
      emit(state.copyWith(message: 'Не разрешено соединение по Bluetooth', status: AcceptPaymentStateStatus.failure));
      return;
    }

    emit(state.copyWith(
      message: 'Установление связи с терминалом',
      status: AcceptPaymentStateStatus.searchingForDevice
    ));

    iboxpro.connectToDevice(
      onError: (String error) => emit(state.copyWith(message: error, status: AcceptPaymentStateStatus.failure)),
      onConnected: _getPaymentCredentials
    );
  }

  Future<void> _getPaymentCredentials() async {
    if (state.canceled) return;

    emit(state.copyWith(message: 'Установление связи с сервером', status: AcceptPaymentStateStatus.gettingCredentials));

    try {
      ApiPaymentCredentials credentials = await _getApiPaymentCredentials();

      await _apiLogin(credentials.login, credentials.password);
    } on AppError catch(e) {
      emit(state.copyWith(message: e.message, status: AcceptPaymentStateStatus.failure));
    }
  }

  Future<void> _apiLogin(String login, String password) async {
    if (state.canceled) return;

    emit(state.copyWith(message: 'Авторизация оплаты', status: AcceptPaymentStateStatus.paymentAuthorization));

    await iboxpro.apiLogin(
      login: login,
      password: password,
      onError: (String error) => emit(state.copyWith(message: error, status: AcceptPaymentStateStatus.failure)),
      onLogin: _startPayment
    );
  }

  Future<void> _startPayment() async {
    if (state.canceled) return;

    emit(state.copyWith(message: 'Ожидание ответа от терминала', status: AcceptPaymentStateStatus.waitingForPayment));

    await iboxpro.startPayment(
      amount: state.order.paySum,
      description: 'Оплата за заказ ${state.order.trackingNumber}',
      onError: (String error) => emit(state.copyWith(message: error, status: AcceptPaymentStateStatus.failure)),
      onPaymentStart: (_) {
        emit(state.copyWith(
          message: 'Обработка оплаты',
          status: AcceptPaymentStateStatus.waitingForPayment,
          isCancelable: false
        ));
      },
      onPaymentComplete: (Map<dynamic, dynamic> transaction, bool requiredSignature) {
        emit(state.copyWith(
          message: 'Подтверждение оплаты',
          status: AcceptPaymentStateStatus.paymentFinished,
          isRequiredSignature: requiredSignature
        ));

        if (!requiredSignature) {
          _savePayment(transaction);
        } else {
          emit(state.copyWith(
            message: 'Для завершения оплаты\nнеобходимо указать подпись',
            status: AcceptPaymentStateStatus.requiredSignature
          ));
        }
      }
    );
  }

  Future<void> adjustPayment(Uint8List signature) async {
    emit(state.copyWith(
      message: 'Сохранение подписи клиента',
      status: AcceptPaymentStateStatus.savingSignature,
      isRequiredSignature: false
    ));

    await iboxpro.adjustPayment(
      signature: signature,
      onError: (String error) => emit(state.copyWith(message: error, status: AcceptPaymentStateStatus.failure)),
      onPaymentAdjust: _savePayment
    );
  }

  Future<void> _savePayment([Map<dynamic, dynamic>? transaction]) async {
    emit(state.copyWith(
      message: 'Сохранение информации об оплате',
      status: AcceptPaymentStateStatus.savingPayment,
      isCancelable: false
    ));

    try {
      await _acceptPayment(transaction);

      emit(state.copyWith(message: 'Оплата успешно сохранена', status: AcceptPaymentStateStatus.finished));
    } on AppError catch(e) {
      emit(state.copyWith(
        message: 'Ошибка при сохранении оплаты ${e.message}',
        status: AcceptPaymentStateStatus.failure
      ));
    }
  }

  Future<void> _acceptPayment(Map<dynamic, dynamic>? transaction) async {
    try {
      ApiOrder newOrder = await Api(storage: app.storage).acceptPayment(
        id: state.order.id,
        summ: state.order.paySum,
        transaction: transaction
      );

      await app.storage.ordersDao.updateOrder(state.order.id, newOrder.toDatabaseEnt().order.toCompanion(false));
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await app.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<ApiPaymentCredentials> _getApiPaymentCredentials() async {
    try {
      return await Api(storage: app.storage).getPaymentCredentials();
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await app.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<bool> _checkBluetoothPermissions() async {
    if (Platform.isIOS) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.bluetooth,
      ].request();

      return statuses.values.every((element) => element.isGranted);
    }

    if (Platform.isAndroid) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.bluetoothConnect,
        Permission.bluetoothScan
      ].request();

      return statuses.values.every((element) => element.isGranted);
    }

    return false;
  }
}
