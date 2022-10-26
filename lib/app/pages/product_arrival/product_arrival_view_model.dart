part of 'product_arrival_page.dart';

class ProductArrivalViewModel extends PageViewModel<ProductArrivalState, ProductArrivalStateStatus> {
  ProductArrivalViewModel(BuildContext context, { required ProductArrivalEx productArrivalEx }) :
    super(context, ProductArrivalState(productArrivalEx: productArrivalEx));

  @override
  ProductArrivalStateStatus get status => state.status;

  @override
  TableUpdateQuery get listenForTables => TableUpdateQuery.onAllTables([
    app.dataStore.users,
    app.dataStore.productArrivals,
    app.dataStore.productArrivalPackages,
    app.dataStore.productArrivalPackageLines,
    app.dataStore.productArrivalPackageNewLines,
  ]);

  @override
  Future<void> loadData() async {
    emit(state.copyWith(
      status: ProductArrivalStateStatus.dataLoaded,
      productArrivalEx: await app.dataStore.productArrivalsDao.getProductPackageEx(
        state.productArrivalEx.productArrival.id
      ),
      newLines: await app.dataStore.productArrivalsDao.getProductArrivalPackageNewLines()
    ));
  }

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    emit(state.copyWith(status: ProductArrivalStateStatus.startLoad));
  }

  Future<void> findProductArrivalPackage(String code) async {
    List<ProductArrivalPackageEx> packageExList = state.productArrivalEx.packages;
    int? productArrivalPackageId = int.tryParse(code);
    ProductArrivalPackageEx? packageEx = packageExList.firstWhereOrNull(
      (e) => e.package.id == productArrivalPackageId
    );

    if (state.packageInProgress != null) {
      emit(state.copyWith(status: ProductArrivalStateStatus.failure, message: 'Приемка места не завершена'));
      return;
    }

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

  Future<void> addProduct(String code) async {
    emit(state.copyWith(status: ProductArrivalStateStatus.inProgress));

    try {
      ApiProduct product = await _findProduct(code);

      emit(state.copyWith(status: ProductArrivalStateStatus.productFound, lastFoundProduct: product));
    } on AppError catch(e) {
      emit(state.copyWith(status: ProductArrivalStateStatus.failure, message: e.message));
    }
  }

  Future<void> addProductArrivalPackageLine(int amount) async {
    try {
      ProductArrivalPackageNewLinesCompanion line = ProductArrivalPackageNewLinesCompanion(
        productArrivalPackageId: Value(state.packageInProgress!.package.id),
        productName: Value(state.lastFoundProduct!.name),
        productId: Value(state.lastFoundProduct!.id),
        amount: Value(amount)
      );

      await app.dataStore.productArrivalsDao.addProductArrivalPackageNewLine(line);

      emit(state.copyWith(status: ProductArrivalStateStatus.lineAdded));
    } on AppError catch(e) {
      emit(state.copyWith(status: ProductArrivalStateStatus.failure, message: e.message));
    }
  }

  Future<void> endAccept() async {
    emit(state.copyWith(status: ProductArrivalStateStatus.inProgress));

    try {
      await _endAccept();

      emit(state.copyWith(status: ProductArrivalStateStatus.success, message: 'Отмечено завершение разгрузки'));
    } on AppError catch(e) {
      emit(state.copyWith(status: ProductArrivalStateStatus.failure, message: e.message));
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

  Future<void> _endAccept() async {
    ProductArrivalPackageEx packageEx = state.packageInProgress!;

    try {
      ApiProductArrival newApiProductArrival = await Api(dataStore: app.dataStore).productArrivalsFinishPackageAccept(
        id: packageEx.package.id,
        lines: state.newLines.map((e) => { 'product': e.productId, 'amount': e.amount }).toList()
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

  Future<ApiProduct> _findProduct(String code) async {
    try {
      return await Api(dataStore: app.dataStore).productArrivalFindProduct(code: code);
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
