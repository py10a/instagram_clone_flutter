import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Widget text;
  final void Function() onPressed;
  final bool isAsync;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isAsync = false,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      onPressed: onPressed,
      child: isAsync
          ? CircularProgressIndicator(
              strokeWidth: 2,
              color: Theme.of(context).colorScheme.onPrimary,
            )
          : text,
    );
  }
}
