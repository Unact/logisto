part of 'to_cell_page.dart';

class ToCellViewModel extends PageViewModel<ToCellState, ToCellStateStatus> {
  ToCellViewModel(
    BuildContext context,
    {
      required ProductTransferEx productTransferEx,
      required StorageCell storageCell
    }
  ) : super(context, ToCellState(productTransferEx: productTransferEx, storageCell: storageCell));

  @override
  ToCellStateStatus get status => state.status;

  @override
  TableUpdateQuery get listenForTables => TableUpdateQuery.onAllTables([
    dataStore.productTransfers,
    dataStore.productTransferFromCells,
    dataStore.productTransferToCells
  ]);

  @override
  Future<void> loadData() async {
    emit(state.copyWith(
      status: ToCellStateStatus.dataLoaded,
      productTransferEx: await store.productTransfersRepo.getCurrentTransfer()
    ));
  }

  Future<void> findAndSetProductByCode(String code) async {
    emit(state.copyWith(status: ToCellStateStatus.inProgress));

    try {
      List<Product> products = await store.productsRepo.findProduct(code: code);

      if (products.isEmpty) {
        emit(state.copyWith(status: ToCellStateStatus.failure, message: 'Не найден товар'));
        return;
      }

      Product product = products.first;

      if (!state.fromCellsProducts.contains(product)) {
        emit(state.copyWith(status: ToCellStateStatus.failure, message: 'Товар не принимался'));
        return;
      }

      setProduct(product);
    } on AppError catch(e) {
      emit(state.copyWith(status: ToCellStateStatus.failure, message: e.message));
    }
  }

  void setProduct(Product product) {
    emit(state.copyWith(
      status: ToCellStateStatus.setProduct,
      product: Optional.fromNullable(product))
    );
  }

  void setAmount(int amount) {
    emit(state.copyWith(
      status: ToCellStateStatus.setAmount,
      amount: Optional.fromNullable(amount))
    );
  }

  Future<void> addProductTransferToCell() async {
    int productFromCellsAmount = state.productTransferEx.fromCells.fold(
      0,
      (prev, e) => prev + (e.product == state.product ? e.fromCell.amount : 0)
    );
    int productToCellsAmount = state.productTransferEx.toCells.fold(
      0,
      (prev, e) => prev + (e.product == state.product ? e.toCell.amount : 0)
    );

    if (state.product == null) {
      emit(state.copyWith(status: ToCellStateStatus.failure, message: 'Не указан товар'));
      return;
    }

    if (state.amount == null) {
      emit(state.copyWith(status: ToCellStateStatus.failure, message: 'Не указано кол-во'));
      return;
    }

    if (productFromCellsAmount < productToCellsAmount + state.amount!) {
      emit(state.copyWith(status: ToCellStateStatus.failure, message: 'Нельзя разместить товара больше чем изъято'));
      return;
    }

    ProductTransferToCellsCompanion cell = ProductTransferToCellsCompanion(
      productTransferId: Value(state.productTransferEx.productTransfer.id),
      productId: Value(state.product!.id),
      storageCellId: Value(state.storageCell.id),
      amount: Value(state.amount!)
    );

    await store.productTransfersRepo.addProductTransferToCell(cell);

    emit(state.copyWith(
      status: ToCellStateStatus.cellAdded,
      amount: const Optional.absent(),
      product: const Optional.absent()
    ));
  }
}
