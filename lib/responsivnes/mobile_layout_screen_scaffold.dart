import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/responsivnes/base_layout_screen_scaffold.dart';

class MobileLayoutScreenScaffold extends BaseLayoutScreenScaffold {
  const MobileLayoutScreenScaffold({
    super.key,
    required super.child,
  });

  @override
  _MobileLayoutScreenScaffoldState createState() =>
      _MobileLayoutScreenScaffoldState();
}

class _MobileLayoutScreenScaffoldState extends BaseLayoutScreenScaffoldState {
  String _username = '';

  @override
  void initState() {
    super.initState();
    _fetchUsername();
  }

  void _fetchUsername() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (snapshot.exists) {
      var data = snapshot.data() as Map<String, dynamic>;
      setState(() {
        _username = data['username'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_username),
      ),
      body: widget.child,
    );
  }
}
