part of 'from_cell_page.dart';

class FromCellViewModel extends PageViewModel<FromCellState, FromCellStateStatus> {
  FromCellViewModel(BuildContext context, {
    required ProductTransferEx productTransferEx,
    required StorageCell storageCell
  }) : super(context, FromCellState(productTransferEx: productTransferEx, storageCell: storageCell));

  @override
  FromCellStateStatus get status => state.status;

  @override
  TableUpdateQuery get listenForTables => TableUpdateQuery.onAllTables([
    dataStore.productTransfers,
    dataStore.productTransferFromCells,
    dataStore.productTransferToCells
  ]);

  @override
  Future<void> loadData() async {
    emit(state.copyWith(
      status: FromCellStateStatus.dataLoaded,
      productTransferEx: await store.productTransfersRepo.getCurrentTransfer()
    ));
  }

  Future<List<Product>> findProductsByName(String name) async {
    try {
      return await store.productsRepo.findProduct(name: name);
    } on AppError catch(e) {
      emit(state.copyWith(status: FromCellStateStatus.failure, message: e.message));

      return [];
    }
  }

  Future<void> findAndSetProductByCode(String code) async {
    emit(state.copyWith(status: FromCellStateStatus.inProgress));

    try {
      List<Product> products = await store.productsRepo.findProduct(code: code);

      if (products.isEmpty) {
        emit(state.copyWith(status: FromCellStateStatus.failure, message: 'Не найден товар'));
        return;
      }

      setProduct(products.first);
    } on AppError catch(e) {
      emit(state.copyWith(status: FromCellStateStatus.failure, message: e.message));
    }
  }

  void setProduct(Product product) {
    emit(state.copyWith(
      status: FromCellStateStatus.setProduct,
      product: Optional.fromNullable(product))
    );
  }

  void setAmount(int amount) {
    emit(state.copyWith(
      status: FromCellStateStatus.setAmount,
      amount: Optional.fromNullable(amount))
    );
  }

  Future<void> addProductTransferFromCell() async {
    if (state.product == null) {
      emit(state.copyWith(status: FromCellStateStatus.failure, message: 'Не указан товар'));
      return;
    }

    if (state.amount == null) {
      emit(state.copyWith(status: FromCellStateStatus.failure, message: 'Не указано кол-во'));
      return;
    }

    ProductTransferFromCellsCompanion fromCell = ProductTransferFromCellsCompanion(
      productTransferId: Value(state.productTransferEx.productTransfer.id),
      storageCellId: Value(state.storageCell.id),
      productId: Value(state.product!.id),
      amount: Value(state.amount!)
    );

    await store.productTransfersRepo.addProductTransferFromCell(fromCell);

    emit(state.copyWith(
      status: FromCellStateStatus.cellAdded,
      amount: const Optional.absent(),
      product: const Optional.absent()
    ));
  }
}
