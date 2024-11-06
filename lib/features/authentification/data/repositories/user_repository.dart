import 'package:demandes/features/authentification/data/datasources/user_datasource.dart';
import 'package:demandes/features/authentification/domain/models/user.dart';

abstract interface class UserRepository {
  Future<void> registerUser(
      {required String uid,
      required String email,
      required String nom,
      required String prenom,
      required String service,
      required String role});

  Future<void> updateRole(String docId, String role);
  Future<void> activateUser(String docId);
  Future<void> deactivateUser(String docId);
  Future<String> getUsername(String uid);
  Future<User> fetchUser(String uid);
}

class UserRepositoryImpl implements UserRepository {
  final UserDatasource userDatasource;
  const UserRepositoryImpl(this.userDatasource);
  @override
  Future<void> activateUser(String docId) async {
    // TODO: implement activateUser
  }

  @override
  Future<void> deactivateUser(String docId) async {
    // TODO: implement deactivateUser
  }

  @override
  Future<void> registerUser(
      {required String uid,
      required String email,
      required String nom,
      required String prenom,
      required String service,
      required String role}) async {
    await userDatasource.registerUser(
        uid: uid,
        email: email,
        nom: nom,
        prenom: prenom,
        service: service,
        role: role);
  }

  @override
  Future<void> updateRole(String docId, String role) async {
    await userDatasource.updateRole(docId, role);
    print('Role updated. New Role: $role');
  }

  Future<String> getUsername(String uid) async {
    print('User repository. getUsername. User uid: $uid');
    return await userDatasource.getUsername(uid);
  }

  @override
  Future<User> fetchUser(String uid) async {
    final result = await userDatasource.fetchUser(uid);
    return User.fromSnapshot(result);
  }
}
