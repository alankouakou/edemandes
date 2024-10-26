import 'package:equatable/equatable.dart';

import 'service.dart';

class User extends Equatable {
  final String username;
  final String email;
  final String password;
  final String role;
  final Service service;
  final StatutUser statut;
  final DateTime dateExpiration;
  final DateTime dateMaj;

  const User(
      {required this.username,
      required this.email,
      required this.password,
      required this.role,
      required this.service,
      required this.statut,
      required this.dateExpiration,
      required this.dateMaj});

  User copyWith(
      {String? username,
      String? email,
      String? password,
      String? role,
      Service? service,
      StatutUser? statut,
      DateTime? dateExpiration,
      DateTime? dateMaj}) {
    return User(
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
        role: role ?? this.role,
        service: service ?? this.service,
        statut: statut ?? this.statut,
        dateExpiration: dateExpiration ?? this.dateExpiration,
        dateMaj: dateMaj ?? this.dateMaj);
  }

  @override
  List<Object?> get props => [email, password];

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
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
