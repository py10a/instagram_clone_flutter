import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_flutter/repository/auth/firebase_auth_methods.dart';
import 'package:instagram_clone_flutter/screens/login_screen.dart';
import 'package:instagram_clone_flutter/utils/utils.dart';
import 'package:instagram_clone_flutter/widgets/email_text_field_input.dart';
import 'package:instagram_clone_flutter/widgets/name_text_field_input.dart';
import 'package:instagram_clone_flutter/widgets/password_text_field_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Uint8List? _avatarImage;
  bool _isSigningUp = false;

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  Future<void> selectImage() async {
    _avatarImage = await pickImage(ImageSource.gallery);
    setState(() {
      _avatarImage = _avatarImage;
    });
  }

  void signUp() async {
    setState(() {
      _isSigningUp = true;
    });
    String response = await FirebaseAuthMethods().signUpWithEmailAndPassword(
      email: _emailController.text,
      username: _usernameController.text,
      password: _passwordController.text,
      image: _avatarImage ?? Uint8List(0),
    );
    if (mounted) {
      showSnackBar(
        context: context,
        text: response,
        isError: response != 'success',
      );
    }
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      _isSigningUp = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    final Color color =
        brightness == Brightness.dark ? Colors.white : Colors.black;
    // Logo
    Widget logo = Hero(
      tag: 'logo',
      child: SvgPicture.asset(
        'assets/images/instagram_logo.svg',
        color: color,
        width: 100,
      ),
    );
    // Avatar
    Widget avatar = InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        await selectImage();
      },
      child: Stack(
        children: [
          CircleAvatar(
            radius: 40,
            foregroundImage: _avatarImage != null
                ? MemoryImage(_avatarImage!)
                : Image.asset('assets/images/default_avatar.png').image,
            backgroundColor: Colors.transparent,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              radius: 14,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Icon(
                Icons.add,
                size: 16,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
    // Inputs
    Widget usernameTextInput = NameTextFieldInput(
      controller: _usernameController,
      isUsername: true,
    );
    Widget emailTextInput = EmailTextFieldInput(
      controller: _emailController,
    );
    Widget passwordTextInput = PasswordTextFieldInput(
      controller: _passwordController,
    );
    // Buttons
    ButtonStyleButton signUpButton = FilledButton(
      style: FilledButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      onPressed: signUp,
      child: _isSigningUp
          ? CircularProgressIndicator(
              strokeWidth: 2,
              color: Theme.of(context).colorScheme.onPrimary,
            )
          : const Text('Sign up'),
    );
    ButtonStyleButton loginButton = TextButton(
      style: FilledButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      },
      child: const Text('Back to login'),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                logo,
                const SizedBox(height: 8),
                avatar,
                const SizedBox(height: 32),
                usernameTextInput,
                const SizedBox(height: 12),
                emailTextInput,
                const SizedBox(height: 12),
                passwordTextInput,
                const SizedBox(height: 64),
                signUpButton,
                const SizedBox(height: 8),
                loginButton,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
