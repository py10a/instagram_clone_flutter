// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      uid: json['uid'] as String,
      postId: json['postId'] as String,
      postUrl: json['postUrl'] as String,
      avatarUrl: json['avatarUrl'] as String,
      username: json['username'] as String,
      description: json['description'] as String,
      likes: json['likes'] as List<dynamic>,
      datePublished: DateTime.parse(json['datePublished'] as String),
      comments: json['comments'] as List<dynamic>,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'uid': instance.uid,
      'postId': instance.postId,
      'postUrl': instance.postUrl,
      'avatarUrl': instance.avatarUrl,
      'username': instance.username,
      'description': instance.description,
      'likes': instance.likes,
      'datePublished': instance.datePublished.toIso8601String(),
      'comments': instance.comments,
    };
