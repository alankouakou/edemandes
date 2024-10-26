import 'package:demandes/features/authentification/data/services/auth_service.dart';
import 'package:demandes/features/authentification/presentation/pages/confirmation_reset_password.dart';
import 'package:demandes/features/authentification/presentation/widgets/auth_field.dart';
import 'package:demandes/core/themes/app_palette.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResetPasswordPage extends ConsumerStatefulWidget {
  const ResetPasswordPage({super.key});

  static Route route() {
    return MaterialPageRoute(builder: (_) => const ResetPasswordPage());
  }

  @override
  ConsumerState<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = ref.watch(authProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Reset password'),
        ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                autovalidateMode: AutovalidateMode.disabled,
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Réinitialisation du password',
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 20),
                      AuthField(
                          controller: emailController,
                          hintText: "Entrez l'e-mail de confirmation",
                          errorMessage: 'Veuillez entrer votre email',
                          suffixIcon: const Icon(Icons.mail)),
                      const SizedBox(height: 20),
                      OutlinedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              authService.resetPassword(emailController.text);
                              Navigator.pushReplacement(
                                context,
                                ConfirmationResetPassword.route(),
                              );
                            }
                          },
                          style: OutlinedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              backgroundColor: AppPalette.buttonBackgroundColor,
                              foregroundColor: Colors.white),
                          child: const Text(
                            'Envoyer',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))
                    ]),
              ),
            ),
          ),
        ));
  }
}
