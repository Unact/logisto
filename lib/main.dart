import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app/app.dart';
import 'app/constants/strings.dart';
import 'app/pages/landing/landing_page.dart';

void main() async {

  runZonedGuarded<Future<void>>(() async {
    await App.init();

    runApp(MaterialApp(
      title: Strings.ruAppName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        platform: TargetPlatform.android,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      builder: (context, child) => MediaQuery(
        // Temporary fix for https://github.com/AbdulRahmanAlHamali/flutter_typeahead/issues/463
        data: MediaQuery.of(context).copyWith(accessibleNavigation: false),
        child: child!,
      ),
      home: LandingPage(),
      locale: const Locale('ru', 'RU'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ru', 'RU'),
      ]
    ));
  }, (Object error, StackTrace stackTrace) {
    App.reportError(error, stackTrace);
  });
}
