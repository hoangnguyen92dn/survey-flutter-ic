import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/ui/details/survey_details_screen.dart';
import 'package:survey_flutter_ic/ui/home/home_screen.dart';
import 'package:survey_flutter_ic/ui/questions/survey_questions_screen.dart';
import 'package:survey_flutter_ic/ui/signin/sign_in_screen.dart';
import 'package:survey_flutter_ic/ui/splash/splash_screen.dart';
import 'package:survey_flutter_ic/ui/surveys/survey_ui_model.dart';
import 'package:survey_flutter_ic/usecase/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecase/is_authorized_use_case.dart';

enum RoutePath {
  root('/'),
  signIn('/sign_in'),
  home('/home'),

  details('details'),
  questions('questions/:$surveyIdKey');

  const RoutePath(this.routePath);

  final String routePath;

  String get routeName {
    switch (this) {
      case RoutePath.root:
        return '/';
      case RoutePath.details:
        return 'details';
      case RoutePath.questions:
        return 'questions';
      default:
        return routePath.replaceAll(RegExp('^/|/\$'), '');
    }
  }
}

@Singleton()
class AppRouter {
  final IsAuthorizedUseCase _isAuthorizedUseCase;

  AppRouter(this._isAuthorizedUseCase);

  GoRouter router([String? initialLocation, Object? extra]) => GoRouter(
        initialLocation: initialLocation ?? RoutePath.root.routePath,
        initialExtra: extra,
        routes: <GoRoute>[
          GoRoute(
            name: RoutePath.root.routeName,
            path: RoutePath.root.routePath,
            builder: (BuildContext context, GoRouterState state) =>
                const SplashScreen(),
          ),
          GoRoute(
            name: RoutePath.signIn.routeName,
            path: RoutePath.signIn.routePath,
            builder: (BuildContext context, GoRouterState state) =>
                const SignInScreen(),
            redirect: (BuildContext context, GoRouterState state) async {
              return _isAuthorizedUseCase.call().then(
                    (isAuthorized) => isAuthorized is Success &&
                            (isAuthorized as Success<bool>).value
                        ? RoutePath.home.routePath
                        : RoutePath.signIn.routePath,
                  );
            },
          ),
          GoRoute(
            name: RoutePath.home.routeName,
            path: RoutePath.home.routePath,
            builder: (BuildContext context, GoRouterState state) =>
                const HomeScreen(),
            routes: [
              GoRoute(
                name: RoutePath.details.routeName,
                path: RoutePath.details.routePath,
                builder: (BuildContext context, GoRouterState state) {
                  return SurveyDetailsScreen(
                    survey: (state.extra as SurveyUiModel),
                  );
                },
              ),
              GoRoute(
                name: RoutePath.questions.routeName,
                path: RoutePath.questions.routePath,
                builder: (BuildContext context, GoRouterState state) {
                  return SurveyQuestionsScreen(
                    surveyId: state.params[surveyIdKey] as String,
                  );
                },
              ),
            ],
          ),
        ],
      );
}
