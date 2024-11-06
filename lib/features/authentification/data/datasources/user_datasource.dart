import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demandes/features/authentification/domain/models/user.dart';
import 'package:demandes/features/demandes/data/models/demande_model.dart';

class UserDatasource {
  final _usersCollection = FirebaseFirestore.instance.collection('users');

  Future<String> registerUser(
      {required String uid,
      required String email,
      required String nom,
      required String prenom,
      required String service,
      required String role}) async {
    final docId = await _usersCollection.add({
      'uid': uid,
      'email': email,
      'nom': nom,
      'prenom': prenom,
      'service': service,
      'role': role,
      'dateMaj': DateTime.now(),
      'dateExpiration': DateTime.now().add(const Duration(days: 30)),
    });

    print('User (docId: $docId) registered');
    return docId.id;
  }

  Future<String> getUsername(String uid) async {
    print('getUsername. User uid: $uid');
    return await _usersCollection.where('uid', isEqualTo: uid).get().then((value) =>
        '${value.docs.first.data()['prenom']} ${value.docs.first.data()['nom']}');
  }

  Future<QueryDocumentSnapshot> fetchUser(String uid) async {
    try {
      final result = await _usersCollection.where('uid', isEqualTo: uid).get();

      print('Role: ${result.docs.single.data()['role']}');
      return result.docs.single;
    } catch (e) {
      print('Uid: $uid - ${e.toString()}');
      rethrow;
    }
  }

  Future<void> updateRole(docId, role) async {
    await _usersCollection.doc(docId).update({'role': role});
  }
}
