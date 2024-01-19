part of 'person_page.dart';

enum PersonStateStatus {
  initial,
  dataLoaded,
  inProgress,
  loggedOut,
  failure
}

class PersonState {
  PersonState({
    this.status = PersonStateStatus.initial,
    this.user,
    this.message = '',
  });

  final String message;
  final User? user;
  final PersonStateStatus status;

  PersonState copyWith({
    PersonStateStatus? status,
    User? user,
    String? message
  }) {
    return PersonState(
      status: status ?? this.status,
      user: user ?? this.user,
      message: message ?? this.message,
    );
  }
}
