import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable(createFactory: true, createToJson: true)
class Post {
  @JsonKey(name: 'uid')
  final String uid;

  @JsonKey(name: 'postId')
  final String postId;

  @JsonKey(name: 'postUrl')
  final String postUrl;

  @JsonKey(name: 'avatarUrl')
  final String avatarUrl;

  @JsonKey(name: 'username')
  final String username;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'likes')
  final List likes;

  @JsonKey(name: 'datePublished')
  final DateTime datePublished;

  @JsonKey(name: 'comments')
  final List comments;

  const Post({
    required this.uid,
    required this.postId,
    required this.postUrl,
    required this.avatarUrl,
    required this.username,
    required this.description,
    required this.likes,
    required this.datePublished,
    required this.comments,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
