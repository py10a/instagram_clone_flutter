import 'package:flutter/material.dart';

class TextFieldInput extends StatefulWidget {
  const TextFieldInput({
    super.key,
    required this.controller,
    this.hintText = 'Enter text',
    this.labelText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.prefixText,
  });

  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final String? prefixText;
  final Widget? suffixIcon;

  @override
  State<TextFieldInput> createState() => _TextFieldInputState();
}

class _TextFieldInputState extends State<TextFieldInput> {
  @override
  Widget build(BuildContext context) {
    InputDecoration decoration = InputDecoration(
      labelText: widget.labelText,
      hintText: widget.hintText,
      suffixIcon: widget.suffixIcon,
      prefixIcon: widget.prefixIcon,
      prefixText: widget.prefixText,
    );

    return TextField(
      controller: widget.controller,
      decoration: decoration,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      autocorrect: false,
    );
  }
}
