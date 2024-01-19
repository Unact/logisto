part of 'product_arrival_page.dart';

class ProductArrivalViewModel extends PageViewModel<ProductArrivalState, ProductArrivalStateStatus> {
  final ProductArrivalsRepository productArrivalsRepository;

  StreamSubscription<ProductArrivalEx?>? productArrivalExSubscription;
  StreamSubscription<List<ProductArrivalNewPackage>>? newPackagesListSubscription;
  StreamSubscription<List<ProductArrivalNewUnloadPackage>>? newUnloadPackagesListSubscription;

  ProductArrivalViewModel(
    this.productArrivalsRepository,
    {
      required ProductArrivalEx productArrivalEx
    }
  ) :
    super(ProductArrivalState(productArrivalEx: productArrivalEx));

  @override
  ProductArrivalStateStatus get status => state.status;

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();
    int productArrivalId = state.productArrivalEx.productArrival.id;

    productArrivalExSubscription = productArrivalsRepository.watchProductArrivalEx(productArrivalId).listen((event) {
      emit(state.copyWith(status: ProductArrivalStateStatus.dataLoaded, productArrivalEx: event));
    });
    newPackagesListSubscription = productArrivalsRepository
      .watchProductArrivalNewPackages(productArrivalId).listen((event) {
        emit(state.copyWith(status: ProductArrivalStateStatus.dataLoaded, newPackages: event));
      });
    newUnloadPackagesListSubscription = productArrivalsRepository
      .watchProductArrivalNewUnloadPackages(productArrivalId).listen((event) {
        emit(state.copyWith(status: ProductArrivalStateStatus.dataLoaded, newUnloadPackages: event));
      });
  }

  @override
  Future<void> close() async {
    await super.close();

    await productArrivalExSubscription?.cancel();
    await newPackagesListSubscription?.cancel();
    await newUnloadPackagesListSubscription?.cancel();
  }

  Future<void> startUnload(String storageUnloadPointIdStr) async {
    emit(state.copyWith(status: ProductArrivalStateStatus.inProgress));

    try {
      await productArrivalsRepository.startUnload(state.productArrivalEx, int.parse(storageUnloadPointIdStr));

      emit(state.copyWith(status: ProductArrivalStateStatus.success, message: 'Отмечено начало разгрузки'));
    } on AppError catch(e) {
      emit(state.copyWith(status: ProductArrivalStateStatus.failure, message: e.message));
    }
  }

  Future<void> endUnload() async {
    emit(state.copyWith(status: ProductArrivalStateStatus.inProgress));

    try {
      await productArrivalsRepository.endUnload(state.productArrivalEx, state.newPackages, state.newUnloadPackages);

      emit(state.copyWith(status: ProductArrivalStateStatus.success, message: 'Отмечено завершение разгрузки'));
    } on AppError catch(e) {
      emit(state.copyWith(status: ProductArrivalStateStatus.failure, message: e.message));
    }
  }

  Future<void> printPackagesLabel() async {
    ProductArrivalPackagesLabel(productArrivalEx: state.productArrivalEx).print(
      onError: (String error) => emit(state.copyWith(status: ProductArrivalStateStatus.failure, message: error))
    );
  }

  Future<void> markProductArrivalPackageScanned(ProductArrivalPackageEx? packageEx) async {
    if (packageEx == null) {
      emit(state.copyWith(
        status: ProductArrivalStateStatus.productArrivalPackageScanFail,
        message: 'Место не найдено'
      ));
      return;
    }

    if (packageEx.package.acceptEnd != null) {
      emit(state.copyWith(
        status: ProductArrivalStateStatus.productArrivalPackageScanFail,
        message: 'Приемка места уже завершена'
      ));
      return;
    }

    if (packageEx.package.acceptStart != null) {
      emit(state.copyWith(
        status: ProductArrivalStateStatus.productArrivalPackageScanFail,
        message: 'Приемка места уже начата'
      ));
      return;
    }

    emit(state.copyWith(
      status: ProductArrivalStateStatus.productArrivalPackageScanSuccess,
      scannedProductArrivalPackageEx: packageEx
    ));
  }

  Future<void> startAccept(String storageAcceptPointIdStr) async {
    emit(state.copyWith(status: ProductArrivalStateStatus.inProgress));

    try {
      await productArrivalsRepository.startAccept(
        state.scannedProductArrivalPackageEx!,
        int.parse(storageAcceptPointIdStr)
      );

      emit(state.copyWith(status: ProductArrivalStateStatus.success, message: 'Отмечено начало приемки'));
    } on AppError catch(e) {
      emit(state.copyWith(status: ProductArrivalStateStatus.failure, message: e.message));
    }
  }

  Future<void> deleteProductArrivalNewPackage(ProductArrivalNewPackage newPackage) async {
    await productArrivalsRepository.deleteProductArrivalNewPackage(newPackage);
  }

  Future<void> deleteProductArrivalNewUnloadPackage(ProductArrivalNewUnloadPackage newUnloadPackage) async {
    await productArrivalsRepository.deleteProductArrivalNewUnloadPackage(newUnloadPackage);
  }

  Future<void> copyUnloadPackages() async {
    for (var newUnloadPackage in state.newUnloadPackages) {
      for (var i = 1; i <= newUnloadPackage.amount; i++) {
        await productArrivalsRepository.addProductArrivalNewPackage(
          productArrivalId: state.productArrivalEx.productArrival.id,
          typeName: newUnloadPackage.typeName,
          typeId: newUnloadPackage.typeId,
          number: Strings.undefinedNumber
        );
      }
    }
  }

  void markProductArrivalScanned(String number) {
    if (number != state.productArrival.number) {
      emit(state.copyWith(
        status: ProductArrivalStateStatus.productArrivalScanFail,
        message: 'Отсканирована другая приемка'
      ));
      return;
    }

    emit(state.copyWith(scanned: true, status: ProductArrivalStateStatus.productArrivalScanSuccess));
  }
}
