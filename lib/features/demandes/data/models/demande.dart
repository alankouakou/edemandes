// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Demande {
  final String? docId;
  final String objet;
  final double montantPrevisionnel;
  final double montantDefinitif;
  final String service;
  final String user;
  final int statut;
  final DateTime dateCreated;
  final DateTime dateUpdated;

  Demande({
    this.docId,
    required this.objet,
    required this.montantPrevisionnel,
    required this.montantDefinitif,
    required this.service,
    required this.user,
    required this.statut,
    required this.dateCreated,
    required this.dateUpdated,
  });

  factory Demande.fromSnapshot(QueryDocumentSnapshot doc) {
    return Demande(
        docId: doc.id,
        objet: doc['objet'],
        montantDefinitif: doc['montant_definitif'],
        montantPrevisionnel: doc['montant_previsionnel'],
        service: doc['service'],
        user: doc['user'],
        statut: doc['statut'],
        dateCreated: DateTime.now(),
        dateUpdated: DateTime.now());
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docId': docId,
      'objet': objet,
      'montant_previsionnel': montantPrevisionnel,
      'montant_definitif': montantDefinitif,
      'service': service,
      'user': user,
      'statut': statut,
      'date_created': dateCreated.millisecondsSinceEpoch,
      'date_updated': dateUpdated.millisecondsSinceEpoch,
    };
  }

  factory Demande.fromMap(Map<String, dynamic> map) {
    return Demande(
      docId: map['docId'] != null ? map['docId'] as String : null,
      objet: map['objet'] as String,
      montantPrevisionnel: map['montant_previsionnel'] as double,
      montantDefinitif: map['montant_depense'] as double,
      service: map['service'] as String,
      user: map['user'],
      statut: map['statut'],
      dateCreated:
          DateTime.fromMillisecondsSinceEpoch(map['date_created'] as int),
      dateUpdated:
          DateTime.fromMillisecondsSinceEpoch(map['date_updated'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Demande.fromJson(String source) =>
      Demande.fromMap(json.decode(source) as Map<String, dynamic>);

  Demande copyWith({
    String? docId,
    String? objet,
    double? montantPrevisionnel,
    double? montantDefinitif,
    String? service,
    String? user,
    int? statut,
    DateTime? dateCreated,
    DateTime? dateUpdated,
  }) {
    return Demande(
      docId: docId ?? this.docId,
      objet: objet ?? this.objet,
      montantPrevisionnel: montantPrevisionnel ?? this.montantPrevisionnel,
      montantDefinitif: montantDefinitif ?? this.montantDefinitif,
      service: service ?? this.service,
      user: user ?? this.user,
      statut: statut ?? this.statut,
      dateCreated: dateCreated ?? this.dateCreated,
      dateUpdated: dateUpdated ?? this.dateUpdated,
    );
  }
}
