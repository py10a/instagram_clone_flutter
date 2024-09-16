// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      uid: json['uid'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      imageUrl: json['imageUrl'] as String,
      followers: json['followers'] as List<dynamic>,
      following: json['following'] as List<dynamic>,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'username': instance.username,
      'imageUrl': instance.imageUrl,
      'followers': instance.followers,
      'following': instance.following,
    };
