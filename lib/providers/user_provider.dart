import 'package:flutter/foundation.dart';
import 'package:instagram_clone_flutter/repository/auth/firebase_auth_methods.dart';
import 'package:instagram_clone_flutter/repository/models/user.dart';

final _firebaseAuthMethods = FirebaseAuthMethods.instance;

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<String> signUpWithEmailAndPassword({
    required String username,
    required String email,
    required String password,
    required Uint8List? avatarImage,
  }) async {
    String res = await _firebaseAuthMethods.signUpWithEmailAndPassword(
      username: username,
      email: email,
      password: password,
      image: avatarImage ?? Uint8List(0),
    );
    refreshUser();
    return res;
  }

  Future<String> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    String res = await _firebaseAuthMethods.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    refreshUser();
    return res;
  }

  Future<void> refreshUser() async {
    _user = await _firebaseAuthMethods.userData;
    notifyListeners();
  }

  void signOut() async {
    await _firebaseAuthMethods.signOut();
    _user = null;
    notifyListeners();
  }
}
