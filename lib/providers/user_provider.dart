import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/repository/auth/firebase_auth_methods.dart';
import 'package:instagram_clone_flutter/repository/models/user.dart';

final _firebaseAuthMethods = FirebaseAuthMethods.instance;

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<void> refreshUser() async {
    _user = await _firebaseAuthMethods.userData;
    notifyListeners();
  }
}
