part of 'product_page.dart';

enum ProductStateStatus {
  initial,
  dataLoaded,
  inProgress,
  success,
  failure
}

class ProductState {
  ProductState({
    this.status = ProductStateStatus.initial,
    required this.product,
    this.productImages = const [],
    this.productBarcodes = const [],
    this.message = '',
    this.user,
  });

  final String message;
  final ProductStateStatus status;
  final Product product;
  final List<ApiProductImage> productImages;
  final List<ApiProductBarcode> productBarcodes;
  final User? user;

  ProductState copyWith({
    ProductStateStatus? status,
    Product? product,
    List<ApiProductImage>? productImages,
    List<ApiProductBarcode>? productBarcodes,
    String? message,
    User? user,
  }) {
    return ProductState(
      status: status ?? this.status,
      product: product ?? this.product,
      productImages: productImages ?? this.productImages,
      productBarcodes: productBarcodes ?? this.productBarcodes,
      message: message ?? this.message,
      user: user ?? this.user,
    );
  }
}
