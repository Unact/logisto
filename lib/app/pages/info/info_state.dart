
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
    this.orderExtendedList = const [],
    this.newVersionAvailable = false,
    this.message = '',
    this.loading = false,
    this.user
  });

  final List<OrderExtended> orderExtendedList;
  final bool newVersionAvailable;
  final InfoStateStatus status;
  final String message;
  final bool loading;
  final User? user;

  double get total => user?.total ?? 0;

  InfoState copyWith({
    InfoStateStatus? status,
    List<OrderExtended>? orderExtendedList,
    bool? newVersionAvailable,
    String? message,
    bool? loading,
    User? user
  }) {
    return InfoState(
      status: status ?? this.status,
      orderExtendedList: orderExtendedList ?? this.orderExtendedList,
      newVersionAvailable: newVersionAvailable ?? this.newVersionAvailable,
      message: message ?? this.message,
      loading: loading ?? this.loading,
      user: user ?? this.user
    );
  }
}
