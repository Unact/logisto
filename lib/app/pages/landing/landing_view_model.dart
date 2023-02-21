part of 'landing_page.dart';

class LandingViewModel extends PageViewModel<LandingState, LandingStateStatus> {
  LandingViewModel(BuildContext context) : super(context, LandingState());

  @override
  LandingStateStatus get status => state.status;

  @override
  TableUpdateQuery get listenForTables => TableUpdateQuery.onAllTables([
    dataStore.users
  ]);

  @override
  Future<void> initViewModel() async {
    await _maybeLogout();
    await super.initViewModel();
  }

  @override
  Future<void> loadData() async {
    emit(state.copyWith(user: await store.usersRepo.getUser()));
  }

  Future<void> _maybeLogout() async {
    Pref pref = await store.getPref();
    DateTime now = DateTime.now();
    DateTime? lastLogin = pref.lastLogin;

    if (lastLogin == null) return;
    if (now.day == lastLogin.day && now.difference(lastLogin).inDays < 1) return;

    await store.usersRepo.logout();
  }
}
