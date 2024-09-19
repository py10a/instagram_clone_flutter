import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/presentation/widgets/text_field_input/text_field_input.dart';

class EmailTextFieldInput extends StatelessWidget {
  const EmailTextFieldInput({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFieldInput(
      controller: controller,
      hintText: 'Enter email here...',
      labelText: 'Email',
      keyboardType: TextInputType.emailAddress,
    );
  }
}
