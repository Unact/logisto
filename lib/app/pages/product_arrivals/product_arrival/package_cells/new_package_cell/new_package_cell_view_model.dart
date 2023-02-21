part of 'new_package_cell_page.dart';

class NewPackageCellViewModel extends PageViewModel<NewPackageCellState, NewPackageCellStateStatus> {
  NewPackageCellViewModel(
    BuildContext context,
    {
      required ProductArrivalPackageEx packageEx,
      required StorageCell storageCell
    }
  ) : super(context, NewPackageCellState(packageEx: packageEx, storageCell: storageCell));

  @override
  NewPackageCellStateStatus get status => state.status;

  @override
  Future<void> loadData() async {
    List<Product> products = state.packageEx.packageLines.map((e) => e.product).toSet().toList();

    emit(state.copyWith(status: NewPackageCellStateStatus.dataLoaded, packageLineProducts: products));
  }

  Future<void> findAndSetProductByCode(String code) async {
    emit(state.copyWith(status: NewPackageCellStateStatus.inProgress));

    try {
      List<Product> products = await store.productsRepo.findProduct(code: code);

      if (products.isEmpty) {
        emit(state.copyWith(status: NewPackageCellStateStatus.failure, message: 'Не найден товар'));
        return;
      }

      Product product = products.first;

      if (!state.packageLineProducts.contains(product)) {
        emit(state.copyWith(status: NewPackageCellStateStatus.failure, message: 'Товар не принимался'));
        return;
      }

      setProduct(product);
    } on AppError catch(e) {
      emit(state.copyWith(status: NewPackageCellStateStatus.failure, message: e.message));
    }
  }

  void setProduct(Product product) {
    emit(state.copyWith(
      status: NewPackageCellStateStatus.setProduct,
      product: Optional.fromNullable(product))
    );
  }

  void setAmount(int amount) {
    emit(state.copyWith(
      status: NewPackageCellStateStatus.setAmount,
      amount: Optional.fromNullable(amount))
    );
  }

  Future<void> addProductArrivalPackageNewPackageCell() async {
    if (state.product == null) {
      emit(state.copyWith(status: NewPackageCellStateStatus.failure, message: 'Не указан товар'));
      return;
    }

    if (state.amount == null) {
      emit(state.copyWith(status: NewPackageCellStateStatus.failure, message: 'Не указано кол-во'));
      return;
    }

    ProductArrivalPackageNewCellsCompanion cell = ProductArrivalPackageNewCellsCompanion(
      productArrivalPackageId: Value(state.packageEx.package.id),
      productId: Value(state.product!.id),
      storageCellId: Value(state.storageCell.id),
      amount: Value(state.amount!)
    );

    await store.productArrivalsRepo.addProductArrivalPackageNewCell(cell);

    emit(state.copyWith(
      status: NewPackageCellStateStatus.lineAdded,
      amount: const Optional.absent(),
      product: const Optional.absent()
    ));
  }
}
