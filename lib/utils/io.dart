import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
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

void imageToByte(ImageProvider image) async {}
