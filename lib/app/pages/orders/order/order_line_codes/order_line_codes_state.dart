part of 'order_line_codes_page.dart';

enum OrderLineCodesStateStatus {
  initial,
  dataLoaded,
  inProgress,
  success,
  failure,
  addCode,
  needUserConfirmation
}

class OrderLineCodesState {
  OrderLineCodesState({
    this.status = OrderLineCodesStateStatus.initial,
    required this.orderEx,
    this.message = '',
    this.newCodes = const [],
    required this.confirmationCallback,
  });

  final OrderLineCodesStateStatus status;
  final OrderEx orderEx;
  final String message;
  final List<OrderLineNewCodeEx> newCodes;
  final Function confirmationCallback;

  List<OrderLineEx> get productOrderLinesEx => orderEx.lines.where((e) => e.product?.needMarking ?? false).toList();

  OrderLineCodesState copyWith({
    OrderLineCodesStateStatus? status,
    OrderEx? orderEx,
    String? message,
    List<OrderLineNewCodeEx>? newCodes,
    Function? confirmationCallback,
  }) {
    return OrderLineCodesState(
      status: status ?? this.status,
      orderEx: orderEx ?? this.orderEx,
      message: message ?? this.message,
      newCodes: newCodes ?? this.newCodes,
      confirmationCallback: confirmationCallback ?? this.confirmationCallback,
    );
  }
}
