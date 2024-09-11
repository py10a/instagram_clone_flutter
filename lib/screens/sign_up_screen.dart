import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone_flutter/widgets/text_field_input.dart';

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
    TextFieldInput usernameTextInput = TextFieldInput(
      controller: _usernameController,
      hintText: 'Enter your username',
      keyboardType: TextInputType.name,
      prefixIcon: const Text('@'),
    );
    TextFieldInput nameTextInput = TextFieldInput(
      controller: _nameController,
      hintText: 'Enter your name and surname',
      keyboardType: TextInputType.name,
    );
    TextFieldInput emailTextInput = TextFieldInput(
      controller: _emailController,
      hintText: 'Enter your email',
      keyboardType: TextInputType.emailAddress,
    );
    TextFieldInput passwordTextInput = TextFieldInput(
      controller: _passwordController,
      hintText: 'Enter your password',
      isPassword: true,
      keyboardType: TextInputType.visiblePassword,
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
      onPressed: () {},
      child: const Text('Back to login'),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                logo,
                const SizedBox(height: 32),
                usernameTextInput,
                const SizedBox(height: 8),
                nameTextInput,
                const SizedBox(height: 8),
                emailTextInput,
                const SizedBox(height: 8),
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
