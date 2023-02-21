part of 'new_package_page.dart';

class NewPackageViewModel extends PageViewModel<NewPackageState, NewPackageStateStatus> {
  NewPackageViewModel(BuildContext context, {required ProductArrivalEx productArrivalEx}) :
    super(context, NewPackageState(productArrivalEx: productArrivalEx));

  @override
  NewPackageStateStatus get status => state.status;

  @override
  Future<void> loadData() async {
    emit(state.copyWith(
      status: NewPackageStateStatus.dataLoaded,
      types: await store.productArrivalsRepo.getProductArrivalPackageTypes(),
    ));
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
      ProductArrivalNewPackagesCompanion package = ProductArrivalNewPackagesCompanion(
        productArrivalId: Value(state.productArrivalEx.productArrival.id),
        typeName: Value(state.type!.name),
        typeId: Value(state.type!.id),
        number: const Value(Strings.undefinedNumber)
      );

      await store.productArrivalsRepo.addProductArrivalNewPackage(package);
    }

    emit(state.copyWith(status: NewPackageStateStatus.packagesAdded));
  }
}
