import 'package:cloud_firestore/cloud_firestore.dart';
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

  factory User.origin() {
    return User(
      uid: '',
      email: '',
      username: '',
      imageUrl: '',
      followers: [],
      following: [],
    );
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  static User fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return User.fromJson(data);
  }

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
