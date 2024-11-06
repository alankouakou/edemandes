import 'package:flutter/material.dart';
import 'package:demandes/core/statuts.dart';

class StatutDemandeWidget extends StatelessWidget {
  final int statut;
  const StatutDemandeWidget({super.key, required this.statut});

  @override
  Widget build(BuildContext context) {
    return Container(
        // width: 150,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Statut.couleur(statut)),
        child: Center(
          child: Text(Statut.libelle(statut),
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ));
  }
}
