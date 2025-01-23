import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel {
  final String id;
  final String libelle;

  const ServiceModel({
    required this.id,
    required this.libelle,
  });

  factory ServiceModel.fromFirestore(DocumentSnapshot doc) {
    return ServiceModel(
      id: doc['id'],
      libelle: doc['libelle'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'libelle': libelle,
    };
  }
}
