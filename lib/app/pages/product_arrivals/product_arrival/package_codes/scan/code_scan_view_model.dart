part of 'code_scan_page.dart';

class CodeScanViewModel extends PageViewModel<CodeScanState, CodeScanStateStatus> {
  final ProductArrivalsRepository productArrivalsRepository;
  final GS1BarcodeParser parser = GS1BarcodeParser.defaultParser();

  StreamSubscription<List<ProductArrivalPackageNewCodeEx>>? productArrivalPackageNewCodesExListSubscription;

  CodeScanViewModel(
    this.productArrivalsRepository,
    {
      required ProductArrivalPackageEx packageEx,
      required Product product
    }
  ) : super(CodeScanState(packageEx: packageEx, product: product));

  @override
  CodeScanStateStatus get status => state.status;

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    productArrivalPackageNewCodesExListSubscription = productArrivalsRepository
      .watchProductArrivalPackageNewCodesEx(state.packageEx.package.id).listen((event) {
        emit(state.copyWith(status: CodeScanStateStatus.dataLoaded, newCodes: event));
      });
  }

  @override
  Future<void> close() async {
    await super.close();

    await productArrivalPackageNewCodesExListSubscription?.cancel();
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

    await productArrivalsRepository.addProductArrivalPackageNewCode(
      productArrivalPackageId: state.packageEx.package.id,
      productId: state.product.id,
      code: barcode
    );

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
