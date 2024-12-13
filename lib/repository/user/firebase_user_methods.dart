import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

class FirebaseUserMethods {
  FirebaseUserMethods._();
  static final instance = FirebaseUserMethods._();
  factory FirebaseUserMethods() => instance;

  Future<void> unfollowUser({
    required String currentUserId,
    required String userId,
  }) async {
    try {
      await _firestore.collection('users').doc(currentUserId).update({
        'following': FieldValue.arrayRemove([userId]),
      });
      await _firestore.collection('users').doc(userId).update({
        'followers': FieldValue.arrayRemove([userId])
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> followUser({
    required String currentUserId,
    required String userId,
  }) async {
    try {
      await _firestore.collection('users').doc(currentUserId).update({
        'following': FieldValue.arrayUnion([userId]),
      });
      await _firestore.collection('users').doc(userId).update({
        'followers': FieldValue.arrayUnion([userId])
      });
    } catch (e) {
      print(e);
    }
  }
}
