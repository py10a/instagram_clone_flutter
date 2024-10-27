import 'package:flutter/material.dart';

abstract class BaseLayoutScreenScaffold extends StatefulWidget {
  final Widget child;

  const BaseLayoutScreenScaffold({
    super.key,
    required this.child,
  });

  @override
  State<BaseLayoutScreenScaffold> createState() =>
      BaseLayoutScreenScaffoldState();
}

class BaseLayoutScreenScaffoldState extends State<BaseLayoutScreenScaffold> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
