import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_flutter/presentation/screens/screens.dart';
import 'package:instagram_clone_flutter/providers/user_provider.dart';
import 'package:instagram_clone_flutter/repository/models/models.dart'
    as models;
import 'package:instagram_clone_flutter/repository/posts/firebase_post_methods.dart';
import 'package:instagram_clone_flutter/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone_flutter/utils/utils.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({
    super.key,
  });

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final _firebasePostMethods = FirebasePostMethods.instance;
  final _descriptionController = TextEditingController();
  Uint8List? _image;
  bool _isUploading = false;
  models.User user = models.User.origin();

  Future<String> postImage(BuildContext context) async {
    if (_image == null) {
      showSnackBar(
        'Please select an image',
        context: context,
        isError: true,
      );
      return '';
    }
    setState(() {
      _isUploading = true;
    });
    final pathToPost = await _firebasePostMethods.createPost(
      id: user.uid,
      avatarUrl: user.imageUrl,
      username: user.username,
      description: _descriptionController.text,
      postImage: _image!,
    );
    setState(() {
      _isUploading = false;
    });
    if (context.mounted) {
      showSnackBar('Post created successfully', context: context);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ResponsiveLayoutScreen(
            child: const HomeScreen(),
          ),
        ),
      );
    }
    return pathToPost;
  }

  Future<void> _selectImage(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Select image'),
            content: const Text(
                'Select image from gallery or take a photo via camera.'),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  final chosenImage = await pickImage(ImageSource.gallery);
                  setState(() {
                    _image = chosenImage;
                  });
                },
                child: const Text('Gallery'),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  final chosenImage = await pickImage(ImageSource.camera);
                  setState(() {
                    _image = chosenImage;
                  });
                },
                child: const Text('Camera'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context).user!;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: _isUploading ? LinearProgressIndicator() : SizedBox(height: 2),
        ),
        title: Text(
          'Add post',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
              onPressed: () async => await postImage(context),
              style: TextButton.styleFrom(
                  foregroundColor:
                      Theme.of(context).colorScheme.primaryContainer),
              child: const Text('Post')),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.3,
              child: GestureDetector(
                onTap: () => _selectImage(context),
                child: AspectRatio(
                  aspectRatio: 3 / 4,
                  child: _image == null
                      ? Container(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          child: Icon(
                            Icons.add,
                            size: 32,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        )
                      : Image.memory(_image!),
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              child: TextField(
                controller: _descriptionController,
                minLines: 4,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Write a caption...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
