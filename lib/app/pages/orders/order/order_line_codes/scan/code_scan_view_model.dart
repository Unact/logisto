part of 'code_scan_page.dart';

class CodeScanViewModel extends PageViewModel<CodeScanState, CodeScanStateStatus> {
  final GS1BarcodeParser parser = GS1BarcodeParser.defaultParser();

  CodeScanViewModel(BuildContext context, {required OrderLineEx orderLineEx}) :
    super(context, CodeScanState(orderLineEx: orderLineEx));

  @override
  CodeScanStateStatus get status => state.status;

  @override
  TableUpdateQuery get listenForTables => TableUpdateQuery.onAllTables([
    dataStore.orders,
    dataStore.orderLines,
    dataStore.orderLineNewCodes,
  ]);

  @override
  Future<void> loadData() async {
    List<OrderLineNewCodeEx> codes = (
      await store.ordersRepo.getOrderLineNewCodesEx(state.orderLineEx.line.orderId)
    ).where((e) => e.line.line == state.orderLineEx.line).toList();

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

    OrderLineNewCodesCompanion code = OrderLineNewCodesCompanion(
      orderLineId: Value(state.orderLineEx.line.id),
      code: Value(barcode)
    );

    await store.ordersRepo.addOrderLineNewCode(code);

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
