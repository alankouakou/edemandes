import 'package:demandes/core/utils.dart';
import 'package:demandes/features/demandes/data/models/demande.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DemandeWidget extends StatelessWidget {
  final Demande demande;
  const DemandeWidget({super.key, required this.demande});

  @override
  Widget build(BuildContext context) {
    final color = switch (demande.statut) {
      1 => Colors.blue,
      2 => Colors.orange,
      3 => Colors.red,
      4 => Colors.green,
      _ => Colors.grey
    };

    final statut = switch (demande.statut) {
      1 => 'Nouveau',
      2 => 'En cours',
      3 => 'Rejeté',
      4 => 'Approuvé',
      _ => 'Décaissé'
    };

    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            width: double.infinity,
            height: 130,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Container(
                  width: 12,
                  decoration: BoxDecoration(
                      color: color,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12))),
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
                          trailing: Icon(Icons.circle, color: color)),
                      const Padding(
                        padding: EdgeInsets.only(right: 20.0, left: 20.0),
                        child: Divider(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(demande.service),
                            Text(statut,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, color: color)),
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
