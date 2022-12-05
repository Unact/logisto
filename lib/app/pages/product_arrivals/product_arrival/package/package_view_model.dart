part of 'package_page.dart';

class PackageViewModel extends PageViewModel<PackageState, PackageStateStatus> {
  PackageViewModel(BuildContext context, { required ProductArrivalPackageEx packageEx }) :
    super(context, PackageState(packageEx: packageEx));

  @override
  PackageStateStatus get status => state.status;

  @override
  TableUpdateQuery get listenForTables => TableUpdateQuery.onAllTables([
    app.dataStore.productArrivals,
    app.dataStore.productArrivalPackages,
    app.dataStore.productArrivalPackageLines,
    app.dataStore.productArrivalPackageNewLines,
  ]);

  @override
  Future<void> loadData() async {
    int productArrivalPackageId = state.packageEx.package.id;

    emit(state.copyWith(
      status: PackageStateStatus.dataLoaded,
      packageEx: await app.dataStore.productArrivalsDao.getProductArrivalPackageEx(productArrivalPackageId),
      newLines: await app.dataStore.productArrivalsDao.getProductArrivalPackageNewLines(productArrivalPackageId)
    ));
  }

  Future<void> endAccept() async {
    emit(state.copyWith(status: PackageStateStatus.inProgress));

    try {
      await _endAccept(state.packageEx, state.newLines);

      emit(state.copyWith(status: PackageStateStatus.success, message: 'Отмечено завершение разгрузки'));
    } on AppError catch(e) {
      emit(state.copyWith(status: PackageStateStatus.failure, message: e.message));
    }
  }

  Future<void> deleteProductArrivalPackageNewLine(ProductArrivalPackageNewLine packageNewLine) async {
    await app.dataStore.productArrivalsDao.deleteProductArrivalPackageNewLine(packageNewLine);
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
