import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Budget extends Equatable {
  final String? id;
  final String exercice;
  final double soldeTheorique;
  final double soldeReel;
  final double cumulDecaisse;
  final bool actif;
  final DateTime dateCreated;

  Budget(
      {this.id,
      required this.exercice,
      required this.soldeTheorique,
      required this.soldeReel,
      required this.cumulDecaisse,
      required this.actif,
      required this.dateCreated});

  factory Budget.fromSnapshot(DocumentSnapshot doc) {
    return Budget(
        id: doc.id,
        exercice: doc['exercice'],
        soldeReel: doc['solde_reel'],
        soldeTheorique: doc['solde_theorique'],
        cumulDecaisse: doc['cumul_decaisse'],
        actif: doc['actif'],
        dateCreated: doc['date_created'].toDate());
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'exercice': exercice,
      'solde_theorique': soldeTheorique,
      'solde_reel': soldeReel,
      'cumul_decaisse': cumulDecaisse,
      'actif': actif,
      'date_created': dateCreated,
    };
  }

  Budget copyWith({
    String? id,
    String? exercice,
    double? soldeReel,
    double? soldeTheorique,
    double? cumulDecaisse,
    bool? actif,
    DateTime? dateCreated,
  }) {
    return Budget(
      id: id ?? this.id,
      exercice: exercice ?? this.exercice,
      soldeTheorique: soldeTheorique ?? this.soldeTheorique,
      soldeReel: soldeReel ?? this.soldeReel,
      cumulDecaisse: cumulDecaisse ?? this.cumulDecaisse,
      actif: actif ?? this.actif,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [soldeTheorique, soldeReel, actif, dateCreated];
}
