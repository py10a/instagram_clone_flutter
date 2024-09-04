import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/responsivnes/responsive_layout_screen.dart';

void main() {
  runApp(const InstagramClone());
}

class InstagramClone extends StatelessWidget {
  const InstagramClone({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Clone',
      theme: ThemeData.dark(),
      home: const ResponsiveLayoutScreen(),
    );
  }
}
