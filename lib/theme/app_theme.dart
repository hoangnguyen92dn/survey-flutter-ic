import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/gen/assets.gen.dart';

class AppTheme {
  static ThemeData theme(ColorScheme colorScheme) {
    return ThemeData(
      primaryColor: colorScheme.primary,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: colorScheme,
      fontFamily: Assets.fonts.neuzeit,
    );
  }
}
