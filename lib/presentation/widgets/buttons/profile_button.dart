import 'package:flutter/material.dart';

class ProfileEditButton extends StatelessWidget {
  const ProfileEditButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: child,
    );
  }
}

class ProfileFollowButton extends StatelessWidget {
  const ProfileFollowButton({
    super.key,
    required this.onPressed,
    this.isFollowing = false,
  });

  final VoidCallback onPressed;
  final bool isFollowing;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        foregroundColor: isFollowing
            ? Theme.of(context).colorScheme.onSecondary
            : Theme.of(context).colorScheme.onPrimaryContainer,
        backgroundColor: isFollowing
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: isFollowing ? const Text('Following') : const Text('Follow'),
    );
  }
}
