import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone_flutter/repository/models/post.dart';
import 'package:instagram_clone_flutter/repository/posts/post_methods.dart';
import 'package:instagram_clone_flutter/repository/storage/firebase_storage_methods.dart';
import 'package:uuid/uuid.dart';

final _storageMethods = FirebaseStorageMethods.instance;
final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

/// Firebase implementation of [PostMethods]
///
/// This class is a singleton, so it should be accessed using the following:
/// - [FirebasePostMethods()] constructor (a factory).
/// - [FirebasePostMethods.instance] getter.
///
class FirebasePostMethods implements PostMethods {
  FirebasePostMethods._();
  static final instance = FirebasePostMethods._();
  factory FirebasePostMethods() => instance;

  @override
  Future<String> createPost({
    required String uid,
    required String avatarUrl,
    required String username,
    required String description,
    required Uint8List postImage,
  }) async {
    try {
      final postUrl = await _storageMethods.uploadFile(
          path: 'posts/${_auth.currentUser!.uid}', file: postImage);

      final postId = const Uuid().v1();
      print(postId);

      Post post = Post(
        uid: uid,
        postId: postId,
        postUrl: postUrl,
        avatarUrl: avatarUrl,
        username: username,
        description: description,
        likes: [],
        datePublished: DateTime.now(),
      );

      // TODO: Implement this method
      // await _firestore
      //     .collection('posts/${_auth.currentUser!.uid}')
      //     .doc(postId)
      //     .set(post.toJson());

      await _firestore
          .collection('posts/${_auth.currentUser!.uid}/$postId')
          .add(post.toJson());

      return 'posts/${_auth.currentUser!.uid}/$postId';
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future deletePost({required String id}) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future updatePost(
      {required String id,
      required String title,
      required String content,
      required String image}) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}
