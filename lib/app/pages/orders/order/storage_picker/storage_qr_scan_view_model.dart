part of 'storage_picker.dart';

class StorageQRScanViewModel extends PageViewModel<StorageQRScanState, StorageQRScanStateStatus> {
  final StoragesRepository storagesRepository;

  StorageQRScanViewModel(this.storagesRepository, {required List<Storage> storages}) :
    super(StorageQRScanState(storages: storages));

  @override
  StorageQRScanStateStatus get status => state.status;

  Future<void> readQRCode(String? qrCode) async {
    if (qrCode == null) return;

    List<String> qrCodeData = qrCode.split(' ');

    if (qrCodeData.length == 1) {
      int? storageId = int.tryParse(qrCodeData[0]);

      if (storageId == null) {
        emit(state.copyWith(status: StorageQRScanStateStatus.failure, message: 'Не удалось считать'));
        return;
      }

      return await _processQR(storageId);
    }

    String version = qrCodeData[0];

    if (version != Strings.qrCodeVersion) {
      emit(state.copyWith(status: StorageQRScanStateStatus.failure, message: 'Считан не поддерживаемый QR код'));
      return;
    }

    if (qrCodeData[3] != QRType.storage.typeName) {
      emit(state.copyWith(status: StorageQRScanStateStatus.failure, message: 'QR код не от склада'));
      return;
    }

    return await _processQR(int.parse(qrCodeData[1]));
  }

  Future<void> _processQR(int storageId) async {
    Storage? storage = await storagesRepository.getStorageById(storageId);

    if (storage == null) {
      emit(state.copyWith(status: StorageQRScanStateStatus.failure, message: 'Склад не найден'));
      return;
    }

    if (state.storages.none((e) => e.id == storageId)) {
      emit(state.copyWith(status: StorageQRScanStateStatus.failure, message: 'Нет прав на склад'));
      return;
    }

    emit(state.copyWith(status: StorageQRScanStateStatus.finished, storage: storage));
  }
}
