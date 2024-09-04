import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/responsivnes/desktop_layout_screen_scaffold.dart';
import 'package:instagram_clone_flutter/responsivnes/mobile_layout_screen_scaffold.dart';
import 'package:instagram_clone_flutter/responsivnes/web_layout_screen_scaffold.dart';

import '../utils/dimensions.dart';

class ResponsiveLayoutScreen extends StatelessWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  const ResponsiveLayoutScreen({
    super.key,
  })  : webScreenLayout = const WebLayoutScreenScaffold(),
        mobileScreenLayout = const MobileLayoutScreenScaffold();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < mobileScreenWidth) {
        return const MobileLayoutScreenScaffold();
      } else if (constraints.maxWidth < webScreenWidth) {
        return const WebLayoutScreenScaffold();
      } else {
        return const DesktopLayoutScreenScaffold();
      }
    });
  }
}
