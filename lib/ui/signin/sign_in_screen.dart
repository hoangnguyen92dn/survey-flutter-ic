import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_flutter_ic/extension/toast_extension.dart';
import 'package:survey_flutter_ic/gen/assets.gen.dart';
import 'package:survey_flutter_ic/navigation/app_router.dart';
import 'package:survey_flutter_ic/theme/dimens.dart';
import 'package:survey_flutter_ic/ui/signin/sign_in_form.dart';
import 'package:survey_flutter_ic/ui/signin/sign_in_view_model.dart';
import 'package:survey_flutter_ic/ui/signin/sign_in_view_state.dart';

final _loadingStateProvider = StateProvider.autoDispose<bool>((_) => false);

class SignInScreen extends ConsumerWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<SignInViewState>(signInViewModelProvider, (_, state) {
      state.maybeWhen(
          success: () => {
                ref.read(_loadingStateProvider.notifier).state = false,
                context.go(routePathHomeScreen)
              },
          loading: () {
            ref.read(_loadingStateProvider.notifier).state = true;
          },
          error: (message) => {
                ref.read(_loadingStateProvider.notifier).state = false,
                showToastMessage(message)
              },
          orElse: () => {});
    });
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Assets.images.bgSplash.path),
              opacity: 0.6,
              fit: BoxFit.fill),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black26, Colors.black])),
            child: _buildSignInForm(context, ref),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInForm(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: space16, vertical: space10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Assets.images.icLogo
                      .svg(width: 168, height: 40, fit: BoxFit.none),
                ),
                Stack(
                  children: [
                    const SignInForm(),
                    _buildLoadingIndicator(),
                  ],
                ),
                const Expanded(
                  child: SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return Consumer(builder: (context, widgetRef, _) {
      bool isLoading = widgetRef.watch(_loadingStateProvider);
      return Center(
        child: Visibility(
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: isLoading,
          child: Container(
              margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
              child: const CircularProgressIndicator()),
        ),
      );
    });
  }
}
