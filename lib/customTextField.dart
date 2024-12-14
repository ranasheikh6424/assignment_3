import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText; // Placeholder text
  final String labelText; // Label text
  TextInputType? keyboardType; // Keyboard type
  final TextEditingController controller; // Text controller
  String? Function(String?)? validator; // Validator function

  CustomTextField({
    super.key,
    required this.hintText,
    required this.labelText,
    this.keyboardType,
    required this.controller,
    this.validator, // Optional validator
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      validator: validator, // Attach the validator function
    );
  }
}
