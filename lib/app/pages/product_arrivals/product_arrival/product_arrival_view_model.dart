part of 'product_arrival_page.dart';

class ProductArrivalViewModel extends PageViewModel<ProductArrivalState, ProductArrivalStateStatus> {
  ProductArrivalViewModel(BuildContext context, { required ProductArrivalEx productArrivalEx }) :
    super(context, ProductArrivalState(productArrivalEx: productArrivalEx));

  @override
  ProductArrivalStateStatus get status => state.status;

  @override
  TableUpdateQuery get listenForTables => TableUpdateQuery.onAllTables([
    app.dataStore.productArrivals,
    app.dataStore.productArrivalPackages,
    app.dataStore.productArrivalPackageLines,
    app.dataStore.productArrivalNewPackages,
  ]);

  @override
  Future<void> loadData() async {
    int productArrivalId = state.productArrivalEx.productArrival.id;

    emit(state.copyWith(
      status: ProductArrivalStateStatus.dataLoaded,
      productArrivalEx: await app.dataStore.productArrivalsDao.getProductArrivalEx(productArrivalId),
      newPackages: await app.dataStore.productArrivalsDao.getProductArrivalNewPackages(productArrivalId)
    ));
  }

  Future<void> startUnload() async {
    emit(state.copyWith(status: ProductArrivalStateStatus.inProgress));

    try {
      await _startUnload(state.productArrivalEx);

      emit(state.copyWith(status: ProductArrivalStateStatus.success, message: 'Отмечено начало разгрузки'));
    } on AppError catch(e) {
      emit(state.copyWith(status: ProductArrivalStateStatus.failure, message: e.message));
    }
  }

  Future<void> endUnload() async {
    emit(state.copyWith(status: ProductArrivalStateStatus.inProgress));

    try {
      await _endUnload(state.productArrivalEx, state.newPackages);

      emit(state.copyWith(status: ProductArrivalStateStatus.success, message: 'Отмечено завершение разгрузки'));
    } on AppError catch(e) {
      emit(state.copyWith(status: ProductArrivalStateStatus.failure, message: e.message));
    }
  }

  Future<void> startAccept(ProductArrivalPackageEx? packageEx) async {
    if (packageEx == null) {
      emit(state.copyWith(status: ProductArrivalStateStatus.failure, message: 'Место не найдено'));
      return;
    }

    if (packageEx.package.acceptEnd != null) {
      emit(state.copyWith(status: ProductArrivalStateStatus.failure, message: 'Приемка места уже завершена'));
      return;
    }

    if (packageEx.package.acceptStart != null) {
      emit(state.copyWith(status: ProductArrivalStateStatus.failure, message: 'Приемка места уже начата'));
      return;
    }

    emit(state.copyWith(status: ProductArrivalStateStatus.inProgress));

    try {
      await _startAccept(packageEx);

      emit(state.copyWith(status: ProductArrivalStateStatus.success, message: 'Отмечено начало приемки'));
    } on AppError catch(e) {
      emit(state.copyWith(status: ProductArrivalStateStatus.failure, message: e.message));
    }
  }

  Future<void> deleteProductArrivalNewPackage(ProductArrivalNewPackage newPackage) async {
    await app.dataStore.productArrivalsDao.deleteProductArrivalNewPackage(newPackage);
  }

  Future<void> _startUnload(ProductArrivalEx productArrivalEx) async {
    try {
      ApiProductArrival newApiProductArrival = await Api(dataStore: app.dataStore).productArrivalsBeginUnload(
        id: productArrivalEx.productArrival.id
      );

      await _saveProductArrival(newApiProductArrival);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await app.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> _endUnload(ProductArrivalEx productArrivalEx, List<ProductArrivalNewPackage> newPackages) async {
    try {
      ApiProductArrival newApiProductArrival = await Api(dataStore: app.dataStore).productArrivalsFinishUnload(
        id: productArrivalEx.productArrival.id,
        packages: newPackages.map((e) => { 'productArrivalPackageTypeId': e.typeId }).toList()
      );

      await app.dataStore.productArrivalsDao.clearProductArrivalNewPackages();
      await _saveProductArrival(newApiProductArrival);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await app.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> _startAccept(ProductArrivalPackageEx productArrivalEx) async {
    try {
      ApiProductArrival newApiProductArrival = await Api(dataStore: app.dataStore).productArrivalsBeginPackageAccept(
        id: productArrivalEx.package.id
      );

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
