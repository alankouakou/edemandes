import 'package:demandes/core/widgets/loading.dart';
import 'package:demandes/features/authentification/presentation/providers/auth_providers.dart';
import 'package:demandes/features/demandes/presentation/pages/new_demande_page.dart';
import 'package:demandes/features/demandes/presentation/pages/validation_comptable.dart';

import 'package:demandes/features/demandes/presentation/providers/demande_stream_provider.dart';
import 'package:demandes/features/demandes/presentation/widgets/demande_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SavDemandesComptable extends ConsumerWidget {
  const SavDemandesComptable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userUid = ref.watch(authRepoProvider).currentUser!.uid;

    print('User demandesByStatusPage - User UID: $userUid, ');
    final statusDemandes = ref.watch(comptaStreamProvider);

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, NewDemandePage.route());
                },
                child: const Text("Nouvelle demande",
                    style: TextStyle(fontWeight: FontWeight.bold))),
          ),
          Expanded(
            child: statusDemandes.when(
              data: (dataList) => dataList.isEmpty
                  ? const Center(
                      child: Text('Aucune demande à traiter'),
                    )
                  : ListView.builder(
                      itemCount: dataList.length,
                      itemBuilder: (context, index) {
                        return DemandeWidget(
                          demande: dataList[index],
                          onTap: () => Navigator.push(context,
                              ValidationComptable.route(dataList[index])),
                        );
                      },
                    ),
              error: (e, s) => Center(child: Text(s.toString())),
              loading: () => const Loading(),
            ),
          ),
        ],
      ),
    );
  }
}
