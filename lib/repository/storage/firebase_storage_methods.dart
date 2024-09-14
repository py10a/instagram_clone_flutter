import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_clone_flutter/repository/storage/storage_methods.dart';

class FirebaseStorageMethods implements StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Future<String> uploadFile({
    required String path,
    required Uint8List file,
  }) async {
    Reference ref = _storage.ref(path);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    return taskSnapshot.ref.getDownloadURL();
  }

  @override
  Future deleteFile({
    required String path,
  }) async {
    // TODO: implement deleteFile
    throw UnimplementedError();
  }
}
