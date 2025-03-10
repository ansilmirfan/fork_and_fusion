// ignore_for_file: body_might_complete_normally_nullable

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fork_and_fusion/core/error/firebase_auth_exception.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireBaseAuthDataSource {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _firestore;

  FireBaseAuthDataSource(
      this._firebaseAuth, this._googleSignIn, this._firestore);

  // Google sign in
  Future<User?> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        return await _signInWithGoogleWeb();
      } else {
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
          final userDoc =
              await _firestore.collection('user').doc(user.uid).get();
          if (!userDoc.exists) {
            _createCredentials(user);
          }
        }
        return userCredential.user;
      }
    } on FirebaseAuthException catch (e) {
      throw FirebaseExceptions.handleAuthExceptions(e);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<User?> _signInWithGoogleWeb() async {
    try {
      final GoogleAuthProvider googleProvider = GoogleAuthProvider();
      final UserCredential userCredential =
          await _firebaseAuth.signInWithPopup(googleProvider);

      final User? user = userCredential.user;

      if (user != null) {
        final userDoc = await _firestore.collection('user').doc(user.uid).get();
        if (!userDoc.exists) {
          await _createCredentials(user);
        }
      }

      return user;
    } catch (e) {
      return null;
    }
  }

  // Email password sign in
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw FirebaseExceptions.handleAuthExceptions(e);
    } catch (e) {
      log('Error during sign-in: $e');
      throw Exception('An error occurred during sign-in.');
    }
  }

  // Email password sign up
  Future<User?> signUpWithEmail(
      String email, String password, String name) async {
    try {
      var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = userCredential.user;
      if (user != null) {
        _createCredentials(user);
      }
      return user;
    } on FirebaseAuthException catch (e) {
      throw FirebaseExceptions.handleAuthExceptions(e);
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

//--------------already logged in-------------
  bool alreadyLoggedIn() {
    final user = _firebaseAuth.currentUser;
    return user != null;
  }

  //--------------current user---------------
  Future<User?> currentUser() async {
    final user = _firebaseAuth.currentUser;
    return user;
  }

  //---------------forgot password------------
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      log('auth completed');
    } on FirebaseAuthException catch (e) {
      throw FirebaseExceptions.handleAuthExceptions(e);
    } catch (e) {
      log(e.toString());
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  Future<void> _createCredentials(User user) async {
    await _firestore.collection('user').doc(user.uid).set({
      'uid': user.uid,
      'email': user.email,
      'name': user.displayName,
      'image url': user.photoURL,
    });
    //--------creating cart--------
    await _firestore.collection('cart').doc(user.uid).set({'cart ids': []});
    //--------creating favourite--------
    await _firestore
        .collection('favourite')
        .doc(user.uid)
        .set({'favourite': []});
  }
}
