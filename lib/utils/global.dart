import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone_flutter/presentation/screens/screens.dart';

final homeScreenItems = [
  HomeScreen(),
  SearchScreen(),
  AddPostScreen(),
  ReelsScreen(),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
];
