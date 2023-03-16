import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_flutter_ic/main.dart';
import 'package:survey_flutter_ic/ui/signin/sign_in_screen.dart';
import 'package:survey_flutter_ic/ui/splash_screen.dart';

const routePathRootScreen = '/';
const routePathHomeScreen = '/home';
const routePathSignInScreen = '/sign_in';

GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: routePathRootScreen,
      builder: (BuildContext context, GoRouterState state) =>
          const SplashScreen(),
    ),
    GoRoute(
      path: routePathSignInScreen,
      builder: (BuildContext context, GoRouterState state) =>
          const SignInScreen(),
    ),
    GoRoute(
      path: routePathHomeScreen,
      builder: (BuildContext context, GoRouterState state) =>
          const HomeScreen(),
    ),
  ],
);
