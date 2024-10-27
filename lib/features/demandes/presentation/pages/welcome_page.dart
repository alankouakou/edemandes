import 'package:demandes/features/authentification/presentation/providers/auth_providers.dart';
import 'package:demandes/features/authentification/services/auth_service.dart';
import 'package:demandes/features/demandes/presentation/widgets/custom_panel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomePage extends ConsumerWidget {
  const WelcomePage({super.key});

  static Route route() =>
      MaterialPageRoute(builder: (context) => const WelcomePage());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: const ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text('Bonjour',
                  style: TextStyle(fontSize: 14, color: Colors.black54)),
              subtitle: Text('Alan K.',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          actions: [
            IconButton(
                onPressed: () {
                  ref.read(authRepoProvider).signOut();
                },
                icon: const Icon(Icons.power_settings_new)),
          ]),
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Demandes',
                      style: Theme.of(context).textTheme.titleLarge),
                  IconButton(
                      iconSize: 30.0,
                      onPressed: () {},
                      icon: const Icon(Icons.add_circle, color: Colors.blue))
                ],
              ),
            ),
            const CustomPanel(color: Colors.red),
            const CustomPanel(color: Colors.green),
            const CustomPanel(color: Colors.blue),
            const CustomPanel(color: Colors.orange),
            const CustomPanel(color: Colors.grey),
            const CustomPanel(color: Colors.lightBlue),
          ]),
        ),
      ),
    );
  }
}
