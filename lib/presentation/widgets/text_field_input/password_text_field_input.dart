import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/presentation/widgets/text_field_input/text_field_input.dart';

class PasswordTextFieldInput extends StatefulWidget {
  const PasswordTextFieldInput({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  State<PasswordTextFieldInput> createState() => _PasswordTextFieldInputState();
}

class _PasswordTextFieldInputState extends State<PasswordTextFieldInput> {
  bool isObscure = true;

  void showPassword() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldInput(
      controller: widget.controller,
      hintText: 'Enter password here...',
      labelText: 'Password',
      keyboardType: TextInputType.visiblePassword,
      obscureText: isObscure,
      suffixIcon: IconButton(
        onPressed: showPassword,
        icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off),
      ),
    );
  }
}
