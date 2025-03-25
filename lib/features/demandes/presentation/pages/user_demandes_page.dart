import 'package:demandes/core/statuts.dart';
import 'package:demandes/core/themes/app_palette.dart';
import 'package:demandes/core/widgets/loading.dart';
import 'package:demandes/features/authentification/presentation/providers/auth_providers.dart';
import 'package:demandes/features/demandes/presentation/pages/details_demande_page.dart';
import 'package:demandes/features/demandes/presentation/pages/edit_demande_page.dart';
import 'package:demandes/features/demandes/presentation/pages/new_demande_page.dart';
import 'package:demandes/features/demandes/presentation/providers/demande_providers.dart';
import 'package:demandes/features/demandes/presentation/widgets/demande_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDemandesPage extends ConsumerWidget {
  const UserDemandesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userUid = ref.watch(authRepoProvider).currentUser!.uid;

    print('User demandesPage - User UID: $userUid');
    final userDemandes = ref.watch(demandeRepoProvider).fetchByUserUid(userUid);
    //
    //
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
            child: StreamBuilder(
              stream: userDemandes,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final dataList = snapshot.data;
                  print('Nb items: ${dataList!.length}');
                  return dataList.isEmpty
                      ? const Center(child: Text('Aucune demande'))
                      : ListView.builder(
                          itemCount: dataList.length,
                          itemBuilder: (context, index) {
                            final demande = dataList[index];
                            final docId = demande.docId!;
                            return DemandeWidget(
                              demande: dataList[index],
                              onLongPress: demande.statut != Statut.created
                                  ? null
                                  : () => Navigator.push(context,
                                      EditDemandePage.route(docId, demande)),
                              onTap: () => Navigator.push(
                                  context, DetailsDemandePage.route(demande)),
                            );
                          },
                        );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Loading();
                } else if (snapshot.hasError) {
                  print(snapshot.error.toString());
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return const Center(child: Text('Pas de données'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
