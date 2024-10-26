import 'package:demandes/core/themes/app_palette.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const AuthButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          backgroundColor: AppPalette.buttonBackgroundColor,
        ),
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ));
  }
}
