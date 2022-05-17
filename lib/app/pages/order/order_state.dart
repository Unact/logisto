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
    required this.orderExtended,
    this.storages = const [],
    this.message = '',
    required this.confirmationCallback,
    this.cardPayment = false,
    this.scanned = false,
    this.user
  });

  final OrderStateStatus status;
  final OrderExtended orderExtended;
  final List<OrderStorage> storages;
  final String message;
  final Function confirmationCallback;
  final bool cardPayment;
  final bool scanned;
  final User? user;

  List<OrderStorage> get acceptableStorages => storages
    .where((e) => user == null ? false : user!.storageIds.contains(e.id))
    .toList();
  List<OrderStorage> get transferableStorages => storages
    .where((e) => e.id != toStorage?.id)
    .toList();
  List<OrderLine> get lines => orderExtended.lines;
  Order get order => orderExtended.order;
  OrderStorage? get fromStorage => orderExtended.storageFrom;
  OrderStorage? get toStorage => orderExtended.storageTo;
  bool get transferAcceptable => scanned && pickupPointAccess;
  bool get storageTransferAcceptable => scanned && storageAccess;
  bool get transferable => scanned && storageAccess;
  bool get acceptable => scanned && storageAccess && order.firstMovementDate == null;
  bool get deliverable => scanned && pickupPointAccess && order.delivered == null;
  bool get scannable => !scanned && (storageAccess || pickupPointAccess);
  bool get payable => scanned && pickupPointAccess && !deliverable && order.paySum != 0 && order.paidSum == 0;
  bool get storageAccess => user?.storageIds.isNotEmpty ?? false;
  bool get pickupPointAccess => user?.pickupStorageId != null;

  OrderState copyWith({
    OrderStateStatus? status,
    OrderExtended? orderExtended,
    List<OrderStorage>? storages,
    Function? confirmationCallback,
    String? message,
    bool? cardPayment,
    bool? scanned,
    User? user
  }) {
    return OrderState(
      status: status ?? this.status,
      orderExtended: orderExtended ?? this.orderExtended,
      storages: storages ?? this.storages,
      message: message ?? this.message,
      confirmationCallback: confirmationCallback ?? this.confirmationCallback,
      cardPayment: cardPayment ?? this.cardPayment,
      scanned: scanned ?? this.scanned,
      user: user ?? this.user
    );
  }
}
