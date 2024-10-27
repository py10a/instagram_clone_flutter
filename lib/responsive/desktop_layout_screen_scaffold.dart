import 'package:instagram_clone_flutter/responsive/base_layout_screen_scaffold.dart';

class DesktopLayoutScreenScaffold extends BaseLayoutScreenScaffold {
  const DesktopLayoutScreenScaffold({
    super.key,
    required super.child,
  });

  @override
  BaseLayoutScreenScaffoldState createState() =>
      _DesktopLayoutScreenScaffoldState();
}

class _DesktopLayoutScreenScaffoldState extends BaseLayoutScreenScaffoldState {}
