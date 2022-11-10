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
}
