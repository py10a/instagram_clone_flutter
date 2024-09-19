import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/presentation/widgets/text_field_input/text_field_input.dart';

class NameTextFieldInput extends StatelessWidget {
  const NameTextFieldInput({
    super.key,
    required this.controller,
    this.isUsername = false,
  });

  final bool isUsername;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFieldInput(
      controller: controller,
      hintText: isUsername ? 'Type username here...' : 'Type your name here...',
      labelText: isUsername ? 'Username' : 'Name',
      prefixText: isUsername ? '@' : null,
      keyboardType: TextInputType.name,
    );
  }
}
