part of 'package_codes_page.dart';

class PackageCodesViewModel extends PageViewModel<PackageCodesState, PackageCodesStateStatus> {
  PackageCodesViewModel(BuildContext context, { required ProductArrivalPackageEx packageEx }) :
    super(context, PackageCodesState(packageEx: packageEx, confirmationCallback: () {}));

  @override
  PackageCodesStateStatus get status => state.status;

  @override
  TableUpdateQuery get listenForTables => TableUpdateQuery.onAllTables([
    dataStore.productArrivals,
    dataStore.productArrivalPackages,
    dataStore.productArrivalPackageNewCodes,
  ]);

  @override
  Future<void> loadData() async {
    int productArrivalPackageId = state.packageEx.package.id;

    emit(state.copyWith(
      status: PackageCodesStateStatus.dataLoaded,
      packageEx: await store.productArrivalsRepo.getProductArrivalPackageEx(productArrivalPackageId),
      newCodes: await store.productArrivalsRepo.getProductArrivalPackageNewCodesEx(productArrivalPackageId)
    ));
  }

  Future<void> trySavePackageCodes() async {
    for (var product in state.products) {
      int total = state.packageEx.packageLines
        .where((e) => e.product == product).fold(0, (acc, el) => acc + el.line.amount);
      int codesLen = state.newCodes.where((e) => e.product == product).length;

      if (total != codesLen) {
        emit(state.copyWith(
          status: PackageCodesStateStatus.needUserConfirmation,
          confirmationCallback: savePackageCodes,
          message: 'Отсканированы не все коды. Вы действительно хотите завершить сканирование кодов?',
        ));
        return;
      }
    }

    await savePackageCodes(true);
  }

  Future<void> savePackageCodes(bool confirmed) async {
    if (!confirmed) return;

    emit(state.copyWith(status: PackageCodesStateStatus.inProgress));

    try {
      await store.productArrivalsRepo.savePackageCodes(state.packageEx, state.newCodes);

      emit(state.copyWith(status: PackageCodesStateStatus.success, message: 'Коды успешно сохранены'));
    } on AppError catch(e) {
      emit(state.copyWith(status: PackageCodesStateStatus.failure, message: e.message));
    }
  }

  Future<void> deleteProductArrivalPackageNewCodes(Product product) async {
    await Future.forEach<ProductArrivalPackageNewCodeEx>(
      state.newCodes.where((e) => e.product == product),
      (e) => store.productArrivalsRepo.deleteProductArrivalPackageNewCode(e.newCode)
    );
  }
}
