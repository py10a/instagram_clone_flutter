import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/presentation/screens/add_post_screen.dart';
import 'package:instagram_clone_flutter/presentation/screens/home_screen.dart';

const homeScreenItems = [
  HomeScreen(),
  Center(child: Text('Search')),
  AddPostScreen(),
  Center(child: Text('Reels')),
  Center(child: Text('Profile')),
];
