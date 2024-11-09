import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// Pick an image from the gallery or camera
/// and return it as a [Uint8List]
///
Future<Uint8List> pickImage(ImageSource source) async {
  ImagePicker picker = ImagePicker();
  XFile? file = await picker.pickImage(source: source);

  if (file != null) {
    return await file.readAsBytes();
  } else {
    throw Exception('No image selected');
  }
}

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

/// Get date in a human-readable format from the given [date]
///
///   - if today, then '2 hours ago'
///   - if this week, then '2 days ago'
///   - else 'May 1, 2021'
///
String getHumanReadableDate(DateTime date) {
  final DateTime now = DateTime.now();
  final Duration diff = now.difference(date);

  switch (diff.inDays) {
    case 0:
      return diff.inHours == 0
          ? diff.inMinutes == 0
              ? 'Just now'
              : '${diff.inMinutes} minutes ago'
          : '${diff.inHours} hours ago';
    default:
      return diff.inDays < 7
          ? '${diff.inDays} days ago'
          : '${date.month}/${date.day}/${date.year}';
  }
}
