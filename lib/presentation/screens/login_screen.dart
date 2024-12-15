import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone_flutter/presentation/screens/screens.dart';
import 'package:instagram_clone_flutter/presentation/widgets/widgets.dart';
import 'package:instagram_clone_flutter/providers/user_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
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
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() => _isLoading = true);
    await Provider.of<UserProvider>(context, listen: false)
        .signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );
    setState(() => _isLoading = false);
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
        // ignore: deprecated_member_use
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
    Widget loginButton = PrimaryButton(
      text: const Text('Log in'),
      onPressed: logIn,
      isAsync: _isLoading,
    );
    Widget signUpButton = SecondaryButton(
      text: const Text('Sign up'),
      onPressed: signUp,
    );

    return PopScope(
      canPop: false,
      child: Scaffold(
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
      ),
    );
  }
}
