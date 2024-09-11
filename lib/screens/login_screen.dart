import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone_flutter/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    ButtonStyleButton loginButton = FilledButton(
      style: FilledButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: const Text('Log in'),
    );
    ButtonStyleButton signUpButton = TextButton(
      style: FilledButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      onPressed: () {},
      child: const Text('Sign up'),
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
                emailTextInput,
                const SizedBox(height: 8),
                passwordTextInput,
                const SizedBox(height: 64),
                Column(
                  children: [
                    loginButton,
                    const SizedBox(height: 8),
                    signUpButton,
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
