import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/presentation/widgets/widgets.dart';
import 'package:instagram_clone_flutter/repository/models/models.dart'
    as models;
import 'package:instagram_clone_flutter/repository/posts/firebase_post_methods.dart';
import 'package:instagram_clone_flutter/utils/modals.dart';
import 'package:instagram_clone_flutter/utils/utils.dart';
import 'package:transparent_image/transparent_image.dart';

const _cardContentOnlyWidthPadding = EdgeInsets.symmetric(horizontal: 16);
final _firebasePostMethods = FirebasePostMethods.instance;

class PostCard extends StatefulWidget {
  const PostCard({
    super.key,
    required this.post,
    required this.currentUser,
  });

  final models.Post post;
  final models.User currentUser;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool _likeAnimation = false;

  Future<void> _likePost() async {
    await _firebasePostMethods.updateLikes(
      postId: widget.post.postId,
      userId: widget.currentUser.uid,
    );
    setState(() => _likeAnimation = !_likeAnimation);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PostHeader(post: widget.post, currentUser: widget.currentUser),
        _PostPhoto(
          post: widget.post,
          likePost: _likePost,
          likeAnimation: _likeAnimation,
          onAnimationEnd: () {
            setState(() => _likeAnimation = !_likeAnimation);
          },
        ),
        _PostActions(
          post: widget.post,
          user: widget.currentUser,
          likePost: _likePost,
        ),
        Padding(
          padding: _cardContentOnlyWidthPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.post.likes.length} likes',
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              const SizedBox(height: 8),
              _PostDescription(post: widget.post),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => showCommentsModal(context, widget.post.postId),
                child: const Text(
                  'View all comments',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              Divider(thickness: 0.5, color: Colors.grey[300]),
            ],
          ),
        ),
      ],
    );
  }
}

class _PostHeader extends StatelessWidget {
  const _PostHeader({
    required this.post,
    required this.currentUser,
  });

  final models.Post post;
  final models.User currentUser;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: _cardContentOnlyWidthPadding,
      leading: CircleAvatar(
        backgroundColor: Colors.grey[200],
        foregroundImage: NetworkImage(post.avatarUrl),
      ),
      title: Text(
        post.username,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        getHumanReadableDate(post.datePublished),
        style: const TextStyle(fontWeight: FontWeight.normal),
      ),
      trailing: PopupMenuButton(
        icon: const Icon(CupertinoIcons.ellipsis_vertical),
        itemBuilder: (context) {
          return [
            currentUser.username == post.username
                ? PopupMenuItem(
                    value: 'delete',
                    child: const Text('Delete this post'),
                    onTap: () async {
                      showGeneralDialog(
                          context: context,
                          pageBuilder: (context, _, __) {
                            return AlertDialog(
                              title: const Text('Delete Post'),
                              content: const Text(
                                  'Are you sure you want to delete this post?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    await _firebasePostMethods.deletePost(
                                        id: post.postId);
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            );
                          });
                    },
                  )
                : PopupMenuItem(
                    value: 'report',
                    child: const Text('Report this post'),
                    onTap: () {},
                  ),
          ];
        },
      ),
    );
  }
}

class _PostPhoto extends StatelessWidget {
  const _PostPhoto({
    required this.post,
    required this.likePost,
    required this.likeAnimation,
    required this.onAnimationEnd,
  });

  final models.Post post;
  final Future<void> Function() likePost;
  final bool likeAnimation;
  final VoidCallback onAnimationEnd;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () async => await likePost(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Hero(
            tag: post.postUrl,
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              placeholderColor: Colors.grey[200],
              placeholderFit: BoxFit.cover,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 400,
              image: post.postUrl,
            ),
          ),
          LikeAnimation(
            isAnimating: likeAnimation,
            onEnd: onAnimationEnd,
          ),
        ],
      ),
    );
  }
}

class _PostActions extends StatelessWidget {
  const _PostActions({
    required this.post,
    required this.user,
    required this.likePost,
  });

  final models.Post post;
  final models.User user;
  final Future<void> Function() likePost;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CupertinoButton(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          onPressed: likePost,
          child: post.likes.contains(user.uid)
              ? Icon(CupertinoIcons.heart_fill, color: Colors.red[300])
              : const Icon(CupertinoIcons.heart, color: Colors.black),
        ),
        CupertinoButton(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          onPressed: () => showCommentsModal(context, post.postId),
          child: const Icon(CupertinoIcons.chat_bubble),
        ),
        CupertinoButton(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: const Icon(CupertinoIcons.paperplane),
          onPressed: () {},
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomRight,
            child: CupertinoButton(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: const Icon(CupertinoIcons.bookmark),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }
}

class _PostDescription extends StatelessWidget {
  const _PostDescription({required this.post});

  final models.Post post;

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 3,
      text: TextSpan(
        style: TextStyle(
          inherit: false,
          fontWeight: FontWeight.normal,
          color: Theme.of(context).colorScheme.primary,
        ),
        children: [
          TextSpan(
            text: post.username,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const TextSpan(text: ' '),
          TextSpan(text: post.description),
        ],
      ),
    );
  }
}
