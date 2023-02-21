import 'dart:async';

import 'package:f_logs/f_logs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:stack_trace/stack_trace.dart';

import 'repositories/app_store.dart';
import 'data/database.dart';

class App {
  final bool isDebug;
  final String version;
  final String buildNumber;
  final AppStore store;

  App._({
    required this.isDebug,
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

    bool isDebug = false;
    assert(isDebug = true);

    WidgetsFlutterBinding.ensureInitialized();

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    await FkUserAgent.init();

    AppStore repository = AppStore(dataStore: AppDataStore(logStatements: isDebug));

    await _initSentry(
      dsn: const String.fromEnvironment('LOGISTO_SENTRY_DSN'),
      capture: !isDebug,
      repository: repository
    );
    _intFlogs(isDebug: isDebug);

    FLog.info(text: 'App Initialized');

    return App._(
      isDebug: isDebug,
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

  String get fullVersion => version + '+' + buildNumber;

  static Future<void> reportError(dynamic error, dynamic stackTrace) async {
    Frame methodFrame = Trace.current().frames.length > 1 ? Trace.current().frames[1] : Trace.current().frames[0];

    FLog.error(
      methodName: methodFrame.member!.split('.')[1],
      text: error.toString(),
      exception: error,
      stacktrace: stackTrace
    );

    debugPrint(error.toString());
    debugPrint(stackTrace.toString());
    await Sentry.captureException(error, stackTrace: stackTrace);
  }

  static void _intFlogs({
    required bool isDebug
  }) {
    LogsConfig config = LogsConfig();

    // В прод режими логируем все
    config.activeLogLevel = isDebug ? LogLevel.INFO : LogLevel.ALL;
    config.formatType = FormatType.FORMAT_SQUARE;
    config.timestampFormat = TimestampFormat.TIME_FORMAT_FULL_3;

    FLog.applyConfigurations(config);
  }

  static Future<void> _initSentry({
    required String dsn,
    required bool capture,
    required AppStore repository
  }) async {
    if (!capture) return;

    await SentryFlutter.init(
      (options) {
        options.dsn = dsn;
        options.beforeSend = (SentryEvent event, {dynamic hint}) async {
          User user = await repository.usersRepo.getUser();

          return event.copyWith(user: SentryUser(
            id: user.id.toString(),
            username: user.username,
            email: user.email
          ));
        };
      },
    );
  }
}
