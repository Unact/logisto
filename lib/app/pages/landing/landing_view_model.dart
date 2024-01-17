part of 'landing_page.dart';

class LandingViewModel extends PageViewModel<LandingState, LandingStateStatus> {
  final AppRepository appRepository;
  final UsersRepository usersRepository;

  StreamSubscription<AppInfoResult>? appInfoSubscription;
  StreamSubscription<bool>? isLoggedInSubscription;

  LandingViewModel(this.appRepository, this.usersRepository) : super(LandingState());

  @override
  LandingStateStatus get status => state.status;

  @override
  Future<void> initViewModel() async {
    await super.initViewModel();

    isLoggedInSubscription = usersRepository.isLoggedIn.listen((event) {
      emit(state.copyWith(status: LandingStateStatus.dataLoaded, isLoggedIn: event));
    });
    appInfoSubscription = appRepository.watchAppInfo().listen((event) {

      if (event.logoutAfter.difference(DateTime.now()).inSeconds >= 0) return;

      usersRepository.logout();
    });
  }

  @override
  Future<void> close() async {
    await super.close();

    await isLoggedInSubscription?.cancel();
    await appInfoSubscription?.cancel();
  }
}
