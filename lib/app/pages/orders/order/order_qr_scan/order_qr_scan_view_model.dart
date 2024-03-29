part of 'order_qr_scan_page.dart';

class OrderQRScanViewModel extends PageViewModel<OrderQRScanState, OrderQRScanStateStatus> {
  static const String qrType = 'ORDER';

  OrderQRScanViewModel({ required Order order }) :
    super(
      OrderQRScanState(
        order: order,
        orderPackageScanned: List.filled(order.packages, false),
      )
    );

  @override
  OrderQRScanStateStatus get status => state.status;

  Future<void> readQRCode(String? qrCode) async {
    if (qrCode == null) return;

    List<String> qrCodeData = qrCode.split(' ');
    String version = qrCodeData[0];

    if (version != Strings.qrCodeVersion) {
      emit(state.copyWith(status: OrderQRScanStateStatus.failure, message: 'Считан не поддерживаемый QR код'));
      return;
    }

    if (qrCodeData[3] != QRType.order.typeName) {
      emit(state.copyWith(status: OrderQRScanStateStatus.failure, message: 'QR код не от заказа'));
      return;
    }

    return await _processQR(qrCodeData[4], int.parse(qrCodeData[5]));
  }

  Future<void> _processQR(String qrTrackingNumber, int packageNumber) async {
    OrderQRScanState newState = state;
    List<bool> newOrderPackageScanned = state.orderPackageScanned;

    if (qrTrackingNumber != state.order.trackingNumber) {
      emit(state.copyWith(status: OrderQRScanStateStatus.failure, message: 'QR код другого заказа'));
      return;
    }

    if (state.orderPackageScanned[packageNumber - 1]) {
      emit(state.copyWith(status: OrderQRScanStateStatus.failure, message: 'QR код уже был считан'));
      return;
    }

    newOrderPackageScanned[packageNumber - 1] = true;
    OrderQRScanStateStatus newStatus = newOrderPackageScanned.contains(false) ?
      OrderQRScanStateStatus.scanReadFinished :
      OrderQRScanStateStatus.finished;

    emit(newState.copyWith(orderPackageScanned: newOrderPackageScanned, status: newStatus));
  }
}
