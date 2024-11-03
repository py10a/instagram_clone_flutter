import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_clone_flutter/repository/storage/storage_methods.dart';

final _storage = FirebaseStorage.instance;

/// A class that implements [StorageMethods] using Firebase Authentication.
///
/// This class is a singleton, so it should be accessed using the following:
/// - [FirebaseStorageMethods()] constructor (a factory).
/// - [FirebaseStorageMethods.instance] getter.
///
class FirebaseStorageMethods implements StorageMethods {
  FirebaseStorageMethods._();
  static final instance = FirebaseStorageMethods._();
  factory FirebaseStorageMethods() => instance;

  @override
  Future<String> uploadFile({
    required String path,
    required Uint8List file,
  }) async {
    Reference ref = _storage.ref().child(path);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

  @override
  Future deleteFile({
    required String path,
  }) async {
    // TODO: implement deleteFile
    throw UnimplementedError();
  }
}
