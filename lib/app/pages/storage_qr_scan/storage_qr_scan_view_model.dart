part of 'storage_qr_scan_page.dart';

class StorageQrScanViewModel extends PageViewModel<StorageQrScanState, StorageQrScanStateStatus> {
  StorageQrScanViewModel(BuildContext context, { required List<Storage> storages }) :
    super(context, StorageQrScanState(storages: storages));

  @override
  StorageQrScanStateStatus get status => state.status;

  @override
  Future<void> loadData() async {
    emit(state.copyWith(
      status: StorageQrScanStateStatus.dataLoaded
    ));
  }
  Future<void> readQRCode(String? qr) async {
    if (qr == null) return;

    int? storageId = int.tryParse(qr);

    if (storageId == null) {
      emit(state.copyWith(status: StorageQrScanStateStatus.failure, message: 'Не удалось считать'));
      return;
    }

    Storage? storage = await app.dataStore.storagesDao.getStorageById(storageId);

    if (storage == null) {
      emit(state.copyWith(status: StorageQrScanStateStatus.failure, message: 'Склад не найден'));
      return;
    }

    if (state.storages.none((e) => e.id == storageId)) {
      emit(state.copyWith(status: StorageQrScanStateStatus.failure, message: 'Нет прав на склад'));
      return;
    }

    emit(state.copyWith(status: StorageQrScanStateStatus.finished, storage: storage));
  }
}
