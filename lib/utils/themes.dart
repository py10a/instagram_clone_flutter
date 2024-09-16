import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme.light(
  brightness: Brightness.dark,
  primary: Colors.blue,
  onPrimary: Colors.white,
);
const darkColorScheme = ColorScheme.dark(
  brightness: Brightness.dark,
  primary: Colors.blue,
  onPrimary: Colors.white,
);

final lightTheme = ThemeData(
  colorScheme: lightColorScheme,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
    actionsIconTheme: IconThemeData(color: Colors.black),
    scrolledUnderElevation: 0,
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: lightColorScheme.primary,
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
);

final darkTheme = ThemeData(
  colorScheme: darkColorScheme,
  buttonTheme: ButtonThemeData(
    buttonColor: darkColorScheme.primary,
    textTheme: ButtonTextTheme.primary,
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
    fillColor: Colors.grey[800],
  ),
);
