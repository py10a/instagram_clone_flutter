import 'package:flutter/material.dart';

/// Show a [SnackBar] with the given [text]
/// and optional [isError] flag
///
void showSnackBar(
  String text, {
  required BuildContext context,
  bool isError = false,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
      content: Text(text),
      backgroundColor: isError ? Colors.red : Colors.green,
    ),
  );
}
