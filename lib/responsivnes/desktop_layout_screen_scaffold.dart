import 'package:instagram_clone_flutter/responsivnes/base_layout_screen_scaffold.dart';

class DesktopLayoutScreenScaffold extends BaseLayoutScreenScaffold {
  const DesktopLayoutScreenScaffold({
    super.key,
    required super.child,
  });

  @override
  _DesktopLayoutScreenScaffoldState createState() =>
      _DesktopLayoutScreenScaffoldState();
}

class _DesktopLayoutScreenScaffoldState extends BaseLayoutScreenScaffoldState {}
