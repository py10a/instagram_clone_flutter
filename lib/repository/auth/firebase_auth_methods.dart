import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone_flutter/repository/storage/firebase_storage_methods.dart';

import 'auth_methods.dart';

class FirebaseAuthMethods implements AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        return await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        throw Exception('Please fill in all fields');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  @override
  Future signUpWithEmailAndPassword({
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
        UserCredential credentials = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        Future<String> imageUrl = FirebaseStorageMethods().uploadFile(
          path: 'images/avatars/${credentials.user!.uid}}',
          file: image,
        );
        await _firestore.collection('users').doc(credentials.user!.uid).set({
          'uid': credentials.user!.uid,
          'email': email,
          'username': username,
          'imageUrl': imageUrl,
          'followers': [],
          'following': [],
        });
      } else {
        throw Exception('Please fill in all fields');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
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
