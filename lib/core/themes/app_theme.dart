import 'package:demandes/core/themes/app_palette.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static const _border = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.all(Radius.circular(10.0)));

  static final darkThemeMode = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppPalette.scaffoldLightBackgroundColor,
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.black87,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 30),
        border: _border.copyWith(borderSide: BorderSide.none),
        focusedBorder: _border,
      ));

  static final lightThemeMode = ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPalette.scaffoldLightBackgroundColor,
    ),
    scaffoldBackgroundColor: AppPalette.scaffoldLightBackgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 30),
      border: _border.copyWith(borderSide: BorderSide.none),
      focusedBorder: _border,
    ),
  );
}
