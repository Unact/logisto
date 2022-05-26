part of 'order_qr_scan_page.dart';

class OrderQRScanViewModel extends PageViewModel<OrderQRScanState, OrderQRScanStateStatus> {
  OrderQRScanViewModel(BuildContext context, { required Order order }) :
    super(
      context,
      OrderQRScanState(
        order: order,
        orderPackageScanned: List.filled(order.packages, false),
      )
    );

  @override
  OrderQRScanStateStatus get status => state.status;

  @override
  Future<void> loadData() async {
    emit(state.copyWith(
      status: OrderQRScanStateStatus.dataLoaded
    ));
  }

  Future<void> readQRCode(String? qrCode) async {
    if (qrCode == null) return;

    List<String> qrCodeData = qrCode.split(' ');
    OrderQRScanState newState = state;
    List<bool> newOrderPackageScanned = state.orderPackageScanned;

    if (qrCodeData.length < 3 || qrCodeData[0] != Strings.qrCodeVersion) {
      emit(state.copyWith(status: OrderQRScanStateStatus.failure, message: 'Считан не поддерживаемый QR код'));
      return;
    }

    String qrTrackingNumber = qrCodeData[1];
    int packageNumber = int.tryParse(qrCodeData[2]) ?? 1;

    if (qrTrackingNumber != state.order.trackingNumber) {
      emit(state.copyWith(status: OrderQRScanStateStatus.failure, message: 'Считан QR код другого заказа'));
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
