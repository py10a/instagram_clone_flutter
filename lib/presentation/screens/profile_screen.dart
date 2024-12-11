import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/presentation/widgets/buttons/profile_button.dart';
import 'package:instagram_clone_flutter/repository/auth/firebase_auth_methods.dart';
import 'package:instagram_clone_flutter/repository/models/models.dart'
    as models;

final firebaseAuthMethods = FirebaseAuthMethods.instance;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.uid,
  });

  final String uid;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

//
// TODO: Implement the _ProfileScreenState. Come up with the implementation details.
//
class _ProfileScreenState extends State<ProfileScreen> {
  models.User user = models.User.origin();
  List<models.Post> posts = [];
  List<String> followers = [];
  List<String> following = [];
  bool isFollowing = false;

  @override
  void initState() {
    super.initState();
    _getFollowers();
    _getFollowing();
    _getPosts();
    _isFollowing();
    _getUser();
  }

  void _isFollowing() {
    isFollowing = followers.contains(widget.uid);
  }

  void _getUser() async {
    final userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .get();
    final userData = userSnapshot.data()!;
    user = models.User.fromJson(userData);
  }

  void _getFollowing() async {
    try {
      final followingSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .collection('following')
          .get();
      following = followingSnapshot.docs.isNotEmpty
          ? followingSnapshot.docs.map((e) => e.id).toList()
          : [];
    } catch (e) {
      print(e);
    }
  }

  void _getFollowers() async {
    final followersSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .collection('followers')
        .get();
    followers = followersSnapshot.docs.isNotEmpty
        ? followersSnapshot.docs.map((e) => e.id).toList()
        : [];
  }

  void _getPosts() async {
    final postsSnapshot = await FirebaseFirestore.instance
        .collection('posts')
        .where('uid', isEqualTo: widget.uid)
        .get();
    posts = postsSnapshot.docs.isNotEmpty
        ? postsSnapshot.docs.map((e) => models.Post.fromJson(e.data())).toList()
        : [];
  }

  void _signOut() async {
    await firebaseAuthMethods.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 150,
        centerTitle: false,
        title: Text(
          user.username,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(user.imageUrl),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      _buildProfileStat('Posts', posts.length),
                      _buildProfileStat('Followers', followers.length),
                      _buildProfileStat('Following', following.length),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 16),
            Text(
              user.username,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: ProfileButton(
                    onPressed: () {},
                    child: Text('Edit Profile'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProfileStat(String s, int count) {
    return Column(
      children: [
        Text(
          '$count',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        Text(
          s,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Colors.grey[800]),
        ),
      ],
    );
  }
}
