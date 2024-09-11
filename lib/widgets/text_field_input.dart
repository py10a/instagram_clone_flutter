import 'package:flutter/material.dart';

class TextFieldInput extends StatefulWidget {
  const TextFieldInput({
    super.key,
    this.hintText = '',
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.icon,
    required this.controller,
  });

  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final String hintText;
  final IconData? icon;

  @override
  State<TextFieldInput> createState() => _TextFieldInputState();
}

class _TextFieldInputState extends State<TextFieldInput> {
  bool isObscure = true;

  void showPassword() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    final decoration = InputDecoration(
      hintText: widget.hintText,
      hintStyle: TextStyle(color: Colors.grey[400]),
      border: const OutlineInputBorder(borderSide: BorderSide()),
      filled: true,
      fillColor: Colors.grey[800],
      suffixIcon: widget.isPassword
          ? IconButton(
              icon: const Icon(Icons.remove_red_eye),
              onPressed: showPassword,
              color: isObscure
                  ? Colors.grey[400]
                  : Theme.of(context).iconTheme.color,
            )
          : null,
    );

    return TextField(
      controller: widget.controller,
      obscureText: isObscure,
      keyboardType: widget.keyboardType,
      autocorrect: !widget.isPassword,
      decoration: decoration,
    );
  }
}
