part of 'orders_qr_scan_page.dart';

enum OrdersQRScanPageStateStatus {
  initial,
  dataLoaded,
  scanReadFailure,
  scanReadFinished,
  inProgress,
  failure,
  success
}

class OrdersQRScanPageState {
  OrdersQRScanPageState({
    this.status = OrdersQRScanPageStateStatus.initial,
    this.orderExList = const [],
    this.orderScanned = const {},
    this.message = ''
  });

  final OrdersQRScanPageStateStatus status;
  final List<OrderEx> orderExList;
  final String message;
  final Map<OrderEx, List<bool>> orderScanned;

  OrdersQRScanPageState copyWith({
    OrdersQRScanPageStateStatus? status,
    Map<OrderEx, List<bool>>? orderScanned,
    List<OrderEx>? orderExList,
    String? message
  }) {
    return OrdersQRScanPageState(
      status: status ?? this.status,
      orderExList: orderExList ?? this.orderExList,
      orderScanned: orderScanned ?? this.orderScanned,
      message: message ?? this.message
    );
  }
}
