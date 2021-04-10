import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthService {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  Future signInAnon() async {
    auth.UserCredential result = await _auth.signInAnonymously();
    auth.User user = result.user!;
    return user;
  }
}
