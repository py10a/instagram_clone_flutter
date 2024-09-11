import 'package:flutter/material.dart';

class TextFieldInput extends StatefulWidget {
  const TextFieldInput({
    super.key,
    this.hintText = '',
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.icon,
    this.prefixIcon,
    required this.controller,
  });

  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final String hintText;
  final IconData? icon;
  final Widget? prefixIcon;

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
    final decoration = const InputDecoration().copyWith(
      hintText: widget.hintText,
      prefixIcon: widget.prefixIcon,
      suffixIcon: widget.isPassword
          ? IconButton(
              icon: const Icon(Icons.remove_red_eye),
              onPressed: showPassword,
              color: isObscure
                  ? Theme.of(context).iconTheme.color
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
