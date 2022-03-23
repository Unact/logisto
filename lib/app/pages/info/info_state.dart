
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
    this.message = ''
  });

  final List<OrderWithLines> ordersWithLines;
  final bool newVersionAvailable;
  final InfoStateStatus status;
  final String message;

  InfoState copyWith({
    InfoStateStatus? status,
    List<OrderWithLines>? ordersWithLines,
    bool? newVersionAvailable,
    String? message
  }) {
    return InfoState(
      status: status ?? this.status,
      ordersWithLines: ordersWithLines ?? this.ordersWithLines,
      newVersionAvailable: newVersionAvailable ?? this.newVersionAvailable,
      message: message ?? this.message
    );
  }
}
