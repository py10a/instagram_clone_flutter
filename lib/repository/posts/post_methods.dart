import 'dart:async';
import 'dart:typed_data';

abstract interface class PostMethods {
  Future<dynamic> createPost({
    required String id,
    required String avatarUrl,
    required String username,
    required String description,
    required Uint8List postImage,
  });
  Future<dynamic> getPostById(String postId);
  Future<dynamic> updatePost({
    required String id,
    String? title,
    String? content,
    String? image,
  });
  Future<dynamic> deletePost({
    required String id,
  });
}

abstract interface class ICommentable {
  Future<dynamic> createComment({
    required String postId,
    required String username,
    required String avatarUrl,
    required String content,
  });
  Future<dynamic> deleteComment({
    required String postId,
    required String commentId,
  });
}

abstract interface class ILikeable {
  Future<void> updateLikes({
    required String postId,
    required String userId,
  });
}
