part of 'new_line_page.dart';

class NewLineViewModel extends PageViewModel<NewLineState, NewLineStateStatus> {
  NewLineViewModel(BuildContext context, {required ProductArrivalPackageEx packageEx}) :
    super(context, NewLineState(packageEx: packageEx));

  @override
  NewLineStateStatus get status => state.status;

  @override
  Future<void> loadData() async {}

  Future<List<Product>> findProductsByName(String name) async {
    try {
      return await store.productsRepo.findProduct(name: name);
    } on AppError catch(e) {
      emit(state.copyWith(status: NewLineStateStatus.failure, message: e.message));

      return [];
    }
  }

  Future<void> findAndSetProductByCode(String code) async {
    emit(state.copyWith(status: NewLineStateStatus.inProgress));

    try {
      List<Product> products = await store.productsRepo.findProduct(code: code);

      if (products.isEmpty) {
        emit(state.copyWith(status: NewLineStateStatus.failure, message: 'Не найден товар'));
        return;
      }

      setProduct(products.first);
    } on AppError catch(e) {
      emit(state.copyWith(status: NewLineStateStatus.failure, message: e.message));
    }
  }

  void setProduct(Product product) {
    emit(state.copyWith(
      status: NewLineStateStatus.setProduct,
      product: Optional.fromNullable(product))
    );
  }

  void setAmount(int amount) {
    emit(state.copyWith(
      status: NewLineStateStatus.setAmount,
      amount: Optional.fromNullable(amount))
    );
  }

  Future<void> addProductArrivalPackageNewLine() async {
    if (state.product == null) {
      emit(state.copyWith(status: NewLineStateStatus.failure, message: 'Не указан товар'));
      return;
    }

    if (state.amount == null) {
      emit(state.copyWith(status: NewLineStateStatus.failure, message: 'Не указано кол-во'));
      return;
    }

    ProductArrivalPackageNewLinesCompanion line = ProductArrivalPackageNewLinesCompanion(
      productArrivalPackageId: Value(state.packageEx.package.id),
      productId: Value(state.product!.id),
      amount: Value(state.amount!)
    );

    await store.productArrivalsRepo.addProductArrivalPackageNewLine(line);

    emit(state.copyWith(status: NewLineStateStatus.lineAdded));
  }
}
