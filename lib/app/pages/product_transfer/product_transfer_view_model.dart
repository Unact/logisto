part of 'product_transfer_page.dart';

class ProductTransferViewModel extends PageViewModel<ProductTransferState, ProductTransferStateStatus> {
  final ProductTransfersRepository productTransfersRepository;
  final ProductsRepository productsRepository;
  final StoragesRepository storagesRepository;

  StreamSubscription<List<ProductStore>>? productStoresSubscription;
  StreamSubscription<ProductTransferEx?>? productTransferExSubscription;

  ProductTransferViewModel(
    this.productTransfersRepository,
    this.productsRepository,
    this.storagesRepository,
    {
      required ProductTransferEx productTransferEx
    }
  ) : super(ProductTransferState(productTransferEx: productTransferEx));

  @override
  ProductTransferStateStatus get status => state.status;

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    productStoresSubscription = productsRepository.watchProductStores().listen((event) {
      emit(state.copyWith(status: ProductTransferStateStatus.dataLoaded, productStores: event));
    });
    productTransferExSubscription = productTransfersRepository.watchCurrentTransfer().listen((event) {
      emit(state.copyWith(status: ProductTransferStateStatus.dataLoaded, productTransferEx: event));
    });
  }

  @override
  Future<void> close() async {
    await super.close();

    await productStoresSubscription?.cancel();
    await productTransferExSubscription?.cancel();
  }

  Future<void> scanCell(String storageCellIdStr, String storageCellName) async {
    int storageCellId = int.parse(storageCellIdStr);
    StorageCell storageCell = await storagesRepository.addStorageCell(id: storageCellId, name: storageCellName);

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
    await productTransfersRepository.upsertProductTransfer(
      state.productTransferEx.productTransfer,
      comment: Optional.of(comment)
    );
  }

  Future<void> setProductStoreFrom(String productStoreId) async {
    await productTransfersRepository.upsertProductTransfer(
      state.productTransferEx.productTransfer,
      storeFromId: Optional.of(productStoreId)
    );
  }

  Future<void> setProductStoreTo(String productStoreId) async {
    await productTransfersRepository.upsertProductTransfer(
      state.productTransferEx.productTransfer,
      storeToId: Optional.of(productStoreId)
    );
  }

  Future<void> deleteFromCell(ProductTransferFromCellEx fromCellEx) async {
    await productTransfersRepository.deleteProductTransferFromCell(fromCellEx);
  }

  Future<void> deleteToCell(ProductTransferToCellEx toCellEx) async {
    await productTransfersRepository.deleteProductTransferToCell(toCellEx);
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
      await productTransfersRepository.finishProductTransfer(state.productTransferEx);

      emit(state.copyWith(status: ProductTransferStateStatus.success, message: 'Перемещение успешно произведено'));
    } on AppError catch(e) {
      emit(state.copyWith(status: ProductTransferStateStatus.failure, message: e.message));
    }
  }

  Future<void> finishGather() async {
    await productTransfersRepository.finishProductTransferGather(state.productTransferEx);

    emit(state.copyWith(
      status: ProductTransferStateStatus.gatherFinished,
      message: 'Изъятие товаров завершено успешно'
    ));
  }

  Future<void> cancelGather() async {
    await productTransfersRepository.cancelProductTransferGather(state.productTransferEx);

    emit(state.copyWith(
      status: ProductTransferStateStatus.gatherFinishCanceled,
      message: 'Изъятие товаров успешно отменено'
    ));
  }
}
