part of 'landing_page.dart';

enum LandingStateStatus {
  initial,
  dataLoaded
}

class LandingState {
  LandingState({
    this.status = LandingStateStatus.initial,
    this.isLoggedIn = false,
    this.pref
  });

  final bool isLoggedIn;
  final Pref? pref;
  final LandingStateStatus status;

  LandingState copyWith({
    LandingStateStatus? status,
    bool? isLoggedIn,
    Pref? pref
  }) {
    return LandingState(
      status: status ?? this.status,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      pref: pref ?? this.pref
    );
  }
}
