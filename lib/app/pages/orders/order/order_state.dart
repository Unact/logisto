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
    required this.orderEx,
    this.storages = const [],
    this.message = '',
    required this.confirmationCallback,
    this.cardPayment = false,
    this.scanned = false,
    this.user
  });

  final OrderStateStatus status;
  final OrderEx orderEx;
  final List<Storage> storages;
  final String message;
  final Function confirmationCallback;
  final bool cardPayment;
  final bool scanned;
  final User? user;

  List<Storage> get acceptableStorages => storages
    .where((e) => user == null ? false : user!.storageIds.contains(e.id))
    .toList();
  List<Storage> get transferableStorages => storages
    .where((e) => e.id != toStorage?.id)
    .toList();
  List<OrderLineEx> get lines => orderEx.lines;
  Order get order => orderEx.order;
  Storage? get fromStorage => orderEx.storageFrom;
  Storage? get toStorage => orderEx.storageTo;
  bool get transferAcceptable => scanned && pickupPointAccess;
  bool get storageTransferAcceptable => scanned && storageAccess;
  bool get transferable => scanned && storageAccess;
  bool get acceptable => scanned && storageAccess && order.firstMovementDate == null;
  bool get deliverable => scanned && pickupPointAccess && order.delivered == null;
  bool get scannable => !scanned && (storageAccess || pickupPointAccess);
  bool get payable => scanned && pickupPointAccess && !deliverable && order.paySum != 0 && order.paidSum == 0;
  bool get storageAccess => user?.storageIds.isNotEmpty ?? false;
  bool get pickupPointAccess => user?.pickupStorageId != null;
  bool get markingScannable => scanned && order.needMarkingScan;

  OrderState copyWith({
    OrderStateStatus? status,
    OrderEx? orderEx,
    List<Storage>? storages,
    Function? confirmationCallback,
    String? message,
    bool? cardPayment,
    bool? scanned,
    User? user
  }) {
    return OrderState(
      status: status ?? this.status,
      orderEx: orderEx ?? this.orderEx,
      storages: storages ?? this.storages,
      message: message ?? this.message,
      confirmationCallback: confirmationCallback ?? this.confirmationCallback,
      cardPayment: cardPayment ?? this.cardPayment,
      scanned: scanned ?? this.scanned,
      user: user ?? this.user
    );
  }
}
