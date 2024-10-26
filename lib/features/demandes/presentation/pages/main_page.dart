import 'package:demandes/core/themes/app_palette.dart';
import 'package:demandes/features/demandes/presentation/pages/add_demande.dart';
import 'package:demandes/features/demandes/presentation/pages/list_demandes.dart';
import 'package:flutter/material.dart';
import 'package:demandes/features/authentification/data/services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.watch(authProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demandes en attente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Hello ${authService.auth.currentUser!.email} !'),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    //Appeler l'ecran d'ajout de demande
                    Navigator.push(context, ListDemandes.route());
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50.0),
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      )),
                  child: const Text('Mes demandes',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ))),
              const SizedBox(height: 20.0),
              ElevatedButton(
                  onPressed: () {
                    //Appeler l'ecran d'ajout de demande
                    Navigator.push(context, AddDemande.route());
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50.0),
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      )),
                  child: const Text('Initier une demande',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ))),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      authService.signOut();
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50.0),
                        backgroundColor: AppPalette.buttonBackgroundColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        )),
                    child: const Text('Se deconnecter',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ))),
              ),
            ]),
      ),
    );
  }
}
