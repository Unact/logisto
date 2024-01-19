part of 'product_search_field.dart';

class ProductSearchViewModel extends PageViewModel<ProductSearchState, ProductSearchStateStatus> {
  final ProductsRepository productsRepository;

  ProductSearchViewModel(this.productsRepository) : super(ProductSearchState());

  @override
  ProductSearchStateStatus get status => state.status;

  Future<List<Product>> findProductsByName(String name) async {
    try {
      return await productsRepository.findProduct(name: name);
    } on AppError catch(e) {
      emit(state.copyWith(status: ProductSearchStateStatus.failure, message: e.message));

      return [];
    }
  }

  Future<void> findAndSetProductByCode(String code) async {
    emit(state.copyWith(status: ProductSearchStateStatus.inProgress));

    try {
      List<Product> products = await productsRepository.findProduct(code: code);

      if (products.isEmpty) {
        emit(state.copyWith(status: ProductSearchStateStatus.failure, message: 'Не найден товар'));
        return;
      }

      setProduct(products.first);
    } on AppError catch(e) {
      emit(state.copyWith(status: ProductSearchStateStatus.failure, message: e.message));
    }
  }

  void setProduct(Product product) {
    emit(state.copyWith(
      status: ProductSearchStateStatus.setProduct,
      foundProduct: Optional.fromNullable(product))
    );
  }
}
