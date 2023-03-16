import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:survey_flutter_ic/api/service/auth_service.dart';
import 'package:survey_flutter_ic/di/provider/di.dart';
import 'package:survey_flutter_ic/main.dart';
import 'package:survey_flutter_ic/navigation/route.dart';

import '../fake_data/fake_services/fake_auth_service.dart';

class TestUtil {
  /// This is useful when we test the whole app with the real configs(styling,
  /// localization, routes, etc)
  static Widget pumpWidgetWithRealApp(String initialRoute) {
    _initDependencies();
    return MyApp();
  }

  /// We normally use this function to test a specific [widget] without
  /// considering much about theming.
  static Widget pumpWidgetWithShellApp(Widget widget) {
    _initDependencies();
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: widget,
    );
  }

  static Widget pumpWidgetWithRoutePath(String route) {
    _initDependencies();

    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }

  static void _initDependencies() {
    PackageInfo.setMockInitialValues(
        appName: 'Flutter templates testing',
        packageName: '',
        version: '',
        buildNumber: '',
        buildSignature: '',
        installerStore: '');
    FlutterConfig.loadValueForTesting({'SECRET': 'This is only for testing'});
  }

  static Future setupTestEnvironment() async {
    _initDependencies();
    getIt.allowReassignment = true;
    getIt.registerSingleton<AuthService>(FakeAuthService());
    configureInjection();
  }
}
