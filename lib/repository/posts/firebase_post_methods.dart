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

class FirebasePostMethods implements PostMethods {
  FirebasePostMethods._();
  static final instance = FirebasePostMethods._();
  factory FirebasePostMethods() => instance;

  DocumentReference<Map<String, dynamic>> getPostRefById(String postId) {
    return _firestore.collection('posts').doc(postId);
  }

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
      final post = Post(
        uid: id,
        postId: postId,
        postUrl: postImageUrl,
        avatarUrl: avatarUrl,
        username: username,
        description: description,
        likes: [],
        datePublished: DateTime.now(),
      );
      await getPostRefById(postId).set(post.toJson());
      return 'posts/$postId';
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<void> deletePost({required String id}) async {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<void> updatePost({
    required String id,
    String? title,
    String? content,
    String? image,
  }) async {
    // TODO: implement updatePost
    throw UnimplementedError();
  }

  Future<bool> isLikedByUser({
    required String postId,
    required String userId,
  }) async {
    final post = await getPostById(postId);
    return post.likes.contains(userId);
  }

  Future<void> updateLikes({
    required String postId,
    required String userId,
  }) async {
    final post = await getPostById(postId);
    final likes = post.likes;
    if (likes.contains(userId)) {
      likes.remove(userId);
    } else {
      likes.add(userId);
    }
    await getPostRefById(postId).update({'likes': likes});
  }

  Future<List<Post>> get posts async {
    final postsJson = await _firestore.collection('posts').get();
    return postsJson.docs
        .map((post) => Post.fromJson(post.data()))
        .toList(growable: false);
  }

  Stream<QuerySnapshot> get postsStream async* {
    yield* _firestore.collection('posts').snapshots();
  }

  Future<Post> getPostById(String postId) async {
    final postJson = await getPostRefById(postId).get();
    return Post.fromJson(postJson.data() ?? {});
  }
}
