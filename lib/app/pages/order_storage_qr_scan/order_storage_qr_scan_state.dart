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
    this.message = ''
  });

  final OrderStorageQrScanStateStatus status;
  final String message;
  final OrderStorage? orderStorage;
  final List<OrderStorage> orderStorages;

  StorageQrScanState copyWith({
    OrderStorageQrScanStateStatus? status,
    OrderStorage? orderStorage,
    List<OrderStorage>? orderStorages,
    String? message
  }) {
    return StorageQrScanState(
      status: status ?? this.status,
      orderStorage: orderStorage ?? this.orderStorage,
      orderStorages: orderStorages ?? this.orderStorages,
      message: message ?? this.message
    );
  }
}
