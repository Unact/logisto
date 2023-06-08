part of 'person_page.dart';

class PersonViewModel extends PageViewModel<PersonState, PersonStateStatus> {
  static const String _kManifestRepoUrl = 'https://unact.github.io/mobile_apps/logisto';
  static const String _kAppRepoUrl = 'https://github.com/Unact/logisto';

  PersonViewModel(BuildContext context) : super(context, PersonState());

  @override
  PersonStateStatus get status => state.status;

  @override
  TableUpdateQuery get listenForTables => TableUpdateQuery.onAllTables([
    dataStore.users
  ]);

  @override
  Future<void> loadData() async {
    emit(state.copyWith(
      status: PersonStateStatus.dataLoaded,
      user: await store.usersRepo.getUser(),
      fullVersion: app.fullVersion,
      newVersionAvailable: await app.newVersionAvailable,
    ));
  }

  Future<void> apiLogout() async {
    emit(state.copyWith(status: PersonStateStatus.inProgress));

    try {
      await store.usersRepo.logout();

      emit(state.copyWith(status: PersonStateStatus.loggedOut));
    } on AppError catch(e) {
      emit(state.copyWith(status: PersonStateStatus.failure, message: e.message));
    }
  }

  Future<void> launchAppUpdate() async {
    String version = state.user!.version;
    String androidUpdateUrl = '$_kAppRepoUrl/releases/download/$version/app-release.apk';
    String iosUpdateUrl = 'itms-services://?action=download-manifest&url=$_kManifestRepoUrl/manifest.plist';
    Uri uri = Uri.parse(Platform.isIOS ? iosUpdateUrl : androidUpdateUrl);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      emit(state.copyWith(status: PersonStateStatus.failure, message: Strings.genericErrorMsg));
    }
  }
}
