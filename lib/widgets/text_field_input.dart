import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  const TextFieldInput({
    super.key,
    this.hintText = '',
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    required this.controller,
  });

  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final decoration = InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey[400]),
      border: const OutlineInputBorder(borderSide: BorderSide()),
      filled: true,
      fillColor: Colors.grey[800],
    );

    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      autocorrect: !isPassword,
      decoration: decoration,
    );
  }
}
