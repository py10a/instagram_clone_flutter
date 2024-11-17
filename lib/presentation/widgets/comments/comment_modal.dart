import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/presentation/widgets/comments/comment_row.dart';
import 'package:instagram_clone_flutter/repository/models/comment.dart';
import 'package:instagram_clone_flutter/repository/posts/firebase_post_methods.dart';

class CommentsModal extends StatefulWidget {
  const CommentsModal({
    super.key,
    required this.scrollController,
    required this.postId,
  });

  final ScrollController scrollController;
  final String postId;

  @override
  State<CommentsModal> createState() => _CommentsModalState();
}

class _CommentsModalState extends State<CommentsModal> {
  @override
  Widget build(BuildContext context) {
    final divider = Divider(
      color: Colors.grey[400],
      height: 0,
      thickness: 0.5,
    );
    var listView = StreamBuilder(
        stream: FirebasePostMethods.instance.getCommentsStream(widget.postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          final commentsList = snapshot.data!.docs;
          if (commentsList.isEmpty) {
            return const Center(child: Text('No comments yet.'));
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: commentsList.length,
            itemBuilder: (context, index) {
              final commentParsed =
                  commentsList[index].data() as Map<String, dynamic>;
              final commentModel = Comment.fromJson(commentParsed);
              return CommentRow(commentModel: commentModel);
            },
          );
        });
    return Column(
      children: [
        Text('Comments', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        divider,
        Expanded(
          child: SingleChildScrollView(
            controller: widget.scrollController,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: listView,
            ),
          ),
        ),
        divider,
        const SizedBox(height: 8),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                CircleAvatar(radius: 20),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                CupertinoButton(
                  onPressed: () {},
                  child: Icon(CupertinoIcons.paperplane),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
