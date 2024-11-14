import 'package:demandes/core/themes/app_palette.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child:
            CircularProgressIndicator(color: AppPalette.buttonBackgroundColor));
  }
}
