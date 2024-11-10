import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone_flutter/repository/auth/auth_methods.dart';
import 'package:instagram_clone_flutter/repository/models/models.dart'
    as models;
import 'package:instagram_clone_flutter/repository/storage/firebase_storage_methods.dart';

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;
final _storageMethods = FirebaseStorageMethods.instance;

/// A class that implements [AuthMethods] using Firebase Authentication.
///
/// This class is a singleton, so it should be accessed using the following:
/// - [FirebaseAuthMethods()] constructor (a factory).
/// - [FirebaseAuthMethods.instance] getter.
///
class FirebaseAuthMethods implements AuthMethods {
  FirebaseAuthMethods._();
  static final instance = FirebaseAuthMethods._();
  factory FirebaseAuthMethods() => instance;

  Future<models.User?> get userData async {
    final snapshot =
        await _firestore.collection('users').doc(_auth.currentUser?.uid).get();
    if (snapshot.exists) {
      return models.User.fromSnapshot(snapshot);
    } else {
      signOut();
      return null;
    }
  }

  @override
  Future<String> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      bool validated = email.isNotEmpty && password.isNotEmpty;
      if (validated) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        return 'success';
      } else {
        return 'Please fill in all fields';
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-credential':
          return 'Invalid login or password';
        case 'wrong-password':
          return 'Wrong password';
      }
    }
    return 'none';
  }

  @override
  Future<String> signUpWithEmailAndPassword({
    required String email,
    required String username,
    required String password,
    required Uint8List image,
  }) async {
    try {
      bool validated = email.isNotEmpty &&
          username.isNotEmpty &&
          password.isNotEmpty &&
          image.isNotEmpty;
      if (validated) {
        final credentials = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        final imageUrl = await _storageMethods.uploadFile(
          path: 'images/avatars/${credentials.user!.uid}',
          file: image,
        );
        final user = models.User(
          uid: _auth.currentUser!.uid,
          email: email,
          username: username,
          imageUrl: imageUrl,
          followers: const [],
          following: const [],
        );
        await _firestore
            .collection('users')
            .doc(credentials.user!.uid)
            .set(user.toJson());
        await _auth.currentUser!.updateDisplayName(username);
        await _auth.currentUser!.updatePhotoURL(imageUrl);
        await _auth.currentUser!.reload();
        return 'success';
      } else {
        return ('Please fill in all fields');
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return 'Email already in use';
        case 'weak-password':
          return 'Password is too weak';
      }
    }
    return 'none';
  }

  @override
  Future<dynamic> signOut() async {
    try {
      return _auth.signOut();
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
