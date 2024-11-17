import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/providers/user_provider.dart';
import 'package:instagram_clone_flutter/repository/auth/firebase_auth_methods.dart';
import 'package:instagram_clone_flutter/repository/models/user.dart' as models;
import 'package:provider/provider.dart';

final firebaseAuthMethods = FirebaseAuthMethods.instance;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  models.User? user;

  @override
  void didChangeDependencies() {
    user = Provider.of<UserProvider>(context, listen: false).user!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 150,
        centerTitle: false,
        title: Text(
          user!.username,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: user != null
              ? () async {
                  Provider.of<UserProvider>(context, listen: false).signOut();
                }
              : null,
          child: const Text('Sign out'),
        ),
      ),
    );
  }
}
