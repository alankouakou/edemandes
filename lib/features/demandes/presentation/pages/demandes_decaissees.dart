import 'package:demandes/core/statuts.dart';
import 'package:demandes/core/utils.dart';
import 'package:demandes/core/widgets/loading.dart';
import 'package:demandes/features/authentification/presentation/providers/auth_providers.dart';
import 'package:demandes/features/demandes/presentation/pages/cloture_demande_page.dart';
import 'package:demandes/features/demandes/presentation/pages/validation_comptable.dart';
import 'package:demandes/features/demandes/presentation/providers/demande_providers.dart';

import 'package:demandes/features/demandes/presentation/providers/demande_stream_provider.dart';
import 'package:demandes/features/demandes/presentation/widgets/demande_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DemandesDecaissees extends ConsumerWidget {
  const DemandesDecaissees({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userUid = ref.watch(authRepoProvider).currentUser!.uid;

    print('User demandesByStatusPage - User UID: $userUid, ');
    final statusDemandes = ref.watch(decaisseStreamProvider);

    return Scaffold(
      body: statusDemandes.when(
        data: (dataList) => dataList.isEmpty
            ? const Center(
                child: Text('Aucune demande décaissée!'),
              )
            : ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  final demande = dataList[index];
                  return DemandeWidget(
                    demande: demande,
                    onLongPress: demande.montantDefinitif == 0
                        ? () => Navigator.push(context,
                            ClotureDemandePage.route(demande.docId!, demande))
                        : () => Utils.showErrorMessage(
                            message: 'Demande déja traitée'),
                    onTap: () => Navigator.push(
                        context, ValidationComptable.route(dataList[index])),
                  );
                },
              ),
        error: (e, s) => Center(child: Text(s.toString())),
        loading: () => const Loading(),
      ),
    );
  }
}
