import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/presentation/widgets/post_card.dart';
import 'package:instagram_clone_flutter/providers/user_provider.dart';
import 'package:instagram_clone_flutter/repository/models/post.dart';
import 'package:instagram_clone_flutter/repository/models/user.dart' as model;
import 'package:provider/provider.dart';

final firestore = FirebaseFirestore.instance;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  model.User? user;
  late Stream<QuerySnapshot> _postStream;

  @override
  void initState() {
    super.initState();
    user = Provider.of<UserProvider>(context, listen: false).user;
    _postStream = firestore.collection('posts').snapshots();
  }

  void refreshStream() {
    setState(() {
      _postStream = firestore.collection('posts').snapshots();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 150,
        centerTitle: false,
        title: Text(
          'For you',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          CupertinoButton(
            onPressed: () {},
            child: const Icon(CupertinoIcons.heart),
          ),
          CupertinoButton(
            onPressed: () {},
            child: const Icon(CupertinoIcons.paperplane),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _postStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final postList = snapshot.data!.docs;
          return RefreshIndicator(
            displacement: 0,
            strokeWidth: 2,
            child: ListView.builder(
              itemCount: postList.length,
              itemBuilder: (context, index) {
                final post = Post.fromJson(
                    postList[index].data() as Map<String, dynamic>);
                return PostCard(post: post);
              },
            ),
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 2));
              refreshStream();
            },
          );
        },
      ),
    );
  }
}
