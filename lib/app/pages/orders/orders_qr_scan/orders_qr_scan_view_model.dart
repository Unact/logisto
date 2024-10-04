part of 'orders_qr_scan_page.dart';

class OrdersQRScanPageViewModel extends PageViewModel<OrdersQRScanPageState, OrdersQRScanPageStateStatus> {
  static const String qrType = 'ORDER';
  final OrdersRepository ordersRepository;

  StreamSubscription<List<OrderEx>>? orderExListSubscription;

  OrdersQRScanPageViewModel(this.ordersRepository) : super(OrdersQRScanPageState());

  @override
  OrdersQRScanPageStateStatus get status => state.status;


  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    orderExListSubscription = ordersRepository.watchOrderExList()
      .listen((event) {
        emit(state.copyWith(status: OrdersQRScanPageStateStatus.dataLoaded, orderExList: event));
      });
  }

  @override
  Future<void> close() async {
    await super.close();

    await orderExListSubscription?.cancel();
  }

  Future<void> readQRCode(String? qrCode) async {
    if (qrCode == null) return;

    List<String> qrCodeData = qrCode.split(' ');
    String version = qrCodeData[0];

    if (version != Strings.qrCodeVersion) {
      emit(state.copyWith(
        status: OrdersQRScanPageStateStatus.scanReadFailure,
        message: 'Считан не поддерживаемый QR код'
      ));
      return;
    }

    if (qrCodeData[3] != QRType.order.typeName) {
      emit(state.copyWith(status: OrdersQRScanPageStateStatus.scanReadFailure, message: 'QR код не от заказа'));
      return;
    }

    return await _processQR(qrCodeData[4], int.parse(qrCodeData[5]));
  }

  Future<void> _processQR(String qrTrackingNumber, int packageNumber) async {
    OrdersQRScanPageState newState = state;

    OrderEx? orderEx = state.orderExList.firstWhereOrNull((e) => e.order.trackingNumber == qrTrackingNumber);

    if (orderEx == null) {
      emit(state.copyWith(status: OrdersQRScanPageStateStatus.scanReadFailure, message: 'Заказ не найден'));
      return;
    }

    Map<OrderEx, List<bool>> newOrderScanned = Map.of(state.orderScanned);
    List<bool> scannedPackages = newOrderScanned[orderEx] ?? List.generate(orderEx.order.packages, (_) => false);

    if (scannedPackages[packageNumber - 1]) {
      emit(state.copyWith(status: OrdersQRScanPageStateStatus.scanReadFailure, message: 'QR код уже был считан'));
      return;
    }

    scannedPackages[packageNumber - 1] = true;
    newOrderScanned[orderEx] = scannedPackages;
    emit(newState.copyWith(orderScanned: newOrderScanned, status: OrdersQRScanPageStateStatus.scanReadFinished));
  }

  Future<void> confirmOrders() async {
    emit(state.copyWith(status: OrdersQRScanPageStateStatus.inProgress));

    final fullyScannedOrders = state.orderScanned.entries.where((e) => e.value.none((v) => !v));

    if (fullyScannedOrders.isEmpty) {
      emit(state.copyWith(status: OrdersQRScanPageStateStatus.failure, message: 'Нет заказов для выдачи'));
      return;
    }

    for (var order in fullyScannedOrders) {
      try {
        await ordersRepository.confirmOrder(order.key);

        removeScannedOrder(order.key);
      } on AppError catch(e) {
        emit(state.copyWith(status: OrdersQRScanPageStateStatus.failure, message: e.message));
        return;
      }
    }

    emit(state.copyWith(status: OrdersQRScanPageStateStatus.success, message: 'Заказы успешно выданы'));
  }

  void removeScannedOrder(OrderEx orderEx) {
    Map<OrderEx, List<bool>> newOrderScanned = Map.of(state.orderScanned);
    newOrderScanned.remove(orderEx);

    emit(state.copyWith(orderScanned: newOrderScanned));
  }
}
