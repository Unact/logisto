part of 'product_arrivals_page.dart';

enum ProductArrivalsStateStatus {
  initial,
  dataLoaded
}

class ProductArrivalsState {
  ProductArrivalsState({
    this.status = ProductArrivalsStateStatus.initial,
    this.productArrivalExList = const []
  });

  final ProductArrivalsStateStatus status;
  final List<ProductArrivalEx> productArrivalExList;

  List<Storage> get storages => productArrivalExList.map((e) => e.storage).toSet().toList()
    ..sort((a, b) => a.sequenceNumber.compareTo(b.sequenceNumber));

  ProductArrivalsState copyWith({
    ProductArrivalsStateStatus? status,
    List<ProductArrivalEx>? productArrivalExList
  }) {
    return ProductArrivalsState(
      status: status ?? this.status,
      productArrivalExList: productArrivalExList ?? this.productArrivalExList
    );
  }
}
