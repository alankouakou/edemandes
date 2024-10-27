import 'package:demandes/features/core/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final _auth = FirebaseAuth.instance;

  void createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on Exception catch (e) {
      Utils.showErrorMessage(message: e.toString());
    }
  }

  void signinWithEmailAndPassword(String email, String password) async {
    try {
      _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signOut() async {
    _auth.signOut();
    Utils.showSuccessMessage(message: 'Utilisateur déconnecté!');
  }

  Future<void> resetPassword(String email) async {}

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;
}
