import 'package:cloud_firestore/cloud_firestore.dart';

import 'account.dart';

class User {
  final String username;
  final String email;
  final String role;
  final String service;
  final StatutUser statut;
  final DateTime dateExpiration;
  final DateTime dateMaj;

  const User(
      {required this.username,
      required this.email,
      required this.role,
      required this.service,
      required this.statut,
      required this.dateExpiration,
      required this.dateMaj});

  factory User.fromSnapshot(QueryDocumentSnapshot doc) {
    return User(
      username: doc['prenom'] + " " + doc['nom'],
      email: doc['email'],
      role: doc['role'],
      service: doc['service'],
      statut: StatutUser.actif,
      dateExpiration: doc['dateExpiration'].toDate(),
      dateMaj: doc['dateMaj'].toDate(),
    );
  }

  User copyWith(
      {String? username,
      String? email,
      String? password,
      String? role,
      String? service,
      StatutUser? statut,
      DateTime? dateExpiration,
      DateTime? dateMaj}) {
    return User(
        username: username ?? this.username,
        email: email ?? this.email,
        role: role ?? this.role,
        service: service ?? this.service,
        statut: statut ?? this.statut,
        dateExpiration: dateExpiration ?? this.dateExpiration,
        dateMaj: dateMaj ?? this.dateMaj);
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'role': role,
      'service': service,
      'statut': statut,
      'dateExpiration': dateExpiration
    };
  }
}

enum StatutUser {
  nouveau(value: 'Créé'),
  actif(value: 'Actif'),
  suspendu(value: 'Suspendu'),
  expire(value: 'Mot de passe expiré'),
  desactive(value: 'Désactivé');

  const StatutUser({required this.value});
  final String value;
}
