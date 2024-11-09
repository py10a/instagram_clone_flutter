import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/presentation/widgets/like_animation.dart';
import 'package:instagram_clone_flutter/utils/utils.dart';
import 'package:transparent_image/transparent_image.dart';

const cardContentOnlyWidthPadding = EdgeInsets.symmetric(horizontal: 16);

///
/// A widget that displays a post card in the feed.
///
/// It displays the user's profile picture, username, post date, post content,
/// post image, and the number of likes.
/// It also allows the user to like, comment, and share the post.
///
class PostCard extends StatefulWidget {
  const PostCard({
    super.key,
    required this.username,
    required this.userImageUrl,
    required this.postDate,
    required this.postContent,
    required this.postImageUrl,
    required this.likes,
  });

  final String username;
  final String userImageUrl;
  final DateTime postDate;
  final String postContent;
  final String postImageUrl;
  final int likes;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header of the post
        ListTile(
          contentPadding: cardContentOnlyWidthPadding,
          leading: CircleAvatar(
            backgroundColor: Colors.grey[200],
            foregroundImage: NetworkImage(widget.userImageUrl),
          ),
          title: Text(widget.username,
              style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(getHumanReadableDate(widget.postDate),
              style: TextStyle(fontWeight: FontWeight.normal)),
          trailing: IconButton(
            icon: Icon(CupertinoIcons.ellipsis_vertical),
            onPressed: () {},
          ),
        ),
        // Photo of the post
        GestureDetector(
          onDoubleTap: () => setState(() => isLiked = true),
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
                image: NetworkImage(widget.postImageUrl).url,
              ),
              LikeAnimation(
                  isAnimating: isLiked,
                  onEnd: () => setState(() => isLiked = false)),
            ],
          ),
        ),
        // Footer of the post
        Row(
          children: [
            CupertinoButton(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Icon(CupertinoIcons.heart),
              onPressed: () {},
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
          padding: cardContentOnlyWidthPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${widget.likes} likes',
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
                      text: widget.username,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: ' '),
                    TextSpan(text: widget.postContent),
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
