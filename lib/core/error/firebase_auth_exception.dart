import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthExceptions {
  static handleExceptions(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        throw Exception(
            'Your password is too weak. Please choose a stronger one.');
      case 'email-already-in-use':
        throw Exception(
            'An account with this email already exists. Please use a different email or sign in.');
      case 'user-not-found':
        throw Exception(
            'No account found with this email. Please check your email or sign up.');
      case 'wrong-password':
        throw Exception('Incorrect password. Please try again.');
      case 'invalid-email':
        throw Exception(
            'The email address you entered is invalid. Please check and try again.');
      case 'invalid-credential':
        throw Exception(
            'There was an issue with your login details. Please try again.');
      case 'user-disabled':
        throw Exception(
            'This account has been disabled. Please contact support.');
      case 'operation-not-allowed':
        throw Exception(
            'Email and password login is currently disabled. Please contact support.');
      default:
        throw Exception(
            'An unexpected error occurred: ${e.message}. Please try again.');
    }
  }
}
