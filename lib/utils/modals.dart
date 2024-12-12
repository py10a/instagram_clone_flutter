import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/presentation/widgets/modals/comment_modal.dart';
import 'package:instagram_clone_flutter/presentation/widgets/modals/profile_modal.dart';

void _showModal(
  BuildContext context,
  Widget Function(BuildContext context, ScrollController controller) builder,
) {
  showModalBottomSheet(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) {
      return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          minChildSize: 0.6,
          maxChildSize: 0.9,
          snap: true,
          builder: builder);
    },
  );
}

void showCommentsModal(BuildContext context, String postId) {
  _showModal(context, (context, scrollController) {
    return CommentsModal(
      scrollController: scrollController,
      postId: postId,
    );
  });
}

void showProfileModal(BuildContext context, {required VoidCallback onLogOut}) {
  _showModal(context, (context, scrollController) {
    return ProfileModal(
      scrollController: scrollController,
      onLogOut: onLogOut,
    );
  });
}
