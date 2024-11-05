import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/utils/utils.dart';
import 'package:transparent_image/transparent_image.dart';

const cardContentOnlyWidthPadding = EdgeInsets.symmetric(horizontal: 16);

class PostCard extends StatelessWidget {
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
  final String postDate;
  final String postContent;
  final String postImageUrl;
  final int likes;

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
            foregroundImage: NetworkImage(userImageUrl),
          ),
          title: Text(username, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(getHumanReadableDate(postDate),
              style: TextStyle(fontWeight: FontWeight.normal)),
          trailing: IconButton(
            icon: Icon(CupertinoIcons.ellipsis_vertical),
            onPressed: () {},
          ),
        ),
        // Photo of the post
        FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          placeholderColor: Colors.grey[200],
          placeholderFit: BoxFit.cover,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 400,
          image: NetworkImage(postImageUrl).url,
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
              Text('$likes likes',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
              SizedBox(height: 8),
              RichText(
                maxLines: 3,
                text: TextSpan(
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  children: [
                    TextSpan(
                      text: username,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: ' '),
                    TextSpan(text: postContent),
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
