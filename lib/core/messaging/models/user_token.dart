import 'package:cloud_firestore/cloud_firestore.dart';

class UserToken {
  final String userid;
  final String token;
  final String service;

  UserToken({required this.userid, required this.token, required this.service});

  factory UserToken.fromFirestore(QueryDocumentSnapshot doc) {
    return UserToken(
      userid: doc['userid'],
      token: doc['token'],
      service: doc['service'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userid': userid,
      'token': token,
      'service': service,
    };
  }
}
