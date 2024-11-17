import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/presentation/widgets/comments/comment_modal.dart';

void showDraggableModalBottomSheet(BuildContext context, [Object? arguments]) {
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
        builder: (context, scrollController) {
          return CommentsModal(scrollController: scrollController);
        },
      );
    },
  );
}
