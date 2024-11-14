import 'package:flutter/material.dart';

class LoadingWhite extends StatelessWidget {
  const LoadingWhite({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator(color: Colors.white));
  }
}
