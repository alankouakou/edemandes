import 'package:flutter/material.dart';
import 'package:demandes/core/statuts.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class StatutDemandeWidget extends StatelessWidget {
  final int statut;
  const StatutDemandeWidget({super.key, required this.statut});

  @override
  Widget build(BuildContext context) {
    return Container(
        // width: 150,
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        decoration: BoxDecoration(
            border: const Border.fromBorderSide(BorderSide.none),
            borderRadius: BorderRadius.circular(2.0),
            color: Statut.couleur(statut).withOpacity(0.1)),
        child: Center(
          child: Text(Statut.libelle(statut),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Statut.couleur(statut),
              )),
        ));
  }
}
