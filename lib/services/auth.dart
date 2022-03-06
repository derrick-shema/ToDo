import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  static final _auth = FirebaseAuth.instance;

  static Future<String?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      // TODO use _auth to create an account
      final userCredential = _auth
          .signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return _parseSignInAuthException(e);
    }
  }

  static Future<String?> createAccountWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      // TODO use _auth to create an account
      final userCredential = _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return _parseCreateAccountAuthException(e);
    }
  }

  static String? getUserId() {
    // TODO
    final user = _auth.currentUser;
    if (user == null) return null;
    return user.uid;
  }

  static bool isSignedIn() {
    // TODO
    return false;
  }

  static void signOut() {
    // TODO
    _auth
        .signOut();
  }

  static String _parseSignInAuthException(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'invalid-email':
        return 'Email address is not formatted correctly';
      case 'user-not-found':
      case 'wrong-password':
      case 'user-disabled':
        print('this should be hit');
        return 'Invalid username or password';
      case 'too-many-requests':
      case 'operation-not-allowed':
      default:
        return 'An unknown error occurred';
    }
  }

  static String _parseCreateAccountAuthException(
      FirebaseAuthException exception) {
    switch (exception.code) {
      case 'weak-password':
        return 'Password is too weak';
      case 'invalid-email':
        return 'Email address is not formatted correctly';
      case 'email-already-in-use':
        return 'This email address already exists';
      default:
        return 'An unknown error occurred';
    }
  }
}
