import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/presentation/widgets/like_animation.dart';
import 'package:instagram_clone_flutter/providers/user_provider.dart';
import 'package:instagram_clone_flutter/repository/models/post.dart';
import 'package:instagram_clone_flutter/repository/models/user.dart' as model;
import 'package:instagram_clone_flutter/repository/posts/firebase_post_methods.dart';
import 'package:instagram_clone_flutter/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

const _cardContentOnlyWidthPadding = EdgeInsets.symmetric(horizontal: 16);
final _firebasePostMethods = FirebasePostMethods.instance;

class PostCard extends StatefulWidget {
  const PostCard({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  model.User? user;
  bool _likeAnimation = false;

  Future<void> likePost() async {
    await _firebasePostMethods.updateLikes(
      postId: widget.post.postId,
      userId: user!.uid,
    );
    setState(() => _likeAnimation = !_likeAnimation);
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context).user;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header of the post
        ListTile(
          contentPadding: _cardContentOnlyWidthPadding,
          leading: CircleAvatar(
            backgroundColor: Colors.grey[200],
            foregroundImage: NetworkImage(widget.post.avatarUrl),
          ),
          title: Text(widget.post.username,
              style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(getHumanReadableDate(widget.post.datePublished),
              style: TextStyle(fontWeight: FontWeight.normal)),
          trailing: IconButton(
            icon: Icon(CupertinoIcons.ellipsis_vertical),
            onPressed: () {},
          ),
        ),
        // Photo of the post
        GestureDetector(
          onDoubleTap: () async => await likePost(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                placeholderColor: Colors.grey[200],
                placeholderFit: BoxFit.cover,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 400,
                image: NetworkImage(widget.post.postUrl).url,
              ),
              LikeAnimation(
                isAnimating: _likeAnimation,
                onEnd: () {
                  setState(() => _likeAnimation = !_likeAnimation);
                },
              ),
            ],
          ),
        ),
        // Footer of the post
        Row(
          children: [
            CupertinoButton(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              onPressed: () => likePost(),
              child: widget.post.likes.contains(user!.uid)
                  ? Icon(CupertinoIcons.heart_fill, color: Colors.red[300])
                  : Icon(CupertinoIcons.heart, color: Colors.black),
            ),
            CupertinoButton(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Icon(CupertinoIcons.chat_bubble),
              onPressed: () {},
            ),
            CupertinoButton(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Icon(CupertinoIcons.paperplane),
              onPressed: () {},
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: CupertinoButton(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Icon(CupertinoIcons.bookmark),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: _cardContentOnlyWidthPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${widget.post.likes.length} likes',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
              SizedBox(height: 8),
              RichText(
                maxLines: 3,
                text: TextSpan(
                  style: TextStyle(
                    inherit: false,
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  children: [
                    TextSpan(
                      text: widget.post.username,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: ' '),
                    TextSpan(text: widget.post.description),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Text('View all comments',
                  style: TextStyle(color: Colors.grey, fontSize: 16)),
              SizedBox(height: 8),
              Divider(thickness: 0.5, color: Colors.grey[300]),
            ],
          ),
        ),
      ],
    );
  }
}
