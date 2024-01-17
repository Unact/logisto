part of 'new_unload_package_page.dart';

class NewUnloadPackageViewModel extends PageViewModel<NewUnloadPackageState, NewUnloadPackageStateStatus> {
  final ProductArrivalsRepository productArrivalsRepository;

  StreamSubscription<List<ProductArrivalPackageType>>? productArrivalPackageTypesSubscription;

  NewUnloadPackageViewModel(this.productArrivalsRepository, {required ProductArrivalEx productArrivalEx}) :
    super(NewUnloadPackageState(productArrivalEx: productArrivalEx));

  @override
  NewUnloadPackageStateStatus get status => state.status;

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    productArrivalPackageTypesSubscription = productArrivalsRepository
      .watchProductArrivalPackageTypes().listen((event) {
        emit(state.copyWith(status: NewUnloadPackageStateStatus.dataLoaded, types: event));
      });
  }

  @override
  Future<void> close() async {
    await super.close();

    await productArrivalPackageTypesSubscription?.cancel();
  }

  void setType(ProductArrivalPackageType type) {
    emit(state.copyWith(
      status: NewUnloadPackageStateStatus.setType,
      type: type
    ));
  }

  void setAmount(int amount) {
    emit(state.copyWith(
      status: NewUnloadPackageStateStatus.setAmount,
      amount: Optional.fromNullable(amount))
    );
  }

  Future<void> addProductArrivalUnloadPackage() async {
    if (state.type == null) {
      emit(state.copyWith(status: NewUnloadPackageStateStatus.failure, message: 'Не указан тип'));
      return;
    }

    if (state.amount == null) {
      emit(state.copyWith(status: NewUnloadPackageStateStatus.failure, message: 'Не указано кол-во'));
      return;
    }

    await productArrivalsRepository.addProductArrivalNewUnloadPackage(
      productArrivalId: state.productArrivalEx.productArrival.id,
      typeName: state.type!.name,
      typeId: state.type!.id,
      amount: state.amount!
    );

    emit(state.copyWith(status: NewUnloadPackageStateStatus.unloadPackageAdded));
  }
}
