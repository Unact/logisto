part of 'product_arrivals_page.dart';

class ProductArrivalsViewModel extends PageViewModel<ProductArrivalsState, ProductArrivalsStateStatus> {
  ProductArrivalsViewModel(BuildContext context) : super(context, ProductArrivalsState());

  @override
  ProductArrivalsStateStatus get status => state.status;

  @override
  TableUpdateQuery get listenForTables => TableUpdateQuery.onAllTables([
    dataStore.productArrivals
  ]);

  @override
  Future<void> loadData() async {
    emit(state.copyWith(
      status: ProductArrivalsStateStatus.dataLoaded,
      productArrivalExList: await store.productArrivalsRepo.getProductPackageExList()
    ));
  }

  Future<Order?> findProductArrival(String number) async {
    emit(state.copyWith(status: ProductArrivalsStateStatus.inProgress));

    try {
      ProductArrivalEx? orderEx = await store.productArrivalsRepo.findProductArrival(number);

      emit(state.copyWith(
        status: ProductArrivalsStateStatus.success,
        foundProductArrivalEx: Optional.fromNullable(orderEx))
      );
    } on AppError catch(e) {
      emit(state.copyWith(status: ProductArrivalsStateStatus.failure, message: e.message));
    }

    return null;
  }
}
