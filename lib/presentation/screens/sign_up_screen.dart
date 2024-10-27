import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_flutter/presentation/screens/screens.dart';
import 'package:instagram_clone_flutter/presentation/widgets/widgets.dart';
import 'package:instagram_clone_flutter/providers/user_provider.dart';
import 'package:instagram_clone_flutter/repository/auth/firebase_auth_methods.dart';
import 'package:instagram_clone_flutter/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone_flutter/utils/utils.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
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

  void signUp(context) async {
    setState(() {
      _isSigningUp = true;
    });
    String response =
        await FirebaseAuthMethods.instance.signUpWithEmailAndPassword(
      email: _emailController.text,
      username: _usernameController.text,
      password: _passwordController.text,
      image: _avatarImage ?? Uint8List(0),
    );
    if (response == 'success') {
      _usernameController.clear();
      _emailController.clear();
      _passwordController.clear();
      Provider.of<UserProvider>(context, listen: false).refreshUser();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              ResponsiveLayoutScreen(child: const HomeScreen()),
        ),
      );
    }
    if (mounted) {
      showSnackBar(
        response,
        context: context,
        isError: response != 'success',
      );
    }
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      _isSigningUp = false;
    });
  }

  void logIn() {
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
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
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
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
    Widget signUpButton = PrimaryButton(
      text: const Text('Sign up'),
      onPressed: () => signUp(context),
      isAsync: _isSigningUp,
    );
    Widget loginButton = SecondaryButton(
      text: const Text('Back to login'),
      onPressed: logIn,
    );

    return Scaffold(
      appBar: AppBar(
        title: logo,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 64),
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
