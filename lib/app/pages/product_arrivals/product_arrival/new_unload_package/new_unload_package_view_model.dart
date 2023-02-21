part of 'new_unload_package_page.dart';

class NewUnloadPackageViewModel extends PageViewModel<NewUnloadPackageState, NewUnloadPackageStateStatus> {
  NewUnloadPackageViewModel(BuildContext context, {required ProductArrivalEx productArrivalEx}) :
    super(context, NewUnloadPackageState(productArrivalEx: productArrivalEx));

  @override
  NewUnloadPackageStateStatus get status => state.status;

  @override
  Future<void> loadData() async {
    emit(state.copyWith(
      status: NewUnloadPackageStateStatus.dataLoaded,
      types: await store.productArrivalsRepo.getProductArrivalPackageTypes(),
    ));
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

    ProductArrivalNewUnloadPackagesCompanion unloadPackage = ProductArrivalNewUnloadPackagesCompanion(
      productArrivalId: Value(state.productArrivalEx.productArrival.id),
      typeName: Value(state.type!.name),
      typeId: Value(state.type!.id),
      amount: Value(state.amount!)
    );

    await store.productArrivalsRepo.addProductArrivalNewUnloadPackage(unloadPackage);

    emit(state.copyWith(status: NewUnloadPackageStateStatus.unloadPackageAdded));
  }
}
