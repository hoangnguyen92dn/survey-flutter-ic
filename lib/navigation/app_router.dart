import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/ui/details/survey_details_screen.dart';
import 'package:survey_flutter_ic/ui/home/home_screen.dart';
import 'package:survey_flutter_ic/ui/signin/sign_in_screen.dart';
import 'package:survey_flutter_ic/ui/splash/splash_screen.dart';
import 'package:survey_flutter_ic/ui/surveys/survey_ui_model.dart';

enum RoutePath {
  root('/'),
  home('/home'),
  details('details'),
  signIn('/sign_in');

  const RoutePath(this.path);

  final String path;
}

enum RouteName {
  root('splash'),
  home('home'),
  details('details'),
  signIn('sign_in');

  const RouteName(this.name);

  final String name;
}

@Singleton()
class AppRouter {
  GoRouter router([String? initialLocation]) => GoRouter(
        initialLocation: initialLocation ?? RoutePath.root.path,
        routes: <GoRoute>[
          GoRoute(
            name: RouteName.root.name,
            path: RoutePath.root.path,
            builder: (BuildContext context, GoRouterState state) =>
                const SplashScreen(),
          ),
          GoRoute(
            name: RouteName.signIn.name,
            path: RoutePath.signIn.path,
            builder: (BuildContext context, GoRouterState state) =>
                const SignInScreen(),
          ),
          GoRoute(
            name: RouteName.home.name,
            path: RoutePath.home.path,
            builder: (BuildContext context, GoRouterState state) =>
                const HomeScreen(),
            routes: [
              GoRoute(
                name: RouteName.details.name,
                path: RoutePath.details.path,
                builder: (BuildContext context, GoRouterState state) {
                  return SurveyDetailsScreen(
                    survey: (state.extra as SurveyUiModel),
                  );
                },
              ),
            ],
          ),
        ],
      );
}
