import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter_ic/extension/context_extension.dart';
import 'package:survey_flutter_ic/extension/string_extension.dart';
import 'package:survey_flutter_ic/theme/dimens.dart';
import 'package:survey_flutter_ic/ui/signin/sign_in_view_model.dart';
import 'package:survey_flutter_ic/ui/signin/sign_in_widget_id.dart';
import 'package:survey_flutter_ic/widget/flat_button_text.dart';
import 'package:survey_flutter_ic/widget/text_input_field.dart';

class SignInForm extends ConsumerStatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInFormState();
}

class _SignInFormState extends ConsumerState<SignInForm> {
  bool _isSignInButtonEnabled = false;
  String _emailInput = "";
  String _passwordInput = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextInputField(
          key: SignInWidgetId.emailInputField,
          hintText: context.localization.sign_in_email_label,
          textInputType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onChanged: (input) => {
            setState(() {
              _emailInput = input;
              _validateInputFields();
            })
          },
          onSubmitted: (input) => {
            setState(() {
              _emailInput = input;
              _validateInputFields();
            })
          },
        ),
        const SizedBox(height: space20),
        TextInputField(
          key: SignInWidgetId.passwordInputField,
          hintText: context.localization.sign_in_password_label,
          textInputAction: TextInputAction.done,
          isObscureText: true,
          onChanged: (input) => {
            setState(() {
              _passwordInput = input;
              _validateInputFields();
            })
          },
          onSubmitted: (input) => {
            setState(() {
              _passwordInput = input;
              _validateInputFields();
            })
          },
        ),
        const SizedBox(height: space20),
        FlatButtonText(
          key: SignInWidgetId.signInButton,
          text: context.localization.sign_in_button,
          isEnabled: _isSignInButtonEnabled,
          onPressed: () => {
            context.hideKeyboard(),
            ref
                .read(signInViewModelProvider.notifier)
                .signIn(_emailInput, _passwordInput)
          },
        )
      ],
    );
  }

  _validateInputFields() {
    setState(() {
      bool isNotEmpty = _emailInput.trim() != "" && _passwordInput.trim() != "";
      bool isValidEmail = _emailInput.isValidEmail();
      _isSignInButtonEnabled = isNotEmpty && isValidEmail;
    });
  }
}
