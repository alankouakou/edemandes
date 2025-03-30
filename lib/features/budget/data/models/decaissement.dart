import 'package:cloud_firestore/cloud_firestore.dart';

class DecaissementModel {
  final String? id;
  final DateTime dateDecaissement;
  final double cumulDecaisse;
  final double montantDefinitif;
  final double montantPrevisionnel;
  final String objetDemande;
  final String? idDemande;
  final double solde;

  DecaissementModel({
    this.id,
    required this.dateDecaissement,
    required this.cumulDecaisse,
    required this.montantDefinitif,
    required this.montantPrevisionnel,
    required this.objetDemande,
    required this.idDemande,
    required this.solde,
  });

  Map<String, dynamic> toMap() {
    return {
      'dateDecaissement': dateDecaissement,
      'cumulDecaisse': cumulDecaisse,
      'montantDefinitif': montantDefinitif,
      'montantPrevisionnel': montantPrevisionnel,
      'objetDemande': objetDemande,
      'idDemande': idDemande,
      'solde': solde
    };
  }

  factory DecaissementModel.fromSnapshot(DocumentSnapshot doc) {
    return DecaissementModel(
        dateDecaissement: doc['dateDecaissement'].toDate(),
        cumulDecaisse: doc['cumulDecaisse'].toDouble(),
        montantDefinitif: doc['montantDefinitif'].toDouble(),
        montantPrevisionnel: doc['montantPrevisionnel'].toDouble(),
        objetDemande: doc['objetDemande'],
        idDemande: doc['idDemande'],
        solde: doc['solde'].toDouble());
  }
}
