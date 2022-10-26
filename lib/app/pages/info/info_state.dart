
part of 'info_page.dart';

enum InfoStateStatus {
  initial,
  startLoad,
  dataLoaded,
  success,
  failure,
  inProgress,
}

class InfoState {
  InfoState({
    this.status = InfoStateStatus.initial,
    this.orderExList = const [],
    this.productArrivalExList = const [],
    this.newVersionAvailable = false,
    this.message = '',
    this.loading = false,
    this.user
  });

  final List<OrderEx> orderExList;
  final List<ProductArrivalEx> productArrivalExList;
  final bool newVersionAvailable;
  final InfoStateStatus status;
  final String message;
  final bool loading;
  final User? user;

  double get total => user?.total ?? 0;

  InfoState copyWith({
    InfoStateStatus? status,
    List<OrderEx>? orderExList,
    List<ProductArrivalEx>? productArrivalExList,
    bool? newVersionAvailable,
    String? message,
    bool? loading,
    User? user
  }) {
    return InfoState(
      status: status ?? this.status,
      orderExList: orderExList ?? this.orderExList,
      productArrivalExList: productArrivalExList ?? this.productArrivalExList,
      newVersionAvailable: newVersionAvailable ?? this.newVersionAvailable,
      message: message ?? this.message,
      loading: loading ?? this.loading,
      user: user ?? this.user
    );
  }
}
