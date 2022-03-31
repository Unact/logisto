part of 'order_qr_scan_page.dart';

enum OrderQRScanStateStatus {
  initial,
  dataLoaded,
  modeChanged,
  scanReadFinished,
  failure,
  finished
}

enum ScanMode {
  scanner,
  camera
}

class OrderQRScanState {
  OrderQRScanState({
    this.status = OrderQRScanStateStatus.initial,
    required this.order,
    this.orderPackageScanned = const [],
    this.message = '',
    required this.mode,
    this.cameraEnabled = false
  });

  final OrderQRScanStateStatus status;
  final String message;
  final Order order;
  final List<bool> orderPackageScanned;
  final ScanMode mode;
  final bool cameraEnabled;

  bool get scannerEnabled => Platform.isAndroid;

  OrderQRScanState copyWith({
    OrderQRScanStateStatus? status,
    Order? order,
    List<bool>? orderPackageScanned,
    String? message,
    ScanMode? mode,
    bool? cameraEnabled
  }) {
    return OrderQRScanState(
      status: status ?? this.status,
      order: order ?? this.order,
      orderPackageScanned: orderPackageScanned ?? this.orderPackageScanned,
      message: message ?? this.message,
      mode: mode ?? this.mode,
      cameraEnabled: cameraEnabled ?? this.cameraEnabled
    );
  }
}
