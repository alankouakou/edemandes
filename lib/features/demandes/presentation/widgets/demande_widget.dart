import 'package:demandes/core/statuts.dart';
import 'package:demandes/core/utils.dart';
import 'package:demandes/features/demandes/data/models/demande_model.dart';
import 'package:demandes/features/demandes/presentation/pages/validation_page.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DemandeWidget extends StatelessWidget {
  final DemandeModel demande;
  final VoidCallback? onLongPress;
  final VoidCallback onTap;
  const DemandeWidget(
      {super.key,
      required this.demande,
      required this.onTap,
      this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
            child: Row(
              children: [
                Container(
                  width: 8,
                  decoration: BoxDecoration(
                      color: Statut.couleur(demande.statut),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0))),
                ),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      ListTile(
                          title: Text(
                            demande.objet,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                              Utils.formatCFA(demande.montantPrevisionnel),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: Icon(Icons.circle,
                              color: Statut.couleur(demande.statut))),
                      Padding(
                          padding:
                              const EdgeInsets.only(right: 20.0, left: 20.0),
                          //child: Divider(),
                          child: Container(
                              height: 2.0,
                              width: double.infinity,
                              color: Colors.grey.shade300)),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(demande.service),
                            Text(Statut.libelle(demande.statut),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Statut.couleur(demande.statut))),
                          ],
                        ),
                      )
                    ]))
              ],
            )),
      ),
    );
  }
}
