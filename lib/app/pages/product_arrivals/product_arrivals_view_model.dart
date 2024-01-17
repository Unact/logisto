part of 'product_arrivals_page.dart';

class ProductArrivalsViewModel extends PageViewModel<ProductArrivalsState, ProductArrivalsStateStatus> {
  final ProductArrivalsRepository productArrivalsRepository;

  StreamSubscription<List<ProductArrivalEx>>? productArrivalExListSubscription;

  ProductArrivalsViewModel(this.productArrivalsRepository) : super(ProductArrivalsState());

  @override
  ProductArrivalsStateStatus get status => state.status;

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    productArrivalExListSubscription = productArrivalsRepository.watchProductPackageExList().listen((event) {
      emit(state.copyWith(status: ProductArrivalsStateStatus.dataLoaded, productArrivalExList: event));
    });
  }

  @override
  Future<void> close() async {
    await super.close();

    await productArrivalExListSubscription?.cancel();
  }

  Future<Order?> findProductArrival(String number) async {
    emit(state.copyWith(status: ProductArrivalsStateStatus.inProgress));

    try {
      ProductArrivalEx? orderEx = await productArrivalsRepository.findProductArrival(number);

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
