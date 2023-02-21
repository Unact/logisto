part of 'product_arrival_page.dart';

class ProductArrivalViewModel extends PageViewModel<ProductArrivalState, ProductArrivalStateStatus> {
  ProductArrivalViewModel(BuildContext context, { required ProductArrivalEx productArrivalEx }) :
    super(context, ProductArrivalState(productArrivalEx: productArrivalEx));

  @override
  ProductArrivalStateStatus get status => state.status;

  @override
  TableUpdateQuery get listenForTables => TableUpdateQuery.onAllTables([
    dataStore.productArrivals,
    dataStore.productArrivalPackages,
    dataStore.productArrivalUnloadPackages,
    dataStore.productArrivalPackageLines,
    dataStore.productArrivalNewPackages,
    dataStore.productArrivalNewUnloadPackages,
  ]);

  @override
  Future<void> loadData() async {
    int productArrivalId = state.productArrivalEx.productArrival.id;

    emit(state.copyWith(
      status: ProductArrivalStateStatus.dataLoaded,
      productArrivalEx: await store.productArrivalsRepo.getProductArrivalEx(productArrivalId),
      newPackages: await store.productArrivalsRepo.getProductArrivalNewPackages(productArrivalId),
      newUnloadPackages: await store.productArrivalsRepo.getProductArrivalNewUnloadPackages(productArrivalId),
    ));
  }

  Future<void> startUnload(String storageUnloadPointIdStr) async {
    emit(state.copyWith(status: ProductArrivalStateStatus.inProgress));

    try {
      await store.productArrivalsRepo.startUnload(state.productArrivalEx, int.parse(storageUnloadPointIdStr));

      emit(state.copyWith(status: ProductArrivalStateStatus.success, message: 'Отмечено начало разгрузки'));
    } on AppError catch(e) {
      emit(state.copyWith(status: ProductArrivalStateStatus.failure, message: e.message));
    }
  }

  Future<void> endUnload() async {
    emit(state.copyWith(status: ProductArrivalStateStatus.inProgress));

    try {
      await store.productArrivalsRepo.endUnload(state.productArrivalEx, state.newPackages, state.newUnloadPackages);

      emit(state.copyWith(status: ProductArrivalStateStatus.success, message: 'Отмечено завершение разгрузки'));
    } on AppError catch(e) {
      emit(state.copyWith(status: ProductArrivalStateStatus.failure, message: e.message));
    }
  }

  Future<void> printPackagesLabel() async {
    ProductArrivalPackagesLabel(productArrivalEx: state.productArrivalEx).print(
      onError: (String error) => emit(state.copyWith(status: ProductArrivalStateStatus.failure, message: error))
    );
  }

  Future<void> markProductArrivalPackageScanned(ProductArrivalPackageEx? packageEx) async {
    if (packageEx == null) {
      emit(state.copyWith(
        status: ProductArrivalStateStatus.productArrivalPackageScanFail,
        message: 'Место не найдено'
      ));
      return;
    }

    if (packageEx.package.acceptEnd != null) {
      emit(state.copyWith(
        status: ProductArrivalStateStatus.productArrivalPackageScanFail,
        message: 'Приемка места уже завершена'
      ));
      return;
    }

    if (packageEx.package.acceptStart != null) {
      emit(state.copyWith(
        status: ProductArrivalStateStatus.productArrivalPackageScanFail,
        message: 'Приемка места уже начата'
      ));
      return;
    }

    emit(state.copyWith(
      status: ProductArrivalStateStatus.productArrivalPackageScanSuccess,
      scannedProductArrivalPackageEx: packageEx
    ));
  }

  Future<void> startAccept(String storageAcceptPointIdStr) async {
    emit(state.copyWith(status: ProductArrivalStateStatus.inProgress));

    try {
      await store.productArrivalsRepo.startAccept(
        state.scannedProductArrivalPackageEx!,
        int.parse(storageAcceptPointIdStr)
      );

      emit(state.copyWith(status: ProductArrivalStateStatus.success, message: 'Отмечено начало приемки'));
    } on AppError catch(e) {
      emit(state.copyWith(status: ProductArrivalStateStatus.failure, message: e.message));
    }
  }

  Future<void> deleteProductArrivalNewPackage(ProductArrivalNewPackage newPackage) async {
    await store.productArrivalsRepo.deleteProductArrivalNewPackage(newPackage);
  }

  Future<void> deleteProductArrivalNewUnloadPackage(ProductArrivalNewUnloadPackage newUnloadPackage) async {
    await store.productArrivalsRepo.deleteProductArrivalNewUnloadPackage(newUnloadPackage);
  }

  Future<void> copyUnloadPackages() async {
    for (var newUnloadPackage in state.newUnloadPackages) {
      for (var i = 1; i <= newUnloadPackage.amount; i++) {
        ProductArrivalNewPackagesCompanion package = ProductArrivalNewPackagesCompanion(
          productArrivalId: Value(state.productArrivalEx.productArrival.id),
          typeName: Value(newUnloadPackage.typeName),
          typeId: Value(newUnloadPackage.typeId),
          number: const Value(Strings.undefinedNumber)
        );

        await store.productArrivalsRepo.addProductArrivalNewPackage(package);
      }
    }
  }

  void markProductArrivalScanned(String number) {
    if (number != state.productArrival.number) {
      emit(state.copyWith(
        status: ProductArrivalStateStatus.productArrivalScanFail,
        message: 'Отсканирована другая приемка'
      ));
      return;
    }

    emit(state.copyWith(scanned: true, status: ProductArrivalStateStatus.productArrivalScanSuccess));
  }
}
