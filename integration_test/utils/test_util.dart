import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:survey_flutter_ic/api/repository/auth_repository.dart';
import 'package:survey_flutter_ic/api/repository/survey_repository.dart';
import 'package:survey_flutter_ic/api/repository/user_repository.dart';
import 'package:survey_flutter_ic/database/hive_persistence.dart';
import 'package:survey_flutter_ic/di/provider/di.dart';
import 'package:survey_flutter_ic/main.dart';
import 'package:survey_flutter_ic/navigation/app_router.dart';

import '../fake_data/fake_persistence/fake_survey_persistence.dart';
import '../fake_data/fake_services/fake_auth_service.dart';
import '../fake_data/fake_services/fake_survey_service.dart';
import '../fake_data/fake_services/fake_user_service.dart';

class TestUtil {
  /// This is useful when we test the whole app with the real configs(styling,
  /// localization, routes, etc)
  static Widget pumpWidgetWithRealApp(String initialRoute) {
    _initDependencies();
    return const MyApp();
  }

  /// We normally use this function to test a specific [widget] without
  /// considering much about theming.
  static Widget pumpWidgetWithShellApp(Widget widget) {
    _initDependencies();
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: ProviderScope(child: widget),
    );
  }

  static Widget pumpWidgetWithRoutePath(String route, {Object? extra}) {
    _initDependencies();

    final router = getIt.get<AppRouter>().router(route, extra);

    return ProviderScope(
        child: MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    ));
  }

  static void _initDependencies() {
    PackageInfo.setMockInitialValues(
        appName: 'Flutter IC testing',
        packageName: '',
        version: '',
        buildNumber: '',
        buildSignature: '',
        installerStore: '');
    FlutterConfig.loadValueForTesting({'CLIENT_SECRET': 'CLIENT_SECRET'});
    FlutterConfig.loadValueForTesting({'CLIENT_ID': 'CLIENT_ID'});
    FlutterConfig.loadValueForTesting(
        {'REST_API_ENDPOINT': 'REST_API_ENDPOINT'});
  }

  static Future setupTestEnvironment() async {
    _initDependencies();
    await initHivePersistence();

    await configureInjection();
    getIt.allowReassignment = true;

    // FIXME: Can not mock the Service layer
    // getIt.registerSingleton<AuthService>(FakeAuthService());
    // getIt.registerSingleton<UserService>(FakeUserService());
    // getIt.registerSingleton<SurveyService>(FakeSurveyService());

    getIt.registerSingleton<AuthRepository>(
        AuthRepositoryImpl(FakeAuthService()));
    getIt.registerSingleton<UserRepository>(
        UserRepositoryImpl(FakeUserService()));
    getIt.registerSingleton<SurveyRepository>(SurveyRepositoryImpl(
      FakeSurveyService(),
      FakeSurveyPersistence(),
    ));
  }
}
