import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone_flutter/presentation/screens/sign_up_screen.dart';
import 'package:instagram_clone_flutter/presentation/widgets/email_text_field_input.dart';
import 'package:instagram_clone_flutter/presentation/widgets/password_text_field_input.dart';
import 'package:instagram_clone_flutter/repository/auth/firebase_auth_methods.dart';
import 'package:instagram_clone_flutter/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void logIn() async {
    setState(() {
      _isLoading = true;
    });
    String res = await FirebaseAuthMethods().signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );
    FocusManager.instance.primaryFocus?.unfocus();
    if (mounted) {
      showSnackBar(
        context: context,
        text: res,
        isError: res != 'success',
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  void signUp() {
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
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
        width: 200,
      ),
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
      onPressed: logIn,
      child: _isLoading
          ? CircularProgressIndicator(
              strokeWidth: 2,
              color: Theme.of(context).colorScheme.onPrimary,
            )
          : const Text('Log in'),
    );
    ButtonStyleButton signUpButton = TextButton(
      style: FilledButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      onPressed: signUp,
      child: const Text('Sign up'),
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                logo,
                const SizedBox(height: 64),
                emailTextInput,
                const SizedBox(height: 12),
                passwordTextInput,
                const SizedBox(height: 64),
                loginButton,
                const SizedBox(height: 8),
                signUpButton,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
