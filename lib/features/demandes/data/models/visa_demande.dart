import 'package:cloud_firestore/cloud_firestore.dart';

class VisaDemande {
  final String idDemande;
  final String role;
  final DateTime dateCreated;

  VisaDemande(
      {required this.idDemande, required this.role, required this.dateCreated});

  factory VisaDemande.fromFirestore(QueryDocumentSnapshot doc) {
    return VisaDemande(
        idDemande: doc['idDemande'],
        role: doc['role'],
        dateCreated: doc['dateCreated'].toDate());
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'idDemande': idDemande,
        'role': role,
        'dateCreated': dateCreated,
      };

  factory VisaDemande.fromMap(Map<String, dynamic> map) {
    return VisaDemande(
        idDemande: map['idDemande'],
        role: map['role'],
        dateCreated: map['dateCreated']);
  }

  Map<String, dynamic> toJson() =>
      {'idDemande': idDemande, 'role': role, 'dateCreated': dateCreated};

  VisaDemande copyWith(
      {String? idDemande, String? role, DateTime? dateCreated}) {
    return VisaDemande(
        idDemande: idDemande ?? this.idDemande,
        role: role ?? this.role,
        dateCreated: dateCreated ?? this.dateCreated);
  }
}
