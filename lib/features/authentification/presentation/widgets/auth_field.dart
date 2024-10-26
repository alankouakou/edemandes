import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon suffixIcon;
  final bool obscureText;
  final String errorMessage;
  const AuthField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.errorMessage = 'Champ obligatoire',
      required this.suffixIcon,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorMessage;
        }
        return null;
      },
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(hintText: hintText, suffixIcon: suffixIcon),
    );
  }
}
