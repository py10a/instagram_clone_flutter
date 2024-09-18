import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/presentation/screens/home_screen.dart';
import 'package:instagram_clone_flutter/presentation/screens/login_screen.dart';
import 'package:instagram_clone_flutter/responsivnes/responsive_layout_screen.dart';
import 'package:instagram_clone_flutter/utils/themes.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const InstagramClone());
}

class InstagramClone extends StatelessWidget {
  const InstagramClone({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Clone',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.idTokenChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return ResponsiveLayoutScreen(
                child: const HomeScreen(),
              );
            } else if (snapshot.hasError) {
              return ResponsiveLayoutScreen(
                child: Scaffold(
                  body: Center(
                    child: Text('Error: ${snapshot.error}'),
                  ),
                ),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return ResponsiveLayoutScreen(
              child: const Scaffold(
                body: Center(
                  child: Text('Connection state done'),
                ),
              ),
            );
          }
          return ResponsiveLayoutScreen(
            child: const LoginScreen(),
          );
        },
      ),
    );
  }
}
