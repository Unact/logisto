part of 'home_page.dart';

enum HomeStateStatus {
  initial,
}

class HomeState {
  HomeState({
    this.status = HomeStateStatus.initial
  });

  final HomeStateStatus status;

  HomeState copyWith({
    HomeStateStatus? status
  }) {
    return HomeState(
      status: status ?? this.status
    );
  }
}
