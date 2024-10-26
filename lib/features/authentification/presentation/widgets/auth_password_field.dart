import 'package:flutter/material.dart';

class AuthPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String errorMessage;
  final TextEditingController?
      confirmPasswordField; //optionnel, utilisé pour confirmer le mot de passe saisi
  final String hintText;
  final bool obscureText = true;
  const AuthPasswordField({
    super.key,
    this.errorMessage = 'Renseignez le mot de passe',
    this.confirmPasswordField,
    required this.controller,
    required this.hintText,
  });

  @override
  State<AuthPasswordField> createState() => _AuthPasswordFieldState();
}

class _AuthPasswordFieldState extends State<AuthPasswordField> {
  late bool myObscureText;
  @override
  void initState() {
    myObscureText = widget.obscureText;
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget.errorMessage;
        }
        if (widget.confirmPasswordField != null &&
            widget.confirmPasswordField!.text != value) {
          print(widget.confirmPasswordField?.text);
          print(value);

          return 'Les mots de passe ne sont pas identiques';
        }
        return null;
      },
      controller: widget.controller,
      obscureText: myObscureText,
      decoration: InputDecoration(
          hintText: widget.hintText,
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  myObscureText = !myObscureText;
                });
              },
              icon: myObscureText == true
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off))),
    );
  }
}
