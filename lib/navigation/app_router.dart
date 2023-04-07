import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/ui/home/home_screen.dart';
import 'package:survey_flutter_ic/ui/signin/sign_in_screen.dart';
import 'package:survey_flutter_ic/ui/splash/splash_screen.dart';

enum RoutePath {
  root('/'),
  home('/home'),
  signIn('/sign_in');

  const RoutePath(this.path);

  final String path;
}

@Singleton()
class AppRouter {
  GoRouter router([String? initialLocation]) => GoRouter(
        initialLocation: initialLocation ?? RoutePath.root.path,
        routes: <GoRoute>[
          GoRoute(
            path: RoutePath.root.path,
            builder: (BuildContext context, GoRouterState state) =>
                const SplashScreen(),
          ),
          GoRoute(
            path: RoutePath.signIn.path,
            builder: (BuildContext context, GoRouterState state) =>
                const SignInScreen(),
          ),
          GoRoute(
            path: RoutePath.home.path,
            builder: (BuildContext context, GoRouterState state) =>
                const HomeScreen(),
          ),
        ],
      );
}
