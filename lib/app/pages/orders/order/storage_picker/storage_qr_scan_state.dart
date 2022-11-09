part of 'storage_picker.dart';

enum StorageQRScanStateStatus {
  initial,
  dataLoaded,
  modeChanged,
  scanReadFinished,
  failure,
  finished
}

class StorageQRScanState {
  StorageQRScanState({
    required this.storages,
    this.status = StorageQRScanStateStatus.initial,
    this.storage,
    this.message = ''
  });

  final StorageQRScanStateStatus status;
  final String message;
  final Storage? storage;
  final List<Storage> storages;

  StorageQRScanState copyWith({
    StorageQRScanStateStatus? status,
    Storage? storage,
    List<Storage>? storages,
    String? message
  }) {
    return StorageQRScanState(
      status: status ?? this.status,
      storage: storage ?? this.storage,
      storages: storages ?? this.storages,
      message: message ?? this.message
    );
  }
}
