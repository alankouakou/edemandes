import 'package:flutter/material.dart';

class Statut {
  static String libelle(int code) => switch (code) {
        1 => 'Initiée',
        2 => 'Visa Chef Service',
        3 => 'Visa RAF',
        4 => 'Visa Coordonnateur',
        5 => 'Rejetée',
        6 => 'Décaissé',
        _ => 'Inconnu'
      };

  static Color couleur(int code) => switch (code) {
        1 => Colors.blue,
        2 => Colors.purple,
        3 => Colors.orange,
        4 => Colors.green,
        5 => Colors.red,
        6 => Colors.grey,
        _ => Colors.grey
      };

  static int StatutPendingfromRole(String role) => switch (role) {
        'chef_service' => Statut.pendingVisaManager,
        'raf' => Statut.pendingVisaRAF,
        'coordonnateur' => Statut.pendingVisaCoordonnateur,
        _ => 0
      };

  static const int pendingVisaManager = 1;
  static const int pendingVisaRAF = 2;
  static const int pendingVisaCoordonnateur = 3;

  static const int approved = 4;
  static const int rejected = 5;
  static const int paid = 6;
}
