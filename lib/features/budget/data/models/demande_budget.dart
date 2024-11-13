import 'package:cloud_firestore/cloud_firestore.dart';

class DemandeBudget {
  final String? id;
  final String idDemande;
  final double montant;
  final DateTime dateCreated;
  final DateTime dateUpdated;
  final String? memo;
  final int statut;

  DemandeBudget(
      {this.id,
      required this.idDemande,
      required this.montant,
      required this.dateCreated,
      required this.dateUpdated,
      required this.memo,
      required this.statut});

  factory DemandeBudget.fromFirestore(QueryDocumentSnapshot doc) {
    return DemandeBudget(
      id: doc.id,
      idDemande: doc['idDemande'],
      montant: doc['montant'],
      dateCreated: doc['dateCreated'].toDate(),
      dateUpdated: doc['dateUpdated'].toDate(),
      memo: doc['memo'],
      statut: doc['statut'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idDemande': idDemande,
      'montant': montant,
      'dateCreated': dateCreated,
      'dateUpdated': dateUpdated,
      'memo': memo,
      'statut': statut
    };
  }

  DemandeBudget copyWith({
    String? id,
    String? idDemande,
    double? montant,
    DateTime? dateCreated,
    DateTime? dateUpdated,
    String? memo,
    int? statut,
  }) {
    print('copyWith statut: $statut , docId: $id');
    return DemandeBudget(
      id: id ?? this.id,
      idDemande: idDemande ?? this.idDemande,
      montant: montant ?? this.montant,
      dateCreated: dateCreated ?? this.dateCreated,
      dateUpdated: dateCreated ?? this.dateUpdated,
      memo: memo ?? this.memo,
      statut: statut ?? this.statut,
    );
  }
}
