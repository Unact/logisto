part of 'package_page.dart';

class PackageViewModel extends PageViewModel<PackageState, PackageStateStatus> {
  PackageViewModel(BuildContext context, { required ProductArrivalPackageEx packageEx }) :
    super(context, PackageState(packageEx: packageEx));

  @override
  PackageStateStatus get status => state.status;

  @override
  TableUpdateQuery get listenForTables => TableUpdateQuery.onAllTables([
    dataStore.productArrivals,
    dataStore.productArrivalPackages,
    dataStore.productArrivalPackageLines,
    dataStore.productArrivalPackageNewLines,
  ]);

  @override
  Future<void> loadData() async {
    int productArrivalPackageId = state.packageEx.package.id;

    emit(state.copyWith(
      status: PackageStateStatus.dataLoaded,
      user: await store.usersRepo.getUser(),
      packageEx: await store.productArrivalsRepo.getProductArrivalPackageEx(productArrivalPackageId),
      newLineExList: await store.productArrivalsRepo.getProductArrivalPackageNewLinesEx(productArrivalPackageId)
    ));
  }

  Future<void> printProductLabel(Product product, int amount) async {
    await ProductLabel(product: product, user: state.user!).print(
      amount: amount,
      onError: (String error) => emit(state.copyWith(status: PackageStateStatus.failure, message: error))
    );
  }

  Future<void> endAccept() async {
    emit(state.copyWith(status: PackageStateStatus.inProgress));

    try {
      await store.productArrivalsRepo.endAccept(state.packageEx, state.newLineExList);

      emit(state.copyWith(status: PackageStateStatus.success, message: 'Отмечено завершение разгрузки'));
    } on AppError catch(e) {
      emit(state.copyWith(status: PackageStateStatus.failure, message: e.message));
    }
  }

  Future<void> deleteProductArrivalPackageNewLine(ProductArrivalPackageNewLineEx packageNewLineEx) async {
    await store.productArrivalsRepo.deleteProductArrivalPackageNewLine(packageNewLineEx.line);
  }
}
