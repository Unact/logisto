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
    this.orderExList = const [],
    this.foundOrderEx,
    this.message = '',
    this.user
  });

  final OrdersStateStatus status;
  final List<OrderEx> orderExList;
  final OrderEx? foundOrderEx;
  final String message;
  final User? user;

  List<Storage> get storages => (
    orderExList.map((e) => e.storageTo).whereType<Storage>().toList() +
    orderExList.map((e) => e.storageFrom).whereType<Storage>().toList()
  )
    .where((e) => (user?.storageIds.contains(e.id) ?? false) || user?.pickupStorageId == e.id).toSet()
    .toList()..sort((a, b) => a.sequenceNumber.compareTo(b.sequenceNumber));

  List<OrderEx> get ordersWithoutStorage => orderExList
    .where((e) => e.storageTo == null && e.storageFrom == null).toList();

  OrdersState copyWith({
    OrdersStateStatus? status,
    List<OrderEx>? orderExList,
    Optional<OrderEx>? foundOrderEx,
    String? message,
    User? user
  }) {
    return OrdersState(
      status: status ?? this.status,
      orderExList: orderExList ?? this.orderExList,
      foundOrderEx: foundOrderEx != null ? foundOrderEx.orNull : this.foundOrderEx,
      message: message ?? this.message,
      user: user ?? this.user
    );
  }
}
