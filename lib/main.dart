import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/firebase_options.dart';
import 'package:instagram_clone_flutter/presentation/screens/screens.dart';
import 'package:instagram_clone_flutter/providers/post_provider.dart';
import 'package:instagram_clone_flutter/providers/user_provider.dart';
import 'package:instagram_clone_flutter/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone_flutter/utils/themes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const InstagramClone());
}

class InstagramClone extends StatelessWidget {
  const InstagramClone({super.key});

  Widget buildContent(BuildContext context, AsyncSnapshot<User?> snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.waiting:
        if (snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return ResponsiveLayoutScreen(
            child: Center(child: Text('Error: ${snapshot.error}')),
          );
        }
        break;
      case ConnectionState.active:
        if (snapshot.hasData) {
          return ResponsiveLayoutScreen(child: const HomeScreen());
        }
        if (snapshot.hasError) {
          return ResponsiveLayoutScreen(
            child: Center(child: Text('Error: ${snapshot.error}')),
          );
        }
        break;
      case ConnectionState.none:
      // TODO: Handle this case.
      case ConnectionState.done:
      // TODO: Handle this case.
    }
    return const LoginScreen();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => PostProvider()),
      ],
      child: MaterialApp(
        title: 'Instagram Clone',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.userChanges(),
          builder: buildContent,
        ),
      ),
    );
  }
}
