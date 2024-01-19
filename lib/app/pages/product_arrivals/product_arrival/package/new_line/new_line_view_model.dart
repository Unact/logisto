part of 'new_line_page.dart';

class NewLineViewModel extends PageViewModel<NewLineState, NewLineStateStatus> {
  final ProductArrivalsRepository productArrivalsRepository;

  NewLineViewModel(this.productArrivalsRepository, {required ProductArrivalPackageEx packageEx}) :
    super(NewLineState(packageEx: packageEx));

  @override
  NewLineStateStatus get status => state.status;

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

    await productArrivalsRepository.addProductArrivalPackageNewLine(
      productArrivalPackageId: state.packageEx.package.id,
      productId: state.product!.id,
      amount: state.amount!
    );

    emit(state.copyWith(
      status: NewLineStateStatus.lineAdded,
      amount: const Optional.absent(),
      product: const Optional.absent()
    ));
  }
}
