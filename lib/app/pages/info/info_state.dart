
part of 'info_page.dart';

enum InfoStateStatus {
  initial,
  startLoad,
  dataLoaded,
  success,
  failure,
  inProgress,
  startTransfer
}

class InfoState {
  InfoState({
    this.status = InfoStateStatus.initial,
    this.appInfo,
    this.message = '',
    this.loading = false,
    this.user,
    this.productTransferEx
  });

  final AppInfoResult? appInfo;
  final InfoStateStatus status;
  final String message;
  final bool loading;
  final User? user;
  final ProductTransferEx? productTransferEx;

  double get total => user?.total ?? 0;

  InfoState copyWith({
    InfoStateStatus? status,
    AppInfoResult? appInfo,
    String? message,
    bool? loading,
    User? user,
    Optional<ProductTransferEx>? productTransferEx
  }) {
    return InfoState(
      status: status ?? this.status,
      appInfo: appInfo ?? this.appInfo,
      message: message ?? this.message,
      loading: loading ?? this.loading,
      user: user ?? this.user,
      productTransferEx: productTransferEx != null ? productTransferEx.orNull : this.productTransferEx
    );
  }
}
