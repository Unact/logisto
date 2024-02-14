part of 'accept_payment_page.dart';

class AcceptPaymentViewModel extends PageViewModel<AcceptPaymentState, AcceptPaymentStateStatus> {
  final AppRepository appRepository;
  final OrdersRepository ordersRepository;
  late Iboxpro iboxpro = Iboxpro(
    onError: (String error) => emit(state.copyWith(message: error, status: AcceptPaymentStateStatus.failure)),
    onLogin: _startPayment,
    onConnected: _getPaymentCredentials,
    onStart: (String id) {
      emit(state.copyWith(
        isCancelable: true,
        message: 'Обработка оплаты',
        status: AcceptPaymentStateStatus.paymentStarted
      ));
    },
    onComplete: (Map<String, dynamic> transaction, bool requiredSignature) {
      emit(state.copyWith(
        transaction: transaction,
        isRequiredSignature: requiredSignature,
        message: 'Подтверждение оплаты',
        status: AcceptPaymentStateStatus.paymentFinished
      ));

      if (!requiredSignature) {
        _savePayment();
      } else {
        emit(state.copyWith(
          message: 'Для завершения оплаты\nнеобходимо указать подпись',
          status: AcceptPaymentStateStatus.requiredSignature
        ));
      }
    },
    onAdjust: _savePayment
  );

  AcceptPaymentViewModel(this.appRepository, this.ordersRepository, {required bool cardPayment, required Order order}) :
    super(AcceptPaymentState(message: 'Инициализация платежа', cardPayment: cardPayment, order: order));

  @override
  AcceptPaymentStateStatus get status => state.status;

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    if (!state.cardPayment) {
      _savePayment();
    } else {
      _connectToDevice();
    }
  }

  @override
  Future<void> close() async {
    iboxpro.dispose();
    super.close();
  }

  Future<void> cancelPayment() async {
    await iboxpro.cancelPayment();

    emit(state.copyWith(message: 'Платеж отменен', canceled: true, status: AcceptPaymentStateStatus.failure));
  }

  Future<void> _connectToDevice() async {
    if (!await Permissions.hasBluetoothPermission()) {
      emit(state.copyWith(message: 'Не разрешено соединение по Bluetooth', status: AcceptPaymentStateStatus.failure));
      return;
    }

    emit(state.copyWith(
      message: 'Установление связи с терминалом',
      status: AcceptPaymentStateStatus.searchingForDevice
    ));
  }

  Future<void> _getPaymentCredentials([String? _]) async {
    if (state.canceled) return;

    emit(state.copyWith(message: 'Установление связи с сервером', status: AcceptPaymentStateStatus.gettingCredentials));

    try {
      ApiPaymentCredentials credentials = await appRepository.getApiPaymentCredentials();

      await _apiLogin(credentials.login, credentials.password);
    } on AppError catch(e) {
      emit(state.copyWith(message: e.message, status: AcceptPaymentStateStatus.failure));
    }
  }

  Future<void> _apiLogin(String login, String password) async {
    if (state.canceled) return;

    emit(state.copyWith(message: 'Авторизация оплаты', status: AcceptPaymentStateStatus.paymentAuthorization));

    await iboxpro.apiLogin(login: login, password: password);
  }

  Future<void> _startPayment() async {
    if (state.canceled) return;

    emit(state.copyWith(message: 'Ожидание ответа от терминала', status: AcceptPaymentStateStatus.waitingForPayment));

    await iboxpro.startPayment(
      amount: state.order.paySum,
      description: 'Оплата за заказ ${state.order.trackingNumber}',
      isLink: false
    );
  }

  Future<void> adjustPayment(Uint8List signature) async {
    emit(state.copyWith(
      message: 'Сохранение подписи клиента',
      status: AcceptPaymentStateStatus.savingSignature,
      isRequiredSignature: false
    ));

    await iboxpro.adjustPayment(signature: signature);
  }

  Future<void> _savePayment() async {
    emit(state.copyWith(
      message: 'Сохранение информации об оплате',
      status: AcceptPaymentStateStatus.savingPayment,
      isCancelable: false
    ));

    try {
      await ordersRepository.acceptPayment(state.order, state.transaction);

      emit(state.copyWith(message: 'Оплата успешно сохранена', status: AcceptPaymentStateStatus.finished));
    } on AppError catch(e) {
      emit(state.copyWith(
        message: 'Ошибка при сохранении оплаты ${e.message}',
        status: AcceptPaymentStateStatus.failure
      ));
    }
  }
}
