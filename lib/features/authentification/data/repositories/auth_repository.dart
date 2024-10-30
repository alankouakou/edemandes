import 'package:demandes/core/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  Future<User?> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    String message = '';
    try {
      final credentials = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = credentials.user;
      if (user != null) {
        return user;
      }
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        message = 'Password de 6 caractères minimum!';
      } else {
        message = 'code:${e.code}, msg: ${e.toString()}';
      }
      print(message);
      Utils.showErrorMessage(message: message);
    }

    return null;
  }

  Future<User?> signinWithEmailAndPassword(
      {required String email, required String password}) async {
    String message = '';
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      var user = credential.user;

      if (user != null) {
        return user;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email' ||
          e.code == 'invalid-credential' ||
          e.code == 'wrong-password') {
        message = 'Verifiez e-mail ou mot de passe';
      } else if (e.code == 'user-disabled') {
        message = 'Votre compte est Inactif';
      } else if (e.code == 'network-request-failed') {
        message = 'Verifiez la connexion Internet!';
      } else {
        message = e.code;
      }
      Utils.showErrorMessage(message: message);
    }

    return null;
  }

  Future<void> signOut() async {
    _auth.signOut();
    Utils.showSuccessMessage(message: 'Utilisateur déconnecté!');
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
    Utils.showSuccessMessage(message: 'E-mail envoyé!');
  }
}
