import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone_flutter/screens/login_screen.dart';
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    final Color color =
        brightness == Brightness.dark ? Colors.white : Colors.black;

    // Logo
    SvgPicture logo = SvgPicture.asset(
      'assets/images/instagram_logo.svg',
      color: color,
      width: 100,
    );
    // Avatar
    Widget avatar = InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {},
      child: Stack(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey[300],
            child: Icon(
              Icons.camera_alt,
              size: 40,
              color: Colors.grey[600],
            ),
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
    Widget nameTextInput = NameTextFieldInput(
      controller: _nameController,
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
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: const Text('Sign up'),
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
                const SizedBox(height: 16),
                avatar,
                const SizedBox(height: 12),
                usernameTextInput,
                const SizedBox(height: 12),
                nameTextInput,
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
