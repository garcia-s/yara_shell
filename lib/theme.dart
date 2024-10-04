import 'package:flutter/material.dart';

final themeData = ThemeData(
  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      shape: WidgetStatePropertyAll<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  ),
  colorSchemeSeed: Colors.blue,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
  ),
);
