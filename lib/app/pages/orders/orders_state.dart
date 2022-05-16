part of 'orders_page.dart';

enum OrdersStateStatus {
  initial,
  dataLoaded,
  startLoad,
  inProgress,
  success,
  failure,
}

class OrdersState {
  OrdersState({
    this.status = OrdersStateStatus.initial,
    this.orderExtendedList = const [],
    this.foundOrderExtended,
    this.message = '',
    this.hasScanner,
    this.user
  });

  final OrdersStateStatus status;
  final List<OrderExtended> orderExtendedList;
  final OrderExtended? foundOrderExtended;
  final String message;
  final bool? hasScanner;
  final User? user;

  List<OrderStorage> get orderStorages => (
    orderExtendedList.map((e) => e.storageTo).whereType<OrderStorage>().toList() +
    orderExtendedList.map((e) => e.storageFrom).whereType<OrderStorage>().toList()
  )
    .where((e) => (user?.storageIds.contains(e.id) ?? false) || user?.pickupStorageId == e.id).toSet()
    .toList()..sort((a, b) => a.sequenceNumber.compareTo(b.sequenceNumber));

  List<OrderExtended> get ordersWithoutStorage => orderExtendedList
    .where((e) => e.storageTo == null && e.storageFrom == null).toList();

  OrdersState copyWith({
    OrdersStateStatus? status,
    List<OrderExtended>? orderExtendedList,
    Optional<OrderExtended>? foundOrderExtended,
    String? message,
    bool? hasScanner,
    User? user
  }) {
    return OrdersState(
      status: status ?? this.status,
      orderExtendedList: orderExtendedList ?? this.orderExtendedList,
      foundOrderExtended: foundOrderExtended != null ? foundOrderExtended.orNull : this.foundOrderExtended,
      message: message ?? this.message,
      hasScanner: hasScanner ?? this.hasScanner,
      user: user ?? this.user
    );
  }
}
