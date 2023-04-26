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
import 'package:survey_flutter_ic/widget/loading_indicator.dart';

final _loadingStateProvider = StateProvider.autoDispose<bool>((_) => false);

class SignInScreen extends ConsumerWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<SignInViewState>(signInViewModelProvider, (_, state) {
      state.maybeWhen(
          success: () => {
                ref.read(_loadingStateProvider.notifier).state = false,
                context.goNamed(RoutePath.home.routeName)
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
            child: _buildSignInForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInForm() =>
      Consumer(builder: (_, ref, __) {
        bool isLoading = ref.watch(_loadingStateProvider);
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
                        LoadingIndicator(isVisible: isLoading),
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
      });
}
