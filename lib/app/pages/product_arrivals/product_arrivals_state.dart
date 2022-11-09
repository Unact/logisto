part of 'product_arrivals_page.dart';

enum ProductArrivalsStateStatus {
  initial,
  dataLoaded
}

class ProductArrivalsState {
  ProductArrivalsState({
    this.status = ProductArrivalsStateStatus.initial,
    this.productArrivalExList = const [],
    this.message = ''
  });

  final ProductArrivalsStateStatus status;
  final List<ProductArrivalEx> productArrivalExList;
  final String message;

  List<Storage> get storages => productArrivalExList.map((e) => e.storage).toSet().toList()
    ..sort((a, b) => a.sequenceNumber.compareTo(b.sequenceNumber));

  ProductArrivalsState copyWith({
    ProductArrivalsStateStatus? status,
    List<ProductArrivalEx>? productArrivalExList,
    String? message
  }) {
    return ProductArrivalsState(
      status: status ?? this.status,
      productArrivalExList: productArrivalExList ?? this.productArrivalExList,
      message: message ?? this.message
    );
  }
}
