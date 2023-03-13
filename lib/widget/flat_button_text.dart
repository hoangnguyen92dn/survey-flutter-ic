import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/extension/context_extension.dart';
import 'package:survey_flutter_ic/theme/colors.dart';
import 'package:survey_flutter_ic/theme/dimens.dart';

class FlatButtonText extends StatefulWidget {
  final String text;
  final bool isEnabled;
  final Function() onPressed;

  const FlatButtonText({
    super.key,
    required this.text,
    required this.isEnabled,
    required this.onPressed,
  });

  @override
  State<FlatButtonText> createState() => _FlatButtonTextState();
}

class _FlatButtonTextState extends State<FlatButtonText> {
  bool _isEnabled = false;

  @override
  void initState() {
    super.initState();
    _isEnabled = widget.isEnabled;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _isEnabled ? widget.onPressed : null,
      style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: space18),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius10)))),
      child: Text(
        context.localization.sign_in_button,
        style: TextStyle(
            color: _isEnabled ? textColorGray : textColorGrayDisabled,
            fontSize: fontSize17,
            fontWeight: FontWeight.w800),
      ),
    );
  }

  void setEnable(bool isEnabled) {
    setState(() {
      _isEnabled = isEnabled;
    });
  }
}
