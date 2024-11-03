import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/providers/user_provider.dart';
import 'package:instagram_clone_flutter/responsive/desktop_layout_screen_scaffold.dart';
import 'package:instagram_clone_flutter/responsive/mobile_layout_screen_scaffold.dart';
import 'package:instagram_clone_flutter/responsive/web_layout_screen_scaffold.dart';
import 'package:instagram_clone_flutter/utils/dimensions.dart';
import 'package:provider/provider.dart';

class ResponsiveLayoutScreen extends StatefulWidget {
  final WebLayoutScreenScaffold webScreenLayout;
  final MobileLayoutScreenScaffold mobileScreenLayout;
  final DesktopLayoutScreenScaffold desktopScreenLayout;
  final Widget child;

  ResponsiveLayoutScreen({
    super.key,
    required this.child,
  })  : webScreenLayout = WebLayoutScreenScaffold(child: child),
        mobileScreenLayout = MobileLayoutScreenScaffold(child: child),
        desktopScreenLayout = DesktopLayoutScreenScaffold(child: child);

  @override
  State<ResponsiveLayoutScreen> createState() => _ResponsiveLayoutScreenState();
}

class _ResponsiveLayoutScreenState extends State<ResponsiveLayoutScreen> {
  @override
  void initState() {
    super.initState();
    refreshUser();
  }

  void refreshUser() {
    Provider.of<UserProvider>(context, listen: false).refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < mobileScreenWidth) {
        return widget.mobileScreenLayout;
      } else if (constraints.maxWidth < webScreenWidth) {
        return widget.webScreenLayout;
      } else {
        return widget.desktopScreenLayout;
      }
    });
  }
}
