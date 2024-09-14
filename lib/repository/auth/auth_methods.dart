import 'dart:typed_data';

abstract interface class AuthMethods {
  Future<dynamic> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<dynamic> signUpWithEmailAndPassword({
    required String email,
    required String username,
    required String password,
    required Uint8List image,
  });
  Future<dynamic> signOut();
}
