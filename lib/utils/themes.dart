import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme.light(
  brightness: Brightness.dark,
  primary: Colors.black,
  secondary: Colors.white,
  primaryContainer: Colors.blue,
  onPrimaryContainer: Colors.white,
  surface: Colors.white,
);
const darkColorScheme = ColorScheme.dark(
  brightness: Brightness.dark,
  primary: Colors.white,
  secondary: Colors.black,
  primaryContainer: Colors.blue,
  onPrimaryContainer: Colors.white,
  surface: Colors.black,
);

final lightTheme = ThemeData(
  colorScheme: lightColorScheme,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: darkColorScheme.secondary),
    actionsIconTheme: IconThemeData(color: darkColorScheme.secondary),
    scrolledUnderElevation: 0,
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: lightColorScheme.primaryContainer,
    textTheme: ButtonTextTheme.primary,
  ),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: Colors.grey[500]!,
        width: 0.5,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: Colors.grey[500]!,
        width: 0.5,
      ),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: Colors.grey[500]!,
        width: 0.5,
      ),
    ),
    hintStyle: TextStyle(color: Colors.grey[500]!),
    filled: true,
    fillColor: Colors.grey[100],
    labelStyle: TextStyle(color: Colors.grey[500]!),
    floatingLabelStyle: TextStyle(color: Colors.grey[900]!),
  ),
  cupertinoOverrideTheme: CupertinoThemeData(
    primaryColor: darkColorScheme.secondary,
    barBackgroundColor: darkColorScheme.surface,
    textTheme: const CupertinoTextThemeData(
      primaryColor: Colors.black,
    ),
  ),
);

final darkTheme = ThemeData(
  colorScheme: darkColorScheme,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: darkColorScheme.secondary),
    actionsIconTheme: IconThemeData(color: darkColorScheme.secondary),
    scrolledUnderElevation: 0,
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: darkColorScheme.primaryContainer,
    textTheme: ButtonTextTheme.normal,
  ),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: Colors.grey[400]!,
        width: 0.4,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: Colors.grey[400]!,
        width: 0.4,
      ),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: Colors.grey[400]!,
        width: 0.4,
      ),
    ),
    hintStyle: TextStyle(color: Colors.grey[400]!),
    filled: true,
    fillColor: Colors.grey[900],
  ),
  cupertinoOverrideTheme: CupertinoThemeData(
    primaryColor: darkColorScheme.primary,
    barBackgroundColor: darkColorScheme.surface,
    textTheme: const CupertinoTextThemeData(
      primaryColor: Colors.white,
    ),
  ),
);
