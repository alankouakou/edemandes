import 'package:demandes/features/authentification/domain/models/service.dart';
import 'package:demandes/features/authentification/domain/models/user.dart';

class Demande {
  final int id;
  final String objet;
  final double montantPrevisionnel;
  final String montantDefinitif;
  final DateTime dateMaj;
  final String statut;
  final User user;
  final Service service;

  Demande(
      {required this.id,
      required this.objet,
      required this.montantPrevisionnel,
      required this.montantDefinitif,
      required this.dateMaj,
      required this.statut,
      required this.user,
      required this.service});
}
