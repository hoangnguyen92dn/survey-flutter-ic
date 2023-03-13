import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/gen/assets.gen.dart';

class AppTheme {
  static ThemeData theme(ColorScheme colorScheme) {
    return ThemeData(
      primaryColor: colorScheme.primary,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme(
        primary: colorScheme.primary,
        secondary: colorScheme.secondary,
        surface: Colors.white,
        background: Colors.white,
        error: colorScheme.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.black,
        onBackground: Colors.black,
        onError: Colors.white,
        brightness: colorScheme.brightness,
      ),
      fontFamily: Assets.fonts.neuzeit,
    );
  }
}
