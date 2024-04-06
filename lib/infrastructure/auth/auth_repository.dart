import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  static Future<UserCredential> registerUser({
    required String username,
    required String email,
    required String password,
  }) async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.user?.uid)
        .set({
      'username': username,
      'email': user.user?.email,
      'id': user.user?.uid
    });
    return user;
  }

  static Future<UserCredential> loginUser({
    required String email,
    required String password,
  }) async {
    UserCredential user =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return user;
  }

  static Future<void> signOut() {
    var auth = FirebaseAuth.instance;
    return Future.wait([
      auth.signOut(),
    ]);
  }
}
