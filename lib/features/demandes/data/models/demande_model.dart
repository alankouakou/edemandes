// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demandes/features/demandes/domain/entities/demande.dart';

class DemandeModel {
  final String? docId;
  final String objet;
  final double montantPrevisionnel;
  final double montantDefinitif;
  final String service;
  final String user;
  final String userUid;
  final int statut;
  final DateTime dateCreated;
  final DateTime dateUpdated;

  DemandeModel({
    this.docId,
    required this.objet,
    required this.montantPrevisionnel,
    required this.montantDefinitif,
    required this.service,
    required this.user,
    required this.userUid,
    required this.statut,
    required this.dateCreated,
    required this.dateUpdated,
  });

  Demande toEntity() => Demande(
      docId: docId,
      objet: objet,
      montantPrevisionnel: montantPrevisionnel,
      montantDefinitif: montantDefinitif,
      service: service,
      user: user,
      userUid: userUid,
      statut: statut,
      dateCreated: dateCreated,
      dateUpdated: dateUpdated);

  factory DemandeModel.fromSnapshot(QueryDocumentSnapshot doc) {
    return DemandeModel(
        docId: doc.id,
        objet: doc['objet'],
        montantDefinitif: doc['montant_definitif'],
        montantPrevisionnel: doc['montant_previsionnel'],
        service: doc['service'],
        user: doc['user'],
        userUid: doc['userUid'],
        statut: doc['statut'],
        dateCreated: doc['date_created'].toDate(),
        dateUpdated: doc['date_updated'].toDate());
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'objet': objet,
      'montant_previsionnel': montantPrevisionnel,
      'montant_definitif': montantDefinitif,
      'service': service,
      'user': user,
      'userUid': userUid,
      'statut': statut,
      'date_created': dateCreated,
      'date_updated': dateUpdated,
    };
  }

  factory DemandeModel.fromMap(Map<String, dynamic> map) {
    return DemandeModel(
        docId: map['docId'] != null ? map['docId'] as String : null,
        objet: map['objet'] as String,
        montantPrevisionnel: map['montant_previsionnel'] as double,
        montantDefinitif: map['montant_depense'] as double,
        service: map['service'] as String,
        user: map['user'],
        userUid: map['userUid'],
        statut: map['statut'],
        dateCreated: map['date_created'],
        dateUpdated: map['date_updated']);
  }

  String toJson() => json.encode(toMap());

  factory DemandeModel.fromJson(String source) =>
      DemandeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  DemandeModel copyWith({
    String? docId,
    String? objet,
    double? montantPrevisionnel,
    double? montantDefinitif,
    String? service,
    String? user,
    String? userUid,
    int? statut,
    DateTime? dateCreated,
    DateTime? dateUpdated,
  }) {
    return DemandeModel(
      docId: docId ?? this.docId,
      objet: objet ?? this.objet,
      montantPrevisionnel: montantPrevisionnel ?? this.montantPrevisionnel,
      montantDefinitif: montantDefinitif ?? this.montantDefinitif,
      service: service ?? this.service,
      user: user ?? this.user,
      userUid: user ?? this.userUid,
      statut: statut ?? this.statut,
      dateCreated: dateCreated ?? this.dateCreated,
      dateUpdated: dateUpdated ?? this.dateUpdated,
    );
  }
}
