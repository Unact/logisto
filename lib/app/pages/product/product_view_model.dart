part of 'product_page.dart';

class ProductViewModel extends PageViewModel<ProductState, ProductStateStatus> {
  static const String _kBarcodeType = 'ean13';

  ProductViewModel(BuildContext context, { required Product product }) : super(context, ProductState(product: product));

  @override
  ProductStateStatus get status => state.status;

  @override
  TableUpdateQuery get listenForTables => TableUpdateQuery.onAllTables([
    dataStore.products
  ]);

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    await getData();
  }

  @override
  Future<void> loadData() async {
    emit(state.copyWith(
      status: ProductStateStatus.dataLoaded,
      user: await store.usersRepo.getUser()
    ));
  }

  Future<void> getData() async {
    emit(state.copyWith(status: ProductStateStatus.inProgress));

    try {
      emit(state.copyWith(
        status: ProductStateStatus.success,
        productBarcodes: await store.productsRepo.getProductBarcodes(state.product),
        productImages: await store.productsRepo.getProductImages(state.product)
      ));
    } on AppError catch(e) {
      emit(state.copyWith(status: ProductStateStatus.failure, message: e.message));
    }
  }

  Future<void> printProductLabel(ApiProductBarcode productBarcode, int amount) async {
    await ProductLabel(productBarcode: productBarcode, product: state.product, user: state.user!).print(
      amount: amount,
      onError: (String error) => emit(state.copyWith(status: ProductStateStatus.failure, message: error))
    );
  }

  Future<void> addProductBarcode(String code) async {
    emit(state.copyWith(status: ProductStateStatus.inProgress));

    try {
      ApiProductBarcode newBarcode = await store.productsRepo.createProductBarcode(
        state.product,
        code: code,
        type: _kBarcodeType
      );

      emit(state.copyWith(
        status: ProductStateStatus.success,
        productBarcodes: List.from(state.productBarcodes)..add(newBarcode)
      ));
    } on AppError catch(e) {
      emit(state.copyWith(status: ProductStateStatus.failure, message: e.message));
    }
  }

  Future<void> addProductImage(XFile file) async {
    emit(state.copyWith(status: ProductStateStatus.inProgress));

    try {
      ApiProductImage newImage = await store.productsRepo.createProductImage(state.product, file: file);

      emit(state.copyWith(
        status: ProductStateStatus.success,
        productImages: List.from(state.productImages)..add(newImage)
      ));
    } on AppError catch(e) {
      emit(state.copyWith(status: ProductStateStatus.failure, message: e.message));
    }
  }
}
