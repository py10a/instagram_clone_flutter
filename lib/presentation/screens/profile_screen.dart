import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/presentation/widgets/buttons/profile_button.dart';
import 'package:instagram_clone_flutter/repository/auth/firebase_auth_methods.dart';
import 'package:instagram_clone_flutter/repository/models/models.dart'
    as models;
import 'package:instagram_clone_flutter/utils/modals.dart';

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

class _ProfileScreenState extends State<ProfileScreen> {
  models.User user = models.User.origin();
  List<models.Post> posts = [];
  List<dynamic> followers = [];
  List<dynamic> following = [];
  bool isFollowing = false;
  bool isCurrentUser = false;

  void _isFollowing() {
    isFollowing = followers.contains(widget.uid);
  }

  void _isCurrentUser() {
    isCurrentUser = FirebaseAuth.instance.currentUser!.uid == widget.uid;
  }

  Future<void> _getUser() async {
    try {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      final userData = userSnapshot.data()!;
      user = models.User.fromJson(userData);
      await _getPosts();
      _isCurrentUser();
      _getFollowers();
      _getFollowing();
      _isFollowing();
    } catch (e) {
      print(e);
    }
  }

  void _getFollowing() {
    following = user.following;
  }

  void _getFollowers() {
    followers = user.followers;
  }

  Future<void> _getPosts() async {
    try {
      final postsSnapshot = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: widget.uid)
          .get();
      posts = postsSnapshot.docs.isNotEmpty
          ? postsSnapshot.docs
              .map((e) => models.Post.fromJson(e.data()))
              .toList()
          : [];
    } catch (e) {
      print(e);
    }
  }

  void _signOut() async {
    await firebaseAuthMethods.signOut();
  }

  // Whether to show the follow button or the message button
  void tapProfileButton() {
    // TODO: Implement tapEditProfile
  }

  void tapSettings() {
    showProfileModal(context, onLogOut: _signOut);
  }

  Widget _buildProfile() {
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
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: tapSettings,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Hero(
                    tag: user.uid,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(user.imageUrl),
                    ),
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
                    child: isCurrentUser
                        ? ProfileEditButton(
                            onPressed: tapProfileButton,
                            child: const Text('Edit Profile'),
                          )
                        : ProfileFollowButton(
                            isFollowing: isFollowing,
                            onPressed: tapProfileButton,
                          ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              posts.isEmpty
                  ? const Center(child: Text('No posts yet'))
                  : GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: posts.length,
                      itemBuilder: (BuildContext context, int index) {
                        final post = posts[index];
                        return GridTile(
                          child: Image.network(
                            post.postUrl,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUser(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return _buildProfile();
      },
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
