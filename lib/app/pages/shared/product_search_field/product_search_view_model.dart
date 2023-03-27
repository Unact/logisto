part of 'product_search_field.dart';

class ProductSearchViewModel extends PageViewModel<ProductSearchState, ProductSearchStateStatus> {
  ProductSearchViewModel(BuildContext context) : super(context, ProductSearchState());

  @override
  ProductSearchStateStatus get status => state.status;

  @override
  TableUpdateQuery get listenForTables => TableUpdateQuery.onAllTables([]);

  @override
  Future<void> loadData() async {}

  Future<List<Product>> findProductsByName(String name) async {
    try {
      return await store.productsRepo.findProduct(name: name);
    } on AppError catch(e) {
      emit(state.copyWith(status: ProductSearchStateStatus.failure, message: e.message));

      return [];
    }
  }

  Future<void> findAndSetProductByCode(String code) async {
    emit(state.copyWith(status: ProductSearchStateStatus.inProgress));

    try {
      List<Product> products = await store.productsRepo.findProduct(code: code);

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
