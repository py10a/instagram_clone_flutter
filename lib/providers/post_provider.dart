import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/repository/models/models.dart';
import 'package:instagram_clone_flutter/repository/posts/firebase_post_methods.dart';

final _firebasePostMethods = FirebasePostMethods.instance;

class PostProvider with ChangeNotifier {
  List<Post> _posts = [];

  List<Post> get posts => _posts;
  Stream<QuerySnapshot> get postsStream => _firebasePostMethods.postsStream;

  void addPost(Post post) {
    _posts.add(post);
    notifyListeners();
  }

  Future<void> refreshPosts() async {
    _posts = await _firebasePostMethods.posts;
    notifyListeners();
  }
}
