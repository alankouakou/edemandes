import 'package:demandes/core/error/exceptions.dart';
import 'package:demandes/features/authentification/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDatasource {
  Future<UserModel> loginWithEmailAndPassword(
      {required String email, required String password});
  Future<UserModel> signUpWithEmailAndPassword(
      {required String name, required String email, required String password});
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final SupabaseClient supabaseClient;

  const AuthRemoteDatasourceImpl(this.supabaseClient);
  @override
  Future<UserModel> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final response = await supabaseClient.auth
          .signInWithPassword(email: email, password: password);
      if (response.user == null) {
        throw const ServerException(message: 'User is null');
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final authResponse = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {'name': name},
      );

      if (authResponse.user == null) {
        throw const ServerException(message: 'User is null');
      }
      return UserModel.fromJson(authResponse.user!.toJson());
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
