import 'package:demandes/features/authentification/presentation/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:demandes/features/demandes/presentation/widgets/appbar_title.dart';

class AddDemandePage extends ConsumerStatefulWidget {
  const AddDemandePage({super.key});
  static Route route() =>
      MaterialPageRoute(builder: (context) => const AddDemandePage());

  @override
  ConsumerState<AddDemandePage> createState() => _AddDemandePageState();
}

class _AddDemandePageState extends ConsumerState<AddDemandePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(),
        actions: [
          IconButton(
              onPressed: () {
                ref.read(authRepoProvider).signOut();
              },
              icon: const Icon(Icons.power_settings_new)),
        ],
      ),
      body: const Column(
        children: [
          Center(
            child: Text('Page Nouvelle Demande '),
          ),
        ],
      ),
    );
  }
}
