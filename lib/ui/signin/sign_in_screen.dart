import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/extension/context_extension.dart';
import 'package:survey_flutter_ic/gen/assets.gen.dart';
import 'package:survey_flutter_ic/theme/dimens.dart';
import 'package:survey_flutter_ic/widget/flat_button_text.dart';
import 'package:survey_flutter_ic/widget/text_input_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
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
                child: _buildSignInForm()),
          )),
    );
  }

  Widget _buildSignInForm() {
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
                _buildSignInContent(),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildSignInContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextInputField(
          hintText: context.localization.sign_in_email_label,
          textInputType: TextInputType.emailAddress,
          onChanged: (input) => {
            // TODO: Handle listener: enable/disable SignIn button
          },
          onSubmitted: (input) => {},
        ),
        const SizedBox(height: space20),
        TextInputField(
          hintText: context.localization.sign_in_password_label,
          isObscureText: true,
          obscuringCharacter: "●",
          onChanged: (input) => {
            // TODO: Handle listener: enable/disable SignIn button
          },
          onSubmitted: (input) => {},
        ),
        const SizedBox(height: space20),
        FlatButtonText(
          text: context.localization.sign_in_button,
          isEnabled: false,
          onPressed: () => {
            // TODO: Integrate ViewModel signIn
          },
        )
      ],
    );
  }
}
