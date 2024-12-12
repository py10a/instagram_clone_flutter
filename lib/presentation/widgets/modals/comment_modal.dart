import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/presentation/widgets/modals/comment_row.dart';
import 'package:instagram_clone_flutter/providers/user_provider.dart';
import 'package:instagram_clone_flutter/repository/models/comment.dart';
import 'package:instagram_clone_flutter/repository/models/user.dart' as models;
import 'package:instagram_clone_flutter/repository/posts/firebase_post_methods.dart';
import 'package:provider/provider.dart';

final _firebasePostMethods = FirebasePostMethods.instance;

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
  final _commentController = TextEditingController();
  bool _isSending = false;
  late final models.User user;

  @override
  void didChangeDependencies() {
    user = Provider.of<UserProvider>(context, listen: false).user!;
    super.didChangeDependencies();
  }

  void sendComment() async {
    setState(() => _isSending = true);
    await _firebasePostMethods.createComment(
      postId: widget.postId,
      username: user.username,
      avatarUrl: user.imageUrl,
      content: _commentController.text,
    );
    _commentController.clear();
    setState(() => _isSending = false);
  }

  @override
  Widget build(BuildContext context) {
    final divider = Divider(
      color: Colors.grey[400],
      height: 0,
      thickness: 0.5,
    );
    var listView = StreamBuilder(
        stream: _firebasePostMethods.getCommentsStream(widget.postId),
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
                CircleAvatar(
                  radius: 20,
                  foregroundImage: NetworkImage(user.imageUrl),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Add a comment as ${user.username}...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                CupertinoButton(
                  onPressed: sendComment,
                  child: _isSending
                      ? CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(Colors.black),
                        )
                      : Icon(CupertinoIcons.paperplane),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
