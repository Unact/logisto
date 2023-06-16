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
    bool isLoggedIn = store.usersRepo.isLoggedIn;

    emit(state.copyWith(
      status: LandingStateStatus.dataLoaded,
      isLoggedIn: isLoggedIn
    ));
  }

  Future<void> _maybeLogout() async {
    Pref pref = await store.getPref();

    if (pref.logoutAfter.difference(DateTime.now()).inSeconds >= 0) return;

    await store.usersRepo.logout();
  }
}
