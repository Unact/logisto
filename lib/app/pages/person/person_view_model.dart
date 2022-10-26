part of 'person_page.dart';

class PersonViewModel extends PageViewModel<PersonState, PersonStateStatus> {
  static const String _kRepoUrl = 'https://unact.github.io/mobile_apps/logisto';

  PersonViewModel(BuildContext context) : super(context, PersonState());

  @override
  PersonStateStatus get status => state.status;

  @override
  TableUpdateQuery get listenForTables => TableUpdateQuery.onAllTables([
    app.dataStore.users
  ]);

  @override
  Future<void> loadData() async {
    emit(state.copyWith(
      status: PersonStateStatus.dataLoaded,
      user: await app.dataStore.usersDao.getUser(),
      fullVersion: app.fullVersion,
      newVersionAvailable: await app.newVersionAvailable,
    ));
  }

  Future<void> apiLogout() async {
    emit(state.copyWith(status: PersonStateStatus.inProgress));

    try {
      await app.logout();

      emit(state.copyWith(status: PersonStateStatus.loggedOut));
    } on AppError catch(e) {
      emit(state.copyWith(status: PersonStateStatus.failure, message: e.message));
    }
  }

  Future<void> launchAppUpdate() async {
    String version = state.user!.version;
    String androidUpdateUrl = '$_kRepoUrl/releases/download/$version/app-release.apk';
    String iosUpdateUrl = 'itms-services://?action=download-manifest&url=$_kRepoUrl/manifest.plist';
    String url = Platform.isIOS ? iosUpdateUrl : androidUpdateUrl;

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      emit(state.copyWith(status: PersonStateStatus.failure, message: Strings.genericErrorMsg));
    }
  }
}
