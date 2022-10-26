part of 'storage_qr_scan_page.dart';

enum StorageQrScanStateStatus {
  initial,
  dataLoaded,
  modeChanged,
  scanReadFinished,
  failure,
  finished
}

class StorageQrScanState {
  StorageQrScanState({
    required this.storages,
    this.status = StorageQrScanStateStatus.initial,
    this.storage,
    this.message = ''
  });

  final StorageQrScanStateStatus status;
  final String message;
  final Storage? storage;
  final List<Storage> storages;

  StorageQrScanState copyWith({
    StorageQrScanStateStatus? status,
    Storage? storage,
    List<Storage>? storages,
    String? message
  }) {
    return StorageQrScanState(
      status: status ?? this.status,
      storage: storage ?? this.storage,
      storages: storages ?? this.storages,
      message: message ?? this.message
    );
  }
}
