part of 'code_scan_page.dart';

class CodeScanViewModel extends PageViewModel<CodeScanState, CodeScanStateStatus> {
  final GS1BarcodeParser parser = GS1BarcodeParser.defaultParser();

  CodeScanViewModel(BuildContext context, {required ProductArrivalPackageEx packageEx, required Product product}) :
    super(context, CodeScanState(packageEx: packageEx, product: product));

  @override
  CodeScanStateStatus get status => state.status;

  @override
  TableUpdateQuery get listenForTables => TableUpdateQuery.onAllTables([
    dataStore.productArrivals,
    dataStore.productArrivalPackages,
    dataStore.productArrivalPackageNewCodes,
  ]);

  @override
  Future<void> loadData() async {
    List<ProductArrivalPackageNewCodeEx> codes = (
      await store.productArrivalsRepo.getProductArrivalPackageNewCodesEx(state.packageEx.package.id)
    ).where((e) => e.product == state.product).toList();

    emit(state.copyWith(
      status: CodeScanStateStatus.dataLoaded,
      newCodes: codes
    ));
  }

  Future<void> readCode(String? barcode) async {
    if (barcode == null) return;

    String? gtin = _parseBarcode(barcode);

    if (gtin == null) {
      emit(state.copyWith(status: CodeScanStateStatus.failure, message: 'Необходимо отсканировать код ЧЗ'));
      return;
    }

    if (state.newCodes.any((e) => e.newCode.code == barcode)) {
      emit(state.copyWith(status: CodeScanStateStatus.failure, message: 'Код уже был отсканирован'));
      return;
    }

    if (state.newCodes.length >= state.total) {
      emit(state.copyWith(status: CodeScanStateStatus.failure, message: 'Отсканировано максимально кол-во товара'));
      return;
    }

    ProductArrivalPackageNewCodesCompanion code = ProductArrivalPackageNewCodesCompanion(
      productArrivalPackageId: Value(state.packageEx.package.id),
      productId: Value(state.product.id),
      code: Value(barcode)
    );

    await store.productArrivalsRepo.addProductArrivalPackageNewCode(code);

    return;
  }


  String? _parseBarcode(String barcode) {
    try {
      return parser.parse(barcode).getAIData('01');
    } on Exception catch(_) {
      return null;
    }
  }
}
