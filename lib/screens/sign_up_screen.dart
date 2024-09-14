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
    // Logo
    SvgPicture logo = SvgPicture.asset(
      'assets/images/instagram_logo.svg',
      color: Colors.white,
      width: 200,
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                logo,
                const SizedBox(height: 32),
                usernameTextInput,
                const SizedBox(height: 12),
                nameTextInput,
                const SizedBox(height: 12),
                emailTextInput,
                const SizedBox(height: 12),
                passwordTextInput,
                const SizedBox(height: 64),
                Column(
                  children: [
                    signUpButton,
                    const SizedBox(height: 8),
                    loginButton,
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
