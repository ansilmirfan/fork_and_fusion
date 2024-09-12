import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireBaseAuthDataSource {
  final FirebaseAuth _firebaseAuth;

  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _firestore;

  FireBaseAuthDataSource(
      this._firebaseAuth, this._googleSignIn, this._firestore);

  // Google sign in
  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      return null;
    }
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    final UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);
    final user = userCredential.user;
    //if user does not exist add that
    if (user != null) {
      final userDoc = await _firestore.collection('user').doc(user.uid).get();
      if (!userDoc.exists) {
        await _firestore.collection('user').doc(user.uid).set({
          'uid': user.uid,
          'email': user.email,
          'name': user.displayName,
          'image url': user.photoURL,
        });
      }
    }

    return userCredential.user;
  }

  // Email password sign in
  Future<User?> signInWithEmail(String email, String password) async {
    final UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  // Email password sign up
  Future<User?> signUpWithEmail(String email, String password) async {
    final UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  // Sign out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
