import 'package:demandes/core/themes/app_palette.dart';
import 'package:flutter/material.dart';

class ConfirmationResetPassword extends StatelessWidget {
  const ConfirmationResetPassword({super.key});

  static Route route() {
    return MaterialPageRoute(builder: (_) => const ConfirmationResetPassword());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Confirmation'),
        ),
        backgroundColor: AppPalette.scaffoldLightBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20.0),
                RichText(
                    text: TextSpan(
                        text: 'Consultez votre boîte mail\n',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppPalette.successMessageColor),
                        children: [
                      TextSpan(
                          text: 'Un lien vous a été envoyé\n',
                          style: Theme.of(context).textTheme.titleMedium),
                      TextSpan(
                          text: 'Pour réinitialiser votre mot de passe,\n',
                          style: Theme.of(context).textTheme.titleMedium),
                      TextSpan(
                          text: 'cliquez sur le lien ',
                          style: Theme.of(context).textTheme.titleMedium),
                    ])),
                const SizedBox(height: 20),
                OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      backgroundColor: AppPalette.buttonBackgroundColor,
                    ),
                    child: const Text(
                      'OK',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
                const SizedBox(height: 20),
              ]),
        ));
  }
}
