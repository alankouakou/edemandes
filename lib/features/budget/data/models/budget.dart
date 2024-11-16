import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Budget extends Equatable {
  final String? id;
  final String exercice;
  final double solde;
  final double cumulDecaisse;
  final bool actif;
  final DateTime dateCreated;

  Budget(
      {this.id,
      required this.exercice,
      required this.solde,
      required this.cumulDecaisse,
      required this.actif,
      required this.dateCreated});

  factory Budget.fromSnapshot(DocumentSnapshot doc) {
    return Budget(
        id: doc.id,
        exercice: doc['exercice'],
        solde: doc['solde'],
        cumulDecaisse: doc['cumul_decaisse'],
        actif: doc['actif'],
        dateCreated: doc['date_created'].toDate());
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'exercice': exercice,
      'solde': solde,
      'cumul_decaisse': cumulDecaisse,
      'actif': actif,
      'date_created': dateCreated,
    };
  }

  Budget copyWith({
    String? id,
    String? exercice,
    double? solde,
    double? cumulDecaisse,
    bool? actif,
    DateTime? dateCreated,
  }) {
    return Budget(
      id: id ?? this.id,
      exercice: exercice ?? this.exercice,
      solde: solde ?? this.solde,
      cumulDecaisse: cumulDecaisse ?? this.cumulDecaisse,
      actif: actif ?? this.actif,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [solde, actif, dateCreated];
}
