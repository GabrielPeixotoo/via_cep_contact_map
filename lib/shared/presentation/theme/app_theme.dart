import 'package:flutter/material.dart';

import '../../shared.dart';

abstract class AppTheme {
  static ThemeData defaultThemeData = themeData(defaultColorScheme, AppColors.black.withOpacity(0.12));

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) => ThemeData(
        canvasColor: colorScheme.background,
        disabledColor: colorScheme.onBackground.withAlpha(40),
        dividerColor: colorScheme.onBackground.withAlpha(40),
        elevatedButtonTheme: elevatedButtonThemeData(colorScheme),
        focusColor: focusColor,
        fontFamily: 'Inter',
        highlightColor: AppColors.transparent,
        iconTheme: IconThemeData(color: colorScheme.onPrimary),
        inputDecorationTheme: inputDecorationTheme(colorScheme),
        primaryColor: colorScheme.primary,
        primaryColorLight: colorScheme.primaryContainer,
        scaffoldBackgroundColor: colorScheme.background,
        splashColor: AppColors.white.withOpacity(0.2),
        colorScheme: colorScheme.copyWith(error: colorScheme.error),
      );

  static const ColorScheme defaultColorScheme = ColorScheme(
    background: AppColors.white,
    brightness: Brightness.light,
    error: AppColors.red,
    onBackground: AppColors.black,
    onError: AppColors.white,
    onPrimary: AppColors.white,
    onSecondary: AppColors.white,
    onSurface: AppColors.black,
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    surface: AppColors.white,
  );

  static ElevatedButtonThemeData elevatedButtonThemeData(
    ColorScheme colorScheme,
  ) =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          disabledForegroundColor: colorScheme.onSurface.withOpacity(0.38),
          disabledBackgroundColor: colorScheme.onSurface.withOpacity(0.12),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: AppTextTheme.subtitle1.copyWith(color: colorScheme.onPrimary),
        ),
      );

  static InputDecorationTheme inputDecorationTheme(
    ColorScheme colorScheme,
  ) =>
      InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: colorScheme.onBackground.withAlpha(80),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: colorScheme.error,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: colorScheme.onBackground.withAlpha(200),
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: colorScheme.onBackground.withAlpha(40),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: colorScheme.error,
          ),
        ),
        labelStyle: AppTextTheme.title2,
        hintStyle: AppTextTheme.subtitle1.copyWith(
          color: colorScheme.onBackground.withAlpha(40),
        ),
      );
}
