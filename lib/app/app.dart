import 'dart:async';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/repositories/app_store.dart';

class App {
  final String version;
  final String buildNumber;
  final AppStore store;

  App._({
    required this.version,
    required this.buildNumber,
    required this.store
  }) {
    _instance = this;
  }

  static App? _instance;
  static App? get instance => _instance;

  static Future<App> init() async {
    if (_instance != null) return _instance!;

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    bool isDebug = Misc.isDebug();
    AppStore repository = AppStore(
      dataStore: AppDataStore(logStatements: isDebug),
      api: await RenewApi.init(appName: Strings.appName)
    );

    await Initialization.initializeSentry(
      dsn: const String.fromEnvironment('LOGISTO_SENTRY_DSN'),
      isDebug: isDebug,
      userGenerator: () async {
        User user = await repository.usersRepo.getUser();

        return SentryUser(id: user.id.toString(), username: user.username, email: user.email);
      }
    );
    Initialization.intializeFlogs(isDebug: isDebug);

    return App._(
      version: packageInfo.version,
      buildNumber: packageInfo.buildNumber,
      store: repository
    );
  }

  AppDataStore get dataStore => store.dataStore;

  Future<bool> get newVersionAvailable async {
    String remoteVersion = (await store.usersRepo.getUser()).version;

    return Version.parse(remoteVersion) > Version.parse(version);
  }

  String get fullVersion => '$version+$buildNumber';
}
