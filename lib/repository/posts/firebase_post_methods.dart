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
    required String id,
    required String avatarUrl,
    required String username,
    required String description,
    required Uint8List postImage,
  }) async {
    try {
      final postId = const Uuid().v1();
      final postImageUrl = await _storageMethods.uploadFile(
          path: 'posts/${_auth.currentUser!.uid}/$postId', file: postImage);
      Post post = Post(
        uid: id,
        postId: postId,
        postUrl: postImageUrl,
        avatarUrl: avatarUrl,
        username: username,
        description: description,
        likes: [],
        datePublished: DateTime.now(),
      );
      await _firestore.collection('posts').doc(postId).set(post.toJson());
      return 'posts/$postId';
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future deletePost({
    required String id,
  }) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future updatePost({
    required String id,
    String? title,
    String? content,
    String? image,
  }) {
    throw UnimplementedError();
  }

  Future updateLikes({
    required String postId,
    required String userId,
  }) async {
    final postRef = _firestore.collection('posts').doc(postId);
    final postJson = await postRef.get() as Map<String, dynamic>;
    final post = Post.fromJson(postJson);
    final likes = post.likes;
    if (likes.contains(userId)) {
      likes.remove(userId);
    } else {
      likes.add(userId);
    }
    await postRef.update({'likes': likes});
  }
}
