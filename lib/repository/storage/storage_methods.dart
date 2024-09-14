import 'dart:typed_data';

abstract interface class StorageMethods {
  Future<dynamic> uploadFile({
    required String path,
    required Uint8List file,
  });
  Future<dynamic> deleteFile({
    required String path,
  });
}
