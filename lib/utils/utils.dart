import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

Future<Uint8List> pickImage(ImageSource source) async {
  ImagePicker picker = ImagePicker();
  XFile? file = await picker.pickImage(source: source);

  if (file != null) {
    return await file.readAsBytes();
  } else {
    throw Exception('No image selected');
  }
}
