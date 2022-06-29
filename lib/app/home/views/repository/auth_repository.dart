import 'package:firebase_auth/firebase_auth.dart';

class AutRepository {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  get dataAuth => _auth.authStateChanges();
  Future<User?> getDataUser(String email, String password) async {
    UserCredential _user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    var userData = _user.user;
    return userData;
  }
}
