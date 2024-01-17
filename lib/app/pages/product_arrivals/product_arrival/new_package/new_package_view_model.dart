part of 'new_package_page.dart';

class NewPackageViewModel extends PageViewModel<NewPackageState, NewPackageStateStatus> {
  final ProductArrivalsRepository productArrivalsRepository;

  StreamSubscription<List<ProductArrivalPackageType>>? productArrivalPackageTypesSubscription;

  NewPackageViewModel(this.productArrivalsRepository, {required ProductArrivalEx productArrivalEx}) :
    super(NewPackageState(productArrivalEx: productArrivalEx));

  @override
  NewPackageStateStatus get status => state.status;

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    productArrivalPackageTypesSubscription = productArrivalsRepository
      .watchProductArrivalPackageTypes().listen((event) {
        emit(state.copyWith(status: NewPackageStateStatus.dataLoaded, types: event));
      });
  }

  @override
  Future<void> close() async {
    await super.close();

    await productArrivalPackageTypesSubscription?.cancel();
  }

  void setType(ProductArrivalPackageType type) {
    emit(state.copyWith(
      status: NewPackageStateStatus.setType,
      type: type
    ));
  }

  void setAmount(int amount) {
    emit(state.copyWith(
      status: NewPackageStateStatus.setAmount,
      amount: Optional.fromNullable(amount))
    );
  }

  Future<void> addProductArrivalPackage() async {
    if (state.type == null) {
      emit(state.copyWith(status: NewPackageStateStatus.failure, message: 'Не указан тип'));
      return;
    }

    if (state.amount == null) {
      emit(state.copyWith(status: NewPackageStateStatus.failure, message: 'Не указано кол-во'));
      return;
    }

    for (var i = 1; i <= state.amount!; i++) {
      await productArrivalsRepository.addProductArrivalNewPackage(
        productArrivalId: state.productArrivalEx.productArrival.id,
        typeName: state.type!.name,
        typeId: state.type!.id,
        number: Strings.undefinedNumber
      );
    }

    emit(state.copyWith(status: NewPackageStateStatus.packagesAdded));
  }
}
