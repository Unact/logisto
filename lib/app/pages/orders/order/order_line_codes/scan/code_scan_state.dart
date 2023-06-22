part of 'code_scan_page.dart';

enum CodeScanStateStatus {
  initial,
  dataLoaded,
  scanReadFinished,
  failure,
  success
}

class CodeScanState {
  CodeScanState({
    this.status = CodeScanStateStatus.initial,
    this.message = '',
    required this.orderLineEx,
    this.newCodes = const []
  });

  final CodeScanStateStatus status;
  final String message;
  final OrderLineEx orderLineEx;
  final List<OrderLineNewCodeEx> newCodes;

  int get total => orderLineEx.line.factAmount ?? orderLineEx.line.amount;

  CodeScanState copyWith({
    CodeScanStateStatus? status,
    String? message,
    OrderLineEx? orderLineEx,
    List<OrderLineNewCodeEx>? newCodes
  }) {
    return CodeScanState(
      status: status ?? this.status,
      message: message ?? this.message,
      orderLineEx: orderLineEx ?? this.orderLineEx,
      newCodes: newCodes ?? this.newCodes
    );
  }
}
