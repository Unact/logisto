part of 'product_search_field.dart';

enum ProductSearchStateStatus {
  initial,
  inProgress,
  success,
  failure,
  setProduct,
}

class ProductSearchState {
  ProductSearchState({
    this.status = ProductSearchStateStatus.initial,
    this.message = '',
    this.foundProduct
  });

  final ProductSearchStateStatus status;
  final String message;
  final Product? foundProduct;

  ProductSearchState copyWith({
    ProductSearchStateStatus? status,
    String? message,
    Optional<Product>? foundProduct,
  }) {
    return ProductSearchState(
      status: status ?? this.status,
      message: message ?? this.message,
      foundProduct: foundProduct != null ? foundProduct.orNull : this.foundProduct,
    );
  }
}
