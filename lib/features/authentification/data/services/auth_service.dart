import 'package:demandes/core/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

final authProvider = Provider<AuthService>((ref) => AuthService());

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  void signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final userCredentials = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredentials.user != null) {
        Utils.showSuccessMessage(message: 'Utilisateur connecté!');
      }
    } on FirebaseAuthException catch (e) {
      Utils.showErrorMessage(message: e.message!);
    }
  }

  void createUserWithEmailAndPassword(
      {required String email, required String password}) async {}

  Future<void> signOut() async {
    auth.signOut();
    //Utils.showSuccessMessage(message: 'Utilisateur déconnecté!');
  }

  Future<void> resetPassword(String email) async {
    auth.sendPasswordResetEmail(email: email);
  }

  Stream<User?> get authStateChanges {
    return auth.authStateChanges();
  }

  User? currentUser() {
    return auth.currentUser;
  }

  String email() {
    return auth.currentUser!.email!;
  }
}
