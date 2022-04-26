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
    this.ordersWithLines = const [],
    this.foundOrderWithLine,
    this.message = '',
    this.hasScanner
  });

  final OrdersStateStatus status;
  final List<OrderWithLines> ordersWithLines;
  final OrderWithLines? foundOrderWithLine;
  final String message;
  final bool? hasScanner;

  OrdersState copyWith({
    OrdersStateStatus? status,
    List<OrderWithLines>? ordersWithLines,
    Optional<OrderWithLines>? foundOrderWithLine,
    String? message,
    bool? hasScanner
  }) {
    return OrdersState(
      status: status ?? this.status,
      ordersWithLines: ordersWithLines ?? this.ordersWithLines,
      foundOrderWithLine: foundOrderWithLine != null ? foundOrderWithLine.orNull : this.foundOrderWithLine,
      message: message ?? this.message,
      hasScanner: hasScanner ?? this.hasScanner
    );
  }
}
