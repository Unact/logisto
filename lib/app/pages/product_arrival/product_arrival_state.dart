part of 'product_arrival_page.dart';

enum ProductArrivalStateStatus {
  initial,
  dataLoaded,
  startLoad,
  inProgress,
  success,
  failure,
  productFound,
  lineAdded
}

class ProductArrivalState {
  ProductArrivalState({
    this.status = ProductArrivalStateStatus.initial,
    required this.productArrivalEx,
    this.message = '',
    this.lastFoundProduct,
    this.newLines = const []
  });

  final ProductArrivalStateStatus status;
  final ProductArrivalEx productArrivalEx;
  final String message;
  final ApiProduct? lastFoundProduct;
  final List<ProductArrivalPackageNewLine> newLines;

  ProductArrivalPackageEx? get packageInProgress => productArrivalEx.packages.firstWhereOrNull(
    (e) => e.package.acceptStart != null && e.package.acceptEnd == null
  );

  bool get allPackagesUnloded => productArrivalEx.packages.every((e) => e.package.acceptEnd != null);

  ProductArrivalState copyWith({
    ProductArrivalStateStatus? status,
    ProductArrivalEx? productArrivalEx,
    String? message,
    ApiProduct? lastFoundProduct,
    List<ProductArrivalPackageNewLine>? newLines
  }) {
    return ProductArrivalState(
      status: status ?? this.status,
      productArrivalEx: productArrivalEx ?? this.productArrivalEx,
      message: message ?? this.message,
      lastFoundProduct: lastFoundProduct ?? this.lastFoundProduct,
      newLines: newLines ?? this.newLines
    );
  }
}
