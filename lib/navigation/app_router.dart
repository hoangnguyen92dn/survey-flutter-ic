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

  const RoutePath(this.routePath);

  final String routePath;

  get routeName => routePath.replaceAll('/', '');
}

@Singleton()
class AppRouter {
  GoRouter router([String? initialLocation]) => GoRouter(
        initialLocation: initialLocation ?? RoutePath.root.routePath,
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
            ],
          ),
        ],
      );
}
