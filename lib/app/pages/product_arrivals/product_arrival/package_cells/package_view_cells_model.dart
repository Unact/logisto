part of 'package_cells_page.dart';

class PackageCellsViewModel extends PageViewModel<PackageCellsState, PackageCellsStateStatus> {
  PackageCellsViewModel(BuildContext context, { required ProductArrivalPackageEx packageEx }) :
    super(context, PackageCellsState(packageEx: packageEx));

  @override
  PackageCellsStateStatus get status => state.status;

  @override
  TableUpdateQuery get listenForTables => TableUpdateQuery.onAllTables([
    app.dataStore.productArrivals,
    app.dataStore.productArrivalPackages,
    app.dataStore.productArrivalPackageNewCells,
  ]);

  @override
  Future<void> loadData() async {
    int productArrivalPackageId = state.packageEx.package.id;

    emit(state.copyWith(
      status: PackageCellsStateStatus.dataLoaded,
      packageEx: await app.dataStore.productArrivalsDao.getProductArrivalPackageEx(productArrivalPackageId),
      newCells: await app.dataStore.productArrivalsDao.getProductArrivalPackageNewCellsEx(productArrivalPackageId)
    ));
  }

  void setCell(String storageCellIdStr, String storageCellName) {
    int storageCellId = int.parse(storageCellIdStr);

    emit(state.copyWith(
      status: PackageCellsStateStatus.setCell,
      storageCell: Optional.of(ApiStorageCell(id: storageCellId, name: storageCellName))
    ));
  }

  Future<void> placeProducts() async {
    emit(state.copyWith(status: PackageCellsStateStatus.inProgress));

    try {
      await _placeProducts(state.packageEx, state.newCells);

      emit(state.copyWith(status: PackageCellsStateStatus.success, message: 'Отмечено завершение разгрузки'));
    } on AppError catch(e) {
      emit(state.copyWith(status: PackageCellsStateStatus.failure, message: e.message));
    }
  }

  Future<void> deleteProductArrivalPackageNewCell(ProductArrivalPackageNewCellEx packageNewCellEx) async {
    await app.dataStore.productArrivalsDao.deleteProductArrivalPackageNewCell(packageNewCellEx.newCell);
  }

  Future<void> printProductSticker(ProductArrivalPackageNewCellEx packageNewCellEx) async {

  }

  Future<void> _placeProducts(
    ProductArrivalPackageEx packageEx,
    List<ProductArrivalPackageNewCellEx> newCellsEx
  ) async {
    try {
      ApiProductArrival newApiProductArrival = await Api(dataStore: app.dataStore).productArrivalsPlacePackageProducts(
        id: packageEx.package.id,
        cells: newCellsEx.map((e) => {
          'storageCellId': e.newCell.storageCellId,
          'productId': e.newCell.productId,
          'amount': e.newCell.amount
        }).toList()
      );

      await app.dataStore.productArrivalsDao.clearProductArrivalPackageNewCells();
      await _saveProductArrival(newApiProductArrival);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await app.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> _saveProductArrival(ApiProductArrival apiProductArrival) async {
    ProductArrivalEx productArrivalEx = apiProductArrival.toDatabaseEnt();

    await app.dataStore.transaction(() async {
      await app.dataStore.productArrivalsDao.updateProductArrivalEx(productArrivalEx);
      await app.dataStore.storagesDao.addStorage(productArrivalEx.storage);
    });
  }
}
