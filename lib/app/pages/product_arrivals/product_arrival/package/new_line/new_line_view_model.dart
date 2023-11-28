part of 'new_line_page.dart';

class NewLineViewModel extends PageViewModel<NewLineState, NewLineStateStatus> {
  NewLineViewModel(BuildContext context, {required ProductArrivalPackageEx packageEx}) :
    super(context, NewLineState(packageEx: packageEx));

  @override
  NewLineStateStatus get status => state.status;

  @override
  Future<void> loadData() async {}

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

    if (state.product!.inPackage) {
      emit(state.copyWith(status: NewLineStateStatus.failure, message: 'Нельзя указывать переупакованный товар'));
      return;
    }

    ProductArrivalPackageNewLinesCompanion line = ProductArrivalPackageNewLinesCompanion(
      productArrivalPackageId: Value(state.packageEx.package.id),
      productId: Value(state.product!.id),
      amount: Value(state.amount!)
    );

    await store.productArrivalsRepo.addProductArrivalPackageNewLine(line);

    emit(state.copyWith(
      status: NewLineStateStatus.lineAdded,
      amount: const Optional.absent(),
      product: const Optional.absent()
    ));
  }
}
