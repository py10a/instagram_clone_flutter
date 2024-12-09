import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

final randomizer = Random();

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 150,
        centerTitle: false,
        title: Text(
          'Reels',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: FirebaseFirestore.instance.collection('posts').get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final postList = snapshot.data!.docs;
            return StaggeredGrid.count(
              crossAxisCount: 3,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
              children: List.generate(
                postList.length,
                (index) {
                  final post = postList[index];
                  return StaggeredGridTile.count(
                    crossAxisCellCount: (index % 7 == 0) ? 2 : 1,
                    mainAxisCellCount: (index % 7 == 0) ? 2 : 1,
                    child: Image.network(
                      post['postUrl'],
                      fit: BoxFit.cover,
                    ),
                  );
                  return Image.network(
                    post['postUrl'],
                    fit: BoxFit.cover,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
