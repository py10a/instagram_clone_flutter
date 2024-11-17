import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable(createFactory: true, createToJson: true)
class Comment {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'postId')
  final String postId;

  @JsonKey(name: 'avatarUrl')
  final String avatarUrl;

  @JsonKey(name: 'username')
  final String username;

  @JsonKey(name: 'content')
  final String content;

  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;

  const Comment({
    required this.id,
    required this.postId,
    required this.avatarUrl,
    required this.username,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
