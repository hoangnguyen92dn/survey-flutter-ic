import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_flutter_ic/theme/colors.dart';
import 'package:survey_flutter_ic/theme/dimens.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String description;
  final String positiveActionText;
  final String negativeActionText;
  final VoidCallback onConfirmed;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.description,
    required this.positiveActionText,
    required this.negativeActionText,
    required this.onConfirmed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: dialogBackground.withOpacity(0.9),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: fontSize17,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        description,
        style: const TextStyle(
          color: Colors.white,
          fontSize: fontSize17,
          fontWeight: FontWeight.normal,
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            context.pop(true);
            onConfirmed.call();
          },
          child: Text(
            positiveActionText,
            style: const TextStyle(
              color: dialogButtonColor,
              fontSize: fontSize17,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        TextButton(
          onPressed: () => context.pop(false),
          child: Text(
            negativeActionText,
            style: const TextStyle(
              color: dialogButtonColor,
              fontSize: fontSize17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
