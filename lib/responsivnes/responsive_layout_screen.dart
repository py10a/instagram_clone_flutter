import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/responsivnes/desktop_layout_screen_scaffold.dart';
import 'package:instagram_clone_flutter/responsivnes/mobile_layout_screen_scaffold.dart';
import 'package:instagram_clone_flutter/responsivnes/web_layout_screen_scaffold.dart';

import '../utils/dimensions.dart';

class ResponsiveLayoutScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < mobileScreenWidth) {
        return mobileScreenLayout;
      } else if (constraints.maxWidth < webScreenWidth) {
        return webScreenLayout;
      } else {
        return desktopScreenLayout;
      }
    });
  }
}
