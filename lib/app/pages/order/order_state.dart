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
  bool get transferAcceptable => scanned && pickupPointAccess;
  bool get storageTransferAcceptable => scanned && storageAccess;
  bool get transferable => scanned && storageAccess;
  bool get acceptable => scanned && storageAccess && order.firstMovementDate == null;
  bool get deliverable => scanned && pickupPointAccess && order.delivered == null;
  bool get scannable => !scanned && (storageAccess || pickupPointAccess);
  bool get payable => scanned && pickupPointAccess && !deliverable && order.paySum != 0 && order.paidSum == 0;
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
