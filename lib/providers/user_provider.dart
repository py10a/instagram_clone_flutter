import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/repository/auth/firebase_auth_methods.dart';
import 'package:instagram_clone_flutter/repository/models/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final FirebaseAuthMethods _firebaseAuthMethods = FirebaseAuthMethods();

  User? get user => _user;

  Future<void> refreshUser() async {
    _user = await _firebaseAuthMethods.userData;
    notifyListeners();
  }
}
