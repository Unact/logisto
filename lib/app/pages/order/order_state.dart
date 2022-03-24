part of 'order_page.dart';

enum OrderStateStatus {
  initial,
  dataLoaded,
  inProgress,
  success,
  failure,
  paymentStarted,
  needUserConfirmation,
  paymentFinished,
  scanStarted,
  scanFinished
}

class OrderState {
  OrderState({
    this.status = OrderStateStatus.initial,
    required this.orderWithLines,
    this.storages = const [],
    this.message = '',
    required this.confirmationCallback,
    this.cardPayment = false,
    this.scanned = false,
    this.user
  });

  final OrderStateStatus status;
  final OrderWithLines orderWithLines;
  final List<OrderStorage> storages;
  final String message;
  final Function confirmationCallback;
  final bool cardPayment;
  final bool scanned;
  final User? user;

  List<OrderLine> get lines => orderWithLines.lines;
  Order get order => orderWithLines.order;
  bool get acceptable => order.firstMovementDate == null;
  bool get deliverable => order.delivered == null;
  bool get payable => !deliverable && order.paySum != 0 && order.paidSum == 0;
  bool get storageAccess => user?.roles.contains('storage') ?? false;
  bool get pickupPointAccess => user?.roles.contains('pickup') ?? false;

  OrderState copyWith({
    OrderStateStatus? status,
    OrderWithLines? orderWithLines,
    List<OrderStorage>? storages,
    Function? confirmationCallback,
    String? message,
    bool? cardPayment,
    bool? scanned,
    User? user
  }) {
    return OrderState(
      status: status ?? this.status,
      orderWithLines: orderWithLines ?? this.orderWithLines,
      storages: storages ?? this.storages,
      message: message ?? this.message,
      confirmationCallback: confirmationCallback ?? this.confirmationCallback,
      cardPayment: cardPayment ?? this.cardPayment,
      scanned: scanned ?? this.scanned,
      user: user ?? this.user
    );
  }
}
