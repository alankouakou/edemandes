import 'package:demandes/core/themes/app_theme.dart';
import 'package:demandes/core/utils.dart';
import 'package:demandes/features/demandes/data/models/demande.dart';
import 'package:demandes/features/demandes/presentation/providers/demande_providers.dart';
import 'package:demandes/features/demandes/presentation/widgets/appbar_title.dart';
import 'package:demandes/features/demandes/presentation/widgets/display_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gap/gap.dart';

class ValidationPage extends ConsumerWidget {
  final Demande demande;
  const ValidationPage({super.key, required this.demande});

  static Route route(Demande demande) {
    return MaterialPageRoute(builder: (_) => ValidationPage(demande: demande));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final montantDemande = Utils.formatCFA(500000);
    return Scaffold(
      appBar: AppBar(title: const AppBarTitle()),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: ListView(
              children: [
                const Text('Validation Page', style: AppTheme.pageTitleStyle),
                const Gap(10),
                DisplayFieldWidget(
                    title: 'Objet de la demande', text: demande.objet),
                const Gap(20),
                DisplayFieldWidget(
                    title: 'Montant prévisionnel',
                    text: Utils.formatCFA(demande.montantPrevisionnel)),
                const Gap(20),
                DisplayFieldWidget(title: 'Demandeur:', text: demande.user),
                const Gap(20),
                DisplayFieldWidget(title: 'Service: ', text: demande.service),
                const Gap(20),
                const DisplayFieldWidget(
                    title: 'Visa chef service:', text: 'N/A'),
                const Gap(20),
                const DisplayFieldWidget(title: 'Visa RAF:', text: 'N/A'),
                const Gap(20),
                const DisplayFieldWidget(
                    title: 'Visa Coordonnateur:', text: 'N/A'),
                const Gap(20),
                DisplayFieldWidget(
                    title: 'Date de la demande:',
                    text: Utils.dateFull.format(demande.dateCreated)),
                const Gap(20),
              ],
            )),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: [3, 4, 5].contains(demande.statut)
                          ? null
                          : () {
                              ref.read(demandeRepoProvider).updateDemande(
                                  demande.docId!, demande.copyWith(statut: 3));
                              Utils.showErrorMessage(
                                  message: 'Demande rejetée!');
                              Navigator.pop(context);
                            },
                      child: const Text(
                        'Rejeter',
                      )),
                  const Gap(20.0),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: [3, 4, 5].contains(demande.statut)
                          ? null
                          : () {
                              ref.read(demandeRepoProvider).updateDemande(
                                  demande.docId!, demande.copyWith(statut: 4));
                              Utils.showSuccessMessage(
                                  message: 'Demande acceptée!');
                              Navigator.pop(context);
                            },
                      child: const Text(
                        'Approuver',
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
