import 'package:demandes/features/authentification/presentation/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class ResetPasswordPage extends ConsumerStatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  ConsumerState<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Réinitialisation du password',
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    const Gap(20),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          hintText: "Entrez l'e-mail de confirmation"),
                    ),
                    const Gap(20),
                    OutlinedButton(
                        onPressed: () {
                          ref
                              .read(authRepoProvider)
                              .resetPassword(emailController.text);
                          Navigator.pop(context);
                          //
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50.0),
                        ),
                        child: const Text(
                          'Envoyer le mail',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                  ]),
            ),
          ),
        ));
  }
}
