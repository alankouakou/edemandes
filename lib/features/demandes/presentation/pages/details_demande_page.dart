import 'package:demandes/core/themes/app_theme.dart';
import 'package:demandes/core/utils.dart';

import 'package:demandes/features/demandes/data/models/demande_model.dart';
import 'package:demandes/features/demandes/presentation/widgets/appbar_title.dart';
import 'package:demandes/features/demandes/presentation/widgets/display_field.dart';
import 'package:demandes/features/demandes/presentation/widgets/statut_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class DetailsDemandePage extends ConsumerWidget {
  final DemandeModel demande;
  const DetailsDemandePage({super.key, required this.demande});

  static Route route(DemandeModel demande) {
    return MaterialPageRoute(
        builder: (_) => DetailsDemandePage(demande: demande));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  const Text('Details Demande', style: AppTheme.pageTitleStyle),
                  const Gap(10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [StatutDemandeWidget(statut: demande.statut)]),
                  const Gap(10),
                  DisplayFieldWidget(
                    title: 'Objet de la demande',
                    text: demande.objet,
                  ),
                  const Gap(20),
                  DisplayFieldWidget(
                      title: 'Montant prévisionnel',
                      text: Utils.formatCFA(demande.montantPrevisionnel)),
                  const Gap(20),
                  DisplayFieldWidget(title: 'Demandeur:', text: demande.user),
                  const Gap(20),
                  DisplayFieldWidget(title: 'Service: ', text: demande.service),
                  const Gap(20),
                  DisplayFieldWidget(
                      title: 'Date de la demande:',
                      text: Utils.dateFull.format(demande.dateCreated)),
                  const Gap(20),
                ],
              )),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 15.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Fermer',
                            style: TextStyle(fontSize: 16))),
                    const Gap(20.0),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
