import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone_flutter/presentation/screens/screens.dart';

String currentUserUid = FirebaseAuth.instance.currentUser!.uid;

final homeScreenItems = [
  HomeScreen(),
  SearchScreen(),
  AddPostScreen(),
  ReelsScreen(),
  ProfileScreen(uid: currentUserUid),
];
