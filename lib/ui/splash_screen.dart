import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_flutter_ic/gen/assets.gen.dart';
import 'package:survey_flutter_ic/main.dart';

const _splashTransitionDelayInMilliseconds = 2000;
const _logoVisibilityDelayInMilliseconds = 500;
const _logoVisibilityAnimationInMilliseconds = 1000;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _logoVisible = false;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    Future.delayed(
        const Duration(milliseconds: _splashTransitionDelayInMilliseconds), () {
      context.go(routePathSignInScreen);
    });

    Future.delayed(
        const Duration(milliseconds: _logoVisibilityDelayInMilliseconds), () {
      setState(() {
        _logoVisible = true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Assets.images.bgSplash.path), fit: BoxFit.fill),
        ),
        child: Center(
          child: AnimatedOpacity(
            duration: const Duration(
                milliseconds: _logoVisibilityAnimationInMilliseconds),
            opacity: _logoVisible ? 1.0 : 0.0,
            child: Assets.images.icLogo.svg(),
          ),
        ),
      ),
    );
  }
}
