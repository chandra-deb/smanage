import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInAnon() async {
    print(await _auth.signInAnonymously());
  }

  Future<dynamic> signInUsingEmailAndPass(String email, String password) async {
    try {
      return await _auth
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => value.user);
    } on Exception catch (e) {
      return e;
    }
  }

  Future<dynamic> createUser({
    String name,
    String email,
    String password,
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await credential.user.updateProfile(displayName: name);
      return credential;
    } on Exception catch (e) {
      return e;
    }
  }

  void signOut() {
    _auth.signOut();
  }

  Stream<User> authStatus() {
    return _auth.authStateChanges();
  }

  String get teacherUID => _auth.currentUser.uid;
  String get name => _auth.currentUser.displayName;
}
