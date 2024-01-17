part of 'package_page.dart';

class PackageViewModel extends PageViewModel<PackageState, PackageStateStatus> {
  final ProductArrivalsRepository productArrivalsRepository;

  StreamSubscription<ProductArrivalPackageEx>? productArrivalPackageExSubscription;
  StreamSubscription<List<ProductArrivalPackageNewLineEx>>? productArrivalPackageNewLineExListSubscription;

  PackageViewModel(this.productArrivalsRepository, { required ProductArrivalPackageEx packageEx }) :
    super(PackageState(packageEx: packageEx));

  @override
  PackageStateStatus get status => state.status;

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    int productArrivalPackageId = state.packageEx.package.id;

    productArrivalPackageExSubscription = productArrivalsRepository
      .watchProductArrivalPackageEx(productArrivalPackageId).listen((event) {
        emit(state.copyWith(status: PackageStateStatus.dataLoaded, packageEx: event));
      });
    productArrivalPackageNewLineExListSubscription = productArrivalsRepository
      .watchProductArrivalPackageNewLinesEx(productArrivalPackageId).listen((event) {
        emit(state.copyWith(status: PackageStateStatus.dataLoaded, newLineExList: event));
      });
  }

  @override
  Future<void> close() async {
    await super.close();

    await productArrivalPackageExSubscription?.cancel();
    await productArrivalPackageNewLineExListSubscription?.cancel();
  }

  Future<void> endAccept() async {
    emit(state.copyWith(status: PackageStateStatus.inProgress));

    try {
      await productArrivalsRepository.endAccept(state.packageEx, state.newLineExList);

      emit(state.copyWith(status: PackageStateStatus.success, message: 'Отмечено завершение разгрузки'));
    } on AppError catch(e) {
      emit(state.copyWith(status: PackageStateStatus.failure, message: e.message));
    }
  }

  Future<void> deleteProductArrivalPackageNewLine(ProductArrivalPackageNewLineEx packageNewLineEx) async {
    await productArrivalsRepository.deleteProductArrivalPackageNewLine(packageNewLineEx.line);
  }
}
