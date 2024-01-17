part of 'package_cells_page.dart';

class PackageCellsViewModel extends PageViewModel<PackageCellsState, PackageCellsStateStatus> {
  final StoragesRepository storagesRepository;
  final ProductArrivalsRepository productArrivalsRepository;

  StreamSubscription<List<ProductArrivalEx>>? productArrivalExListSubscription;
  StreamSubscription<List<ProductArrivalPackageNewCellEx>>? productArrivalPackageNewCellExListSubscription;
  StreamSubscription<ProductArrivalPackageEx>? productArrivalPackageExSubscription;

  PackageCellsViewModel(
    this.productArrivalsRepository,
    this.storagesRepository,
    {
      required ProductArrivalPackageEx packageEx
    }
  ) : super(PackageCellsState(packageEx: packageEx));

  @override
  PackageCellsStateStatus get status => state.status;

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    int productArrivalPackageId = state.packageEx.package.id;

    productArrivalPackageExSubscription = productArrivalsRepository
      .watchProductArrivalPackageEx(productArrivalPackageId).listen((event) {
        emit(state.copyWith(status: PackageCellsStateStatus.dataLoaded, packageEx: event));
      });
    productArrivalPackageNewCellExListSubscription = productArrivalsRepository
      .watchProductArrivalPackageNewCellsEx(productArrivalPackageId).listen((event) {
        emit(state.copyWith(status: PackageCellsStateStatus.dataLoaded, newCells: event));
      });
  }

  @override
  Future<void> close() async {
    await super.close();

    await productArrivalPackageExSubscription?.cancel();
    await productArrivalPackageNewCellExListSubscription?.cancel();
  }

  Future<void> setCell(String storageCellIdStr, String storageCellName) async {
    int storageCellId = int.parse(storageCellIdStr);
    StorageCell storageCell = await storagesRepository.addStorageCell(id: storageCellId, name: storageCellName);

    emit(state.copyWith(
      status: PackageCellsStateStatus.setCell,
      storageCell: Optional.of(storageCell)
    ));
  }

  Future<void> placeProducts() async {
    emit(state.copyWith(status: PackageCellsStateStatus.inProgress));

    try {
      await productArrivalsRepository.placeProducts(state.packageEx, state.newCells);

      emit(state.copyWith(status: PackageCellsStateStatus.success, message: 'Отмечено завершение разгрузки'));
    } on AppError catch(e) {
      emit(state.copyWith(status: PackageCellsStateStatus.failure, message: e.message));
    }
  }

  Future<void> deleteProductArrivalPackageNewCell(ProductArrivalPackageNewCellEx packageNewCellEx) async {
    await productArrivalsRepository.deleteProductArrivalPackageNewCell(packageNewCellEx.newCell);
  }
}
