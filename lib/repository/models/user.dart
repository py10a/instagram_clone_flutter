import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: 'uid')
  final String uid;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'username')
  final String username;

  @JsonKey(name: 'imageUrl')
  final String imageUrl;

  @JsonKey(name: 'followers')
  final List followers;

  @JsonKey(name: 'following')
  final List following;

  const User({
    required this.uid,
    required this.email,
    required this.username,
    required this.imageUrl,
    required this.followers,
    required this.following,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
