import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/gen/fonts.gen.dart';

class AppTheme {
  static ThemeData theme(ColorScheme colorScheme) {
    return ThemeData(
      scaffoldBackgroundColor: Colors.black,
      colorScheme: colorScheme,
      fontFamily: FontFamily.neuzeit,
    );
  }
}
