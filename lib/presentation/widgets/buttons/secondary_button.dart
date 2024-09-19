import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final Widget text;
  final void Function() onPressed;
  final bool isAsync;

  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isAsync = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: FilledButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
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
