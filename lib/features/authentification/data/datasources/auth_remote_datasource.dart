import 'package:demandes/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDatasource {
  Future<String> loginWithEmailAndPassword(
      {required String email, required String password});
  Future<String> signUpWithEmailAndPassword(
      {required String name, required String email, required String password});
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final SupabaseClient supabaseClient;

  const AuthRemoteDatasourceImpl(this.supabaseClient);
  @override
  Future<String> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    final response = await supabaseClient.auth
        .signInWithPassword(email: email, password: password);
    return response.user!.id;
  }

  @override
  Future<String> signUpWithEmailAndPassword(
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
      return authResponse.user!.id;
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
