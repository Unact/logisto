part of 'product_arrivals_page.dart';

class ProductArrivalsViewModel extends PageViewModel<ProductArrivalsState, ProductArrivalsStateStatus> {
  ProductArrivalsViewModel(BuildContext context) : super(context, ProductArrivalsState());

  @override
  ProductArrivalsStateStatus get status => state.status;

  @override
  TableUpdateQuery get listenForTables => TableUpdateQuery.onAllTables([
    app.dataStore.users,
    app.dataStore.productArrivals,
    app.dataStore.productArrivalPackages,
    app.dataStore.productArrivalPackageLines,
  ]);

  @override
  Future<void> loadData() async {
    emit(state.copyWith(
      status: ProductArrivalsStateStatus.dataLoaded,
      productArrivalExList: await app.dataStore.productArrivalsDao.getProductPackageExList()
    ));
  }

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    emit(state.copyWith(status: ProductArrivalsStateStatus.startLoad));
  }

  Future<void> startUnload(ProductArrivalEx productArrivalEx) async {
    emit(state.copyWith(status: ProductArrivalsStateStatus.inProgress));

    try {
      await _startUnload(productArrivalEx);

      emit(state.copyWith(status: ProductArrivalsStateStatus.success, message: 'Отмечено начало разгрузки'));
    } on AppError catch(e) {
      emit(state.copyWith(status: ProductArrivalsStateStatus.failure, message: e.message));
    }
  }

  Future<void> endUnload(ProductArrivalEx productArrivalEx, int amount) async {
    emit(state.copyWith(status: ProductArrivalsStateStatus.inProgress));

    try {
      await _endUnload(productArrivalEx, amount);

      emit(state.copyWith(status: ProductArrivalsStateStatus.success, message: 'Отмечено завершение разгрузки'));
    } on AppError catch(e) {
      emit(state.copyWith(status: ProductArrivalsStateStatus.failure, message: e.message));
    }
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

  Future<void> _endUnload(ProductArrivalEx productArrivalEx, int amount) async {
    try {
      ApiProductArrival newApiProductArrival = await Api(dataStore: app.dataStore).productArrivalsFinishUnload(
        id: productArrivalEx.productArrival.id,
        amount: amount
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
