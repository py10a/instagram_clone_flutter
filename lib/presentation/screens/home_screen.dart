import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/presentation/widgets/widgets.dart';
import 'package:instagram_clone_flutter/providers/post_provider.dart';
import 'package:instagram_clone_flutter/providers/user_provider.dart';
import 'package:instagram_clone_flutter/repository/models/models.dart'
    as models;
import 'package:provider/provider.dart';

final firestore = FirebaseFirestore.instance;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 2));
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
      body: RefreshIndicator(
        displacement: 0,
        strokeWidth: 2,
        onRefresh: _onRefresh,
        child: StreamBuilder(
          stream: Provider.of<PostProvider>(context).postsStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }
            final postList = snapshot.data!.docs;
            return ListView.builder(
              itemCount: postList.length,
              itemBuilder: (context, index) {
                final post = models.Post.fromJson(
                  postList[index].data() as Map<String, dynamic>,
                );
                return PostCard(
                  post: post,
                  currentUser: Provider.of<UserProvider>(context).user!,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
