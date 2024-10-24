import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = Provider<AuthService>((ref) => AuthService());

class AuthService {
  void createUserWithEmailAndPassword(
      {required String email, required String password}) async {}

  Future<void> signOut() async {
    //Utils.showSuccessMessage(message: 'Utilisateur déconnecté!');
  }

  Future<void> resetPassword(String email) async {}
}
