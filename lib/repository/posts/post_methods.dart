import 'dart:typed_data';

abstract interface class PostMethods {
  Future<dynamic> createPost({
    required String uid,
    required String avatarUrl,
    required String username,
    required String description,
    required Uint8List postImage,
  });
  Future<dynamic> updatePost({
    required String id,
    required String title,
    required String content,
    required String image,
  });
  Future<dynamic> deletePost({
    required String id,
  });
}
