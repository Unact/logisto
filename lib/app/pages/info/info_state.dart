
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
    this.ordersWithLines = const [],
    this.newVersionAvailable = false,
    this.message = '',
    this.loading = false,
    this.user
  });

  final List<OrderWithLines> ordersWithLines;
  final bool newVersionAvailable;
  final InfoStateStatus status;
  final String message;
  final bool loading;
  final User? user;

  double get total => user?.total ?? 0;

  InfoState copyWith({
    InfoStateStatus? status,
    List<OrderWithLines>? ordersWithLines,
    bool? newVersionAvailable,
    String? message,
    bool? loading,
    User? user
  }) {
    return InfoState(
      status: status ?? this.status,
      ordersWithLines: ordersWithLines ?? this.ordersWithLines,
      newVersionAvailable: newVersionAvailable ?? this.newVersionAvailable,
      message: message ?? this.message,
      loading: loading ?? this.loading,
      user: user ?? this.user
    );
  }
}
