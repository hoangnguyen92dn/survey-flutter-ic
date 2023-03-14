import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/theme/dimens.dart';

class TextInputField extends StatefulWidget {
  final String hintText;
  final TextInputType? textInputType;
  final bool isObscureText;
  final String? obscuringCharacter;
  final Function(String) onChanged;
  final Function(String) onSubmitted;

  const TextInputField({
    super.key,
    required this.hintText,
    this.textInputType,
    this.isObscureText = false,
    this.obscuringCharacter,
    required this.onChanged,
    required this.onSubmitted,
  });

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white12,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius12),
            borderSide: const BorderSide(
              width: 0.0,
              style: BorderStyle.none,
            ),
          ),
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.white30)),
      cursorColor: Colors.white,
      keyboardType: widget.textInputType,
      style: const TextStyle(color: Colors.white),
      obscureText: widget.isObscureText,
      obscuringCharacter:
          (widget.isObscureText) ? widget.obscuringCharacter ?? "●" : "●",
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
    );
  }
}
