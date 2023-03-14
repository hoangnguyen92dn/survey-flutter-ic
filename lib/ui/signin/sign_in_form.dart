import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/extension/context_extension.dart';
import 'package:survey_flutter_ic/theme/dimens.dart';
import 'package:survey_flutter_ic/widget/flat_button_text.dart';
import 'package:survey_flutter_ic/widget/text_input_field.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool _isSignInButtonEnabled = false;
  String? _emailInput;
  String? _passwordInput;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextInputField(
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
          text: context.localization.sign_in_button,
          isEnabled: _isSignInButtonEnabled,
          onPressed: () => {
            // TODO: Integrate ViewModel signIn
          },
        )
      ],
    );
  }

  _validateInputFields() {
    setState(() {
      bool isNotNull = _emailInput != null && _passwordInput != null;
      bool isNotEmpty =
          _emailInput?.trim() != "" && _passwordInput?.trim() != "";
      _isSignInButtonEnabled = isNotNull && isNotEmpty;
    });
  }
}
