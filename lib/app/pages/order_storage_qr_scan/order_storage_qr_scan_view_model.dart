part of 'order_storage_qr_scan_page.dart';

class OrderStorageQrScanViewModel extends PageViewModel<StorageQrScanState, OrderStorageQrScanStateStatus> {
  OrderStorageQrScanViewModel(BuildContext context, { required List<OrderStorage> orderStorages }) :
    super(context, StorageQrScanState(orderStorages: orderStorages));

  @override
  OrderStorageQrScanStateStatus get status => state.status;

  @override
  Future<void> loadData() async {
    emit(state.copyWith(
      status: OrderStorageQrScanStateStatus.dataLoaded,
      hasScanner: await Misc.hasScanner()
    ));
  }
  Future<void> readQr(String? qr) async {
    if (qr == null) return;

    int? storageId = int.tryParse(qr);

    if (storageId == null) {
      emit(state.copyWith(status: OrderStorageQrScanStateStatus.failure, message: 'Не удалось считать'));
      return;
    }

    OrderStorage? orderStorage = await app.storage.orderStoragesDao.getOrderStorageById(storageId);

    if (orderStorage == null) {
      emit(state.copyWith(status: OrderStorageQrScanStateStatus.failure, message: 'Склад не найден'));
      return;
    }

    if (state.orderStorages.none((e) => e.id == storageId)) {
      emit(state.copyWith(status: OrderStorageQrScanStateStatus.failure, message: 'Нет прав на склад'));
      return;
    }

    emit(state.copyWith(status: OrderStorageQrScanStateStatus.finished, orderStorage: orderStorage));
  }
}
