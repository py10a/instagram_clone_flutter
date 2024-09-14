import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone_flutter/screens/sign_up_screen.dart';
import 'package:instagram_clone_flutter/widgets/email_text_field_input.dart';
import 'package:instagram_clone_flutter/widgets/password_text_field_input.dart';

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
    var brightness = MediaQuery.of(context).platformBrightness;
    final Color color =
        brightness == Brightness.dark ? Colors.white : Colors.black;

    // Logo
    SvgPicture logo = SvgPicture.asset(
      'assets/images/instagram_logo.svg',
      color: color,
      width: 200,
    );
    // Inputs
    Widget emailTextInput = EmailTextFieldInput(
      controller: _emailController,
    );
    Widget passwordTextInput = PasswordTextFieldInput(
      controller: _passwordController,
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
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignUpScreen(),
          ),
        );
      },
      child: const Text('Sign up'),
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
                const SizedBox(height: 32),
                emailTextInput,
                const SizedBox(height: 12),
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
