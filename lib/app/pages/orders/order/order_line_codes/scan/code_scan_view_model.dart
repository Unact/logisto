part of 'code_scan_page.dart';

class CodeScanViewModel extends PageViewModel<CodeScanState, CodeScanStateStatus> {
  final OrdersRepository ordersRepository;
  final GS1BarcodeParser parser = GS1BarcodeParser.defaultParser();

  StreamSubscription<List<OrderLineNewCodeEx>>? orderLineNewCodesExListSubscription;

  CodeScanViewModel(this.ordersRepository, {required OrderLineEx orderLineEx}) :
    super(CodeScanState(orderLineEx: orderLineEx));

  @override
  CodeScanStateStatus get status => state.status;

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    orderLineNewCodesExListSubscription = ordersRepository.watchOrderLineNewCodesEx(state.orderLineEx.line.orderId)
      .listen((event) {
        emit(state.copyWith(
          status: CodeScanStateStatus.dataLoaded,
          newCodes: event.where((e) => e.line.line == state.orderLineEx.line).toList()
        ));
      });
  }

  @override
  Future<void> close() async {
    await super.close();

    await orderLineNewCodesExListSubscription?.cancel();
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

    await ordersRepository.addOrderLineNewCode(orderLineId: state.orderLineEx.line.id, code: barcode);
  }

  String? _parseBarcode(String barcode) {
    try {
      return parser.parse(barcode).getAIData('01');
    } on Exception catch(_) {
      return null;
    }
  }
}
