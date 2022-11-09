part of 'product_arrival_package_page.dart';

class ProductArrivalPackageViewModel extends PageViewModel<ProductArrivalPackageState, ProductArrivalStateStatus> {
  ProductArrivalPackageViewModel(BuildContext context, { required ProductArrivalPackageEx packageEx }) :
    super(context, ProductArrivalPackageState(packageEx: packageEx));

  @override
  ProductArrivalStateStatus get status => state.status;

  @override
  TableUpdateQuery get listenForTables => TableUpdateQuery.onAllTables([
    app.dataStore.users,
    app.dataStore.productArrivals,
    app.dataStore.productArrivalPackages,
    app.dataStore.productArrivalPackageLines,
    app.dataStore.productArrivalPackageNewLines,
    app.dataStore.productArrivalNewPackages,
  ]);

  @override
  Future<void> loadData() async {
    int productArrivalPackageId = state.packageEx.package.id;

    emit(state.copyWith(
      status: ProductArrivalStateStatus.dataLoaded,
      packageEx: await app.dataStore.productArrivalsDao.getProductArrivalPackageEx(productArrivalPackageId),
      newLines: await app.dataStore.productArrivalsDao.getProductArrivalPackageNewLines(productArrivalPackageId)
    ));
  }

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    emit(state.copyWith(status: ProductArrivalStateStatus.startLoad));
  }

  Future<void> endAccept() async {
    emit(state.copyWith(status: ProductArrivalStateStatus.inProgress));

    try {
      await _endAccept(state.packageEx, state.newLines);

      emit(state.copyWith(status: ProductArrivalStateStatus.success, message: 'Отмечено завершение разгрузки'));
    } on AppError catch(e) {
      emit(state.copyWith(status: ProductArrivalStateStatus.failure, message: e.message));
    }
  }

  Future<void> _endAccept(ProductArrivalPackageEx packageEx, List<ProductArrivalPackageNewLine> newLines) async {
    try {
      ApiProductArrival newApiProductArrival = await Api(dataStore: app.dataStore).productArrivalsFinishPackageAccept(
        id: packageEx.package.id,
        lines: newLines.map((e) => { 'productId': e.productId, 'amount': e.amount }).toList()
      );

      await app.dataStore.productArrivalsDao.clearProductArrivalPackageNewLines();
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
