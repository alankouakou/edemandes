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
        2 => Colors.orange,
        3 => Colors.purple,
        4 => Colors.green,
        5 => Colors.red,
        6 => Colors.grey,
        _ => Colors.grey
      };

  static int accept(statutActuel) {
    return switch (statutActuel) {
      Statut.pendingVisaManager => Statut.pendingVisaRAF,
      Statut.pendingVisaRAF => Statut.pendingVisaCoordonnateur,
      Statut.pendingVisaCoordonnateur => Statut.approved,
      Statut.approved => Statut.paid,
      _ => statutActuel
    };
  }

  static int reject() {
    return Statut.rejected;
  }

  static int StatutPendingfromRole(String role) => switch (role) {
        'CHEF_SERVICE' => Statut.pendingVisaManager,
        'RAF' => Statut.pendingVisaRAF,
        'COORDONNATEUR' => Statut.pendingVisaCoordonnateur,
        _ => 0
      };

  static bool locked(String role, int statut) {
    return switch (role) {
      'CHEF_SERVICE' => statut != Statut.pendingVisaManager,
      'RAF' =>
        ![Statut.pendingVisaManager, Statut.pendingVisaRAF].contains(statut),
      'COORDONNATEUR' => statut != Statut.pendingVisaCoordonnateur,
      'COMPTABLE' =>
        ![Statut.pendingVisaManager, Statut.approved].contains(statut),
      'USER' => statut != Statut.created,
      _ => statut != Statut.created
    };
  }

  static const int pendingVisaManager = 1;
  static const int pendingVisaRAF = 2;
  static const int pendingVisaCoordonnateur = 3;

  static const int created = 1;
  static const int approved = 4;
  static const int rejected = 5;
  static const int paid = 6;
}
