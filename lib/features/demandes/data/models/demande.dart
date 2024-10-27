// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Demande {
  final String docId;
  final String id;
  final String objet;
  final double montantPrevisionnel;
  final double montantDepense;
  final DateTime dateCreated;
  final DateTime dateUpdated;

  Demande({
    required this.docId,
    required this.id,
    required this.objet,
    required this.montantPrevisionnel,
    required this.montantDepense,
    required this.dateCreated,
    required this.dateUpdated,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docId': docId,
      'id': id,
      'objet': objet,
      'montantPrevisionnel': montantPrevisionnel,
      'montantDepense': montantDepense,
      'dateCreated': dateCreated.millisecondsSinceEpoch,
      'dateUpdated': dateUpdated.millisecondsSinceEpoch,
    };
  }

  factory Demande.fromMap(Map<String, dynamic> map) {
    return Demande(
      docId: map['docId'] as String,
      id: map['id'] as String,
      objet: map['objet'] as String,
      montantPrevisionnel: map['montantPrevisionnel'] as double,
      montantDepense: map['montantDepense'] as double,
      dateCreated:
          DateTime.fromMillisecondsSinceEpoch(map['dateCreated'] as int),
      dateUpdated:
          DateTime.fromMillisecondsSinceEpoch(map['dateUpdated'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Demande.fromJson(String source) =>
      Demande.fromMap(json.decode(source) as Map<String, dynamic>);
}
