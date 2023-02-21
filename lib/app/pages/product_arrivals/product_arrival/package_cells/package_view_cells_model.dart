part of 'package_cells_page.dart';

class PackageCellsViewModel extends PageViewModel<PackageCellsState, PackageCellsStateStatus> {
  PackageCellsViewModel(BuildContext context, { required ProductArrivalPackageEx packageEx }) :
    super(context, PackageCellsState(packageEx: packageEx));

  @override
  PackageCellsStateStatus get status => state.status;

  @override
  TableUpdateQuery get listenForTables => TableUpdateQuery.onAllTables([
    dataStore.productArrivals,
    dataStore.productArrivalPackages,
    dataStore.productArrivalPackageNewCells,
  ]);

  @override
  Future<void> loadData() async {
    int productArrivalPackageId = state.packageEx.package.id;

    emit(state.copyWith(
      status: PackageCellsStateStatus.dataLoaded,
      user: await store.usersRepo.getUser(),
      packageEx: await store.productArrivalsRepo.getProductArrivalPackageEx(productArrivalPackageId),
      newCells: await store.productArrivalsRepo.getProductArrivalPackageNewCellsEx(productArrivalPackageId)
    ));
  }

  Future<void> setCell(String storageCellIdStr, String storageCellName) async {
    int storageCellId = int.parse(storageCellIdStr);
    StorageCell storageCell = StorageCell(id: storageCellId, name: storageCellName);

    await store.storagesRepo.addStorageCell(storageCell);

    emit(state.copyWith(
      status: PackageCellsStateStatus.setCell,
      storageCell: Optional.of(storageCell)
    ));
  }

  Future<void> placeProducts() async {
    emit(state.copyWith(status: PackageCellsStateStatus.inProgress));

    try {
      await store.productArrivalsRepo.placeProducts(state.packageEx, state.newCells);

      emit(state.copyWith(status: PackageCellsStateStatus.success, message: 'Отмечено завершение разгрузки'));
    } on AppError catch(e) {
      emit(state.copyWith(status: PackageCellsStateStatus.failure, message: e.message));
    }
  }

  Future<void> deleteProductArrivalPackageNewCell(ProductArrivalPackageNewCellEx packageNewCellEx) async {
    await store.productArrivalsRepo.deleteProductArrivalPackageNewCell(packageNewCellEx.newCell);
  }

  Future<void> printProductLabel(Product product, int amount) async {
    await ProductLabel(product: product, user: state.user!).print(
      amount: amount,
      onError: (String error) => emit(state.copyWith(status: PackageCellsStateStatus.failure, message: error))
    );
  }
}
