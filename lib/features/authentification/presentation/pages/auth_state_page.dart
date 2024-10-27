import 'package:demandes/features/authentification/presentation/pages/login_page.dart';
import 'package:demandes/features/authentification/presentation/providers/auth_providers.dart';
import 'package:demandes/features/demandes/presentation/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthStatePage extends ConsumerWidget {
  const AuthStatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authRepoProvider);
    return StreamBuilder(
        stream: auth.authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              if (auth.currentUser == null) {
                return const LoginPage();
              }
              return const WelcomePage();
            } else {
              return const LoginPage();
            }
          }
        });
  }
}
