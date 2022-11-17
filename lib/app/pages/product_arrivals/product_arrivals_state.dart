part of 'product_arrivals_page.dart';

enum ProductArrivalsStateStatus {
  initial,
  dataLoaded,
  inProgress,
  success,
  failure,
}

class ProductArrivalsState {
  ProductArrivalsState({
    this.status = ProductArrivalsStateStatus.initial,
    this.productArrivalExList = const [],
    this.foundProductArrivalEx,
    this.message = '',
  });

  final ProductArrivalsStateStatus status;
  final List<ProductArrivalEx> productArrivalExList;
  final ProductArrivalEx? foundProductArrivalEx;
  final String message;

  List<Storage> get storages => productArrivalExList.map((e) => e.storage).toSet().toList()
    ..sort((a, b) => a.sequenceNumber.compareTo(b.sequenceNumber));

  ProductArrivalsState copyWith({
    ProductArrivalsStateStatus? status,
    List<ProductArrivalEx>? productArrivalExList,
    Optional<ProductArrivalEx>? foundProductArrivalEx,
    String? message,
  }) {
    return ProductArrivalsState(
      status: status ?? this.status,
      productArrivalExList: productArrivalExList ?? this.productArrivalExList,
      foundProductArrivalEx: foundProductArrivalEx != null ? foundProductArrivalEx.orNull : this.foundProductArrivalEx,
      message: message ?? this.message,
    );
  }
}
