part of 'package_codes_page.dart';

class PackageCodesViewModel extends PageViewModel<PackageCodesState, PackageCodesStateStatus> {
  final ProductArrivalsRepository productArrivalsRepository;

  StreamSubscription<ProductArrivalPackageEx?>? productArrivalPackageExSubscription;
  StreamSubscription<List<ProductArrivalPackageNewCodeEx>>? productArrivalPackageNewCodeExListSubscription;

  PackageCodesViewModel(this.productArrivalsRepository, { required ProductArrivalPackageEx packageEx }) :
    super(PackageCodesState(packageEx: packageEx, confirmationCallback: () {}));

  @override
  PackageCodesStateStatus get status => state.status;

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();
    int productArrivalPackageId = state.packageEx.package.id;

    productArrivalPackageExSubscription = productArrivalsRepository
      .watchProductArrivalPackageEx(productArrivalPackageId).listen((event) {
        emit(state.copyWith(status: PackageCodesStateStatus.dataLoaded, packageEx: event));
      });
    productArrivalPackageNewCodeExListSubscription = productArrivalsRepository
      .watchProductArrivalPackageNewCodesEx(productArrivalPackageId).listen((event) {
        emit(state.copyWith(status: PackageCodesStateStatus.dataLoaded, newCodes: event));
      });
  }

  @override
  Future<void> close() async {
    await super.close();

    await productArrivalPackageExSubscription?.cancel();
    await productArrivalPackageNewCodeExListSubscription?.cancel();
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
      await productArrivalsRepository.savePackageCodes(state.packageEx, state.newCodes);

      emit(state.copyWith(status: PackageCodesStateStatus.success, message: 'Коды успешно сохранены'));
    } on AppError catch(e) {
      emit(state.copyWith(status: PackageCodesStateStatus.failure, message: e.message));
    }
  }

  Future<void> deleteProductArrivalPackageNewCodes(Product product) async {
    await Future.forEach<ProductArrivalPackageNewCodeEx>(
      state.newCodes.where((e) => e.product == product),
      (e) => productArrivalsRepository.deleteProductArrivalPackageNewCode(e.newCode)
    );
  }
}
