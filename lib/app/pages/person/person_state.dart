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
    this.fullVersion = '',
    this.newVersionAvailable = false,
    this.message = '',
  });

  final String message;
  final User? user;
  final String fullVersion;
  final bool newVersionAvailable;
  final PersonStateStatus status;

  PersonState copyWith({
    PersonStateStatus? status,
    User? user,
    String? fullVersion,
    bool? newVersionAvailable,
    String? message
  }) {
    return PersonState(
      status: status ?? this.status,
      user: user ?? this.user,
      fullVersion: fullVersion ?? this.fullVersion,
      newVersionAvailable: newVersionAvailable ?? this.newVersionAvailable,
      message: message ?? this.message,
    );
  }
}
