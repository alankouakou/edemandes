import 'package:demandes/features/authentification/presentation/pages/login_page.dart';
import 'package:demandes/features/authentification/data/services/auth_service.dart';
import 'package:demandes/features/demandes/presentation/pages/main_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthStatePage extends ConsumerWidget {
  const AuthStatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.watch(authProvider);
    return StreamBuilder(
        stream: authService.authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const MainPage();
          } else {
            return const LoginPage();
          }
        });
  }
}
