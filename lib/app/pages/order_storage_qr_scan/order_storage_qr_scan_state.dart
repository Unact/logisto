part of 'order_storage_qr_scan_page.dart';

enum OrderStorageQrScanStateStatus {
  initial,
  dataLoaded,
  modeChanged,
  scanReadFinished,
  failure,
  finished
}

class StorageQrScanState {
  StorageQrScanState({
    this.status = OrderStorageQrScanStateStatus.initial,
    this.orderStorage,
    this.message = '',
    this.hasScanner
  });

  final OrderStorageQrScanStateStatus status;
  final String message;
  final OrderStorage? orderStorage;
  final bool? hasScanner;

  StorageQrScanState copyWith({
    OrderStorageQrScanStateStatus? status,
    Order? order,
    OrderStorage? orderStorage,
    String? message,
    bool? hasScanner
  }) {
    return StorageQrScanState(
      status: status ?? this.status,
      orderStorage: orderStorage ?? this.orderStorage,
      message: message ?? this.message,
      hasScanner: hasScanner ?? this.hasScanner
    );
  }
}
