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
    required this.orderStorages,
    this.status = OrderStorageQrScanStateStatus.initial,
    this.orderStorage,
    this.message = '',
    this.hasScanner
  });

  final OrderStorageQrScanStateStatus status;
  final String message;
  final OrderStorage? orderStorage;
  final List<OrderStorage> orderStorages;
  final bool? hasScanner;

  StorageQrScanState copyWith({
    OrderStorageQrScanStateStatus? status,
    Order? order,
    OrderStorage? orderStorage,
    List<OrderStorage>? orderStorages,
    String? message,
    bool? hasScanner
  }) {
    return StorageQrScanState(
      status: status ?? this.status,
      orderStorage: orderStorage ?? this.orderStorage,
      orderStorages: orderStorages ?? this.orderStorages,
      message: message ?? this.message,
      hasScanner: hasScanner ?? this.hasScanner
    );
  }
}
