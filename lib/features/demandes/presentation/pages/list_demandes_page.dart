import 'package:demandes/core/themes/app_palette.dart';
import 'package:demandes/features/authentification/presentation/providers/auth_providers.dart';
import 'package:demandes/features/demandes/presentation/pages/add_demande_page.dart';
import 'package:demandes/features/demandes/presentation/providers/demande_providers.dart';
import 'package:demandes/features/demandes/presentation/providers/demande_stream_provider.dart';

import 'package:demandes/features/demandes/presentation/widgets/demande_item.dart';
import 'package:demandes/features/demandes/presentation/widgets/demande_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListDemandesPage extends ConsumerWidget {
  const ListDemandesPage({super.key});

  static Route route() =>
      MaterialPageRoute(builder: (context) => const ListDemandesPage());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streamDemandes = ref.watch(demandeStreamProvider);
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
              subtitle: Text('Charles K.',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          actions: [
            IconButton(
                onPressed: () {
                  ref.read(authRepoProvider).signOut();
                },
                icon: const Icon(Icons.power_settings_new)),
          ]),
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: .0),
        child: Column(children: [
          Container(
            decoration: const BoxDecoration(color: Colors.white),
            height: MediaQuery.of(context).size.height * 0.1,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Demandes',
                      style: Theme.of(context).textTheme.titleLarge),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, AddDemandePage.route());
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      child: const Text('Nouvelle demande +',
                          style: TextStyle(fontWeight: FontWeight.bold)))
                ],
              ),
            ),
          ),
          Expanded(
              child: streamDemandes.when(
                  data: (dataList) => ListView.builder(
                        itemCount: dataList.length,
                        itemBuilder: (context, index) {
                          return DemandeWidget(demande: dataList[index]);
                        },
                      ),
                  error: (e, s) => Center(child: Text(s.toString())),
                  loading: () => const Center(
                      child: CircularProgressIndicator(
                          color: AppPalette.buttonBackgroundColor)))),
        ]),
      ),
    );
  }
}
