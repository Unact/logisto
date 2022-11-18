part of 'product_arrivals_page.dart';

class ProductArrivalsViewModel extends PageViewModel<ProductArrivalsState, ProductArrivalsStateStatus> {
  ProductArrivalsViewModel(BuildContext context) : super(context, ProductArrivalsState());

  @override
  ProductArrivalsStateStatus get status => state.status;

  @override
  TableUpdateQuery get listenForTables => TableUpdateQuery.onAllTables([
    app.dataStore.productArrivals
  ]);

  @override
  Future<void> loadData() async {
    emit(state.copyWith(
      status: ProductArrivalsStateStatus.dataLoaded,
      productArrivalExList: await app.dataStore.productArrivalsDao.getProductPackageExList()
    ));
  }

  Future<Order?> findProductArrival(String number) async {
    emit(state.copyWith(status: ProductArrivalsStateStatus.inProgress));

    try {
      ProductArrivalEx? orderEx = await _findProductArrival(number);

      emit(state.copyWith(
        status: ProductArrivalsStateStatus.success,
        foundProductArrivalEx: Optional.fromNullable(orderEx))
      );
    } on AppError catch(e) {
      emit(state.copyWith(status: ProductArrivalsStateStatus.failure, message: e.message));
    }

    return null;
  }

  Future<ProductArrivalEx> _findProductArrival(String number) async {
    try {
      ProductArrivalEx? productArrivalEx = await app.dataStore.productArrivalsDao.getProductArrivalExByNumber(number);
      if (productArrivalEx != null) return productArrivalEx;

      ApiProductArrival apiProductArrival = await Api(dataStore: app.dataStore).findProductArrival(number: number);
      productArrivalEx = apiProductArrival.toDatabaseEnt();

      await app.dataStore.transaction(() async {
        await app.dataStore.productArrivalsDao.updateProductArrivalEx(productArrivalEx!);
        await app.dataStore.storagesDao.addStorage(productArrivalEx.storage);
      });

      return productArrivalEx;
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await app.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }
}
