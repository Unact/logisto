part of 'product_transfer_page.dart';

class ProductTransferViewModel extends PageViewModel<ProductTransferState, ProductTransferStateStatus> {
  ProductTransferViewModel(BuildContext context, { required ProductTransferEx productTransferEx }) :
    super(context, ProductTransferState(productTransferEx: productTransferEx));

  @override
  ProductTransferStateStatus get status => state.status;

  @override
  TableUpdateQuery get listenForTables => TableUpdateQuery.onAllTables([
    dataStore.productTransfers,
    dataStore.productTransferFromCells,
    dataStore.productTransferToCells
  ]);

  @override
  Future<void> loadData() async {
    emit(state.copyWith(
      status: ProductTransferStateStatus.dataLoaded,
      user: await store.usersRepo.getUser(),
      productStores: await store.productsRepo.getProductStores(),
      productTransferEx: await store.productTransfersRepo.getCurrentTransfer()
    ));
  }

  Future<void> scanCell(String storageCellIdStr, String storageCellName) async {
    int storageCellId = int.parse(storageCellIdStr);
    StorageCell storageCell = StorageCell(id: storageCellId, name: storageCellName);

    await store.storagesRepo.addStorageCell(storageCell);

    if (state.gatherFinished) {
      emit(state.copyWith(
        status: ProductTransferStateStatus.addToCell,
        scannedStorageCell: Optional.of(storageCell)
      ));
      return;
    }

    emit(state.copyWith(
      status: ProductTransferStateStatus.addFromCell,
      scannedStorageCell: Optional.of(storageCell)
    ));
  }

  Future<void> setComment(String comment) async {
    await store.productTransfersRepo.upsertProductTransfer(
      state.productTransferEx.productTransfer.toCompanion(false).copyWith(comment: Value(comment))
    );
  }

  Future<void> setProductStoreFrom(String productStoreId) async {
    await store.productTransfersRepo.upsertProductTransfer(
      state.productTransferEx.productTransfer.toCompanion(false).copyWith(storeFromId: Value(productStoreId))
    );
  }

  Future<void> setProductStoreTo(String productStoreId) async {
    await store.productTransfersRepo.upsertProductTransfer(
      state.productTransferEx.productTransfer.toCompanion(false).copyWith(storeToId: Value(productStoreId))
    );
  }

  Future<void> deleteFromCell(ProductTransferFromCellEx fromCellEx) async {
    await store.productTransfersRepo.deleteProductTransferFromCell(fromCellEx);
  }

  Future<void> deleteToCell(ProductTransferToCellEx toCellEx) async {
    await store.productTransfersRepo.deleteProductTransferToCell(toCellEx);
  }

  Future<void> finishTransfer() async {
    emit(state.copyWith(status: ProductTransferStateStatus.inProgress));

    if (state.productTransferEx.storeFrom == null) {
      emit(state.copyWith(status: ProductTransferStateStatus.failure, message: 'Не указан склад отправитель'));
      return;
    }

    if (state.productTransferEx.storeTo == null) {
      emit(state.copyWith(status: ProductTransferStateStatus.failure, message: 'Не указан склад получатель'));
      return;
    }

    try {
      await store.productTransfersRepo.finishProductTransfer(state.productTransferEx);

      emit(state.copyWith(status: ProductTransferStateStatus.success, message: 'Перемещение успешно произведено'));
    } on AppError catch(e) {
      emit(state.copyWith(status: ProductTransferStateStatus.failure, message: e.message));
    }
  }

  Future<void> finishGather() async {
    await store.productTransfersRepo.finishProductTransferGather(state.productTransferEx);

    emit(state.copyWith(
      status: ProductTransferStateStatus.gatherFinished,
      message: 'Изъятие товаров завершено успешно'
    ));
  }

  Future<void> cancelGather() async {
    await store.productTransfersRepo.cancelProductTransferGather(state.productTransferEx);

    emit(state.copyWith(
      status: ProductTransferStateStatus.gatherFinishCanceled,
      message: 'Изъятие товаров успешно отменено'
    ));
  }

  Future<void> printProductLabel(Product product, int amount) async {
    await ProductLabel(product: product, user: state.user!).print(
      amount: amount,
      onError: (String error) => emit(state.copyWith(status: ProductTransferStateStatus.failure, message: error))
    );
  }
}
