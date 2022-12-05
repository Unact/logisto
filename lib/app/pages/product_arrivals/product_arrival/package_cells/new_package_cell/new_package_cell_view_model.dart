part of 'new_package_cell_page.dart';

class NewPackageCellViewModel extends PageViewModel<NewPackageCellState, NewPackageCellStateStatus> {
  NewPackageCellViewModel(
    BuildContext context,
    {
      required ProductArrivalPackageEx packageEx,
      required ApiStorageCell storageCell
    }
  ) : super(context, NewPackageCellState(packageEx: packageEx, storageCell: storageCell));

  @override
  NewPackageCellStateStatus get status => state.status;

  @override
  Future<void> loadData() async {
    List<ApiProduct> products = state.packageEx.packageLines.map(
      (e) => ApiProduct(id: e.productId, name: e.productName)
    ).toSet().toList();

    emit(state.copyWith(status: NewPackageCellStateStatus.dataLoaded, packageLineProducts: products));
  }

  Future<void> findAndSetProductByCode(String code) async {
    emit(state.copyWith(status: NewPackageCellStateStatus.inProgress));

    try {
      List<ApiProduct> products = await _findProduct(code: code);

      if (products.isEmpty) {
        emit(state.copyWith(status: NewPackageCellStateStatus.failure, message: 'Не найден товар'));
        return;
      }

      ApiProduct product = products.first;

      if (!state.packageLineProducts.contains(product)) {
        emit(state.copyWith(status: NewPackageCellStateStatus.failure, message: 'Товар не принимался'));
        return;
      }

      setProduct(product);
    } on AppError catch(e) {
      emit(state.copyWith(status: NewPackageCellStateStatus.failure, message: e.message));
    }
  }

  void setProduct(ApiProduct product) {
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
      productName: Value(state.product!.name),
      productId: Value(state.product!.id),
      storageCellId: Value(state.storageCell.id),
      storageCellName: Value(state.storageCell.name),
      amount: Value(state.amount!)
    );

  await app.dataStore.productArrivalsDao.addProductArrivalPackageNewCell(cell);

    emit(state.copyWith(status: NewPackageCellStateStatus.lineAdded));
  }

  Future<List<ApiProduct>> _findProduct({String? code, String? name}) async {
    try {
      return await Api(dataStore: app.dataStore).productArrivalFindProduct(code: code, name: name);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await app.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }
}
