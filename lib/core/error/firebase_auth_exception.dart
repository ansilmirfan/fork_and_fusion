import 'package:firebase_auth/firebase_auth.dart';

class FirebaseExceptions {
  static String handleAuthExceptions(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'Your password is too weak. Please choose a stronger one.';
      case 'email-already-in-use':
        return 'An account with this email already exists. Please use a different email or sign in.';
      case 'user-not-found':
        return 'No account found with this email. Please check your email';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-email':
        return 'The email address you entered is invalid. Please check and try again.';
      case 'invalid-credential':
        return 'There was an issue with your login details. Please try again.';
      case 'user-disabled':
        return 'This account has been disabled. Please contact support.';
      case 'operation-not-allowed':
        return 'Email and password login is currently disabled. Please contact support.';
      case 'network-request-failed':
        return 'A network error occurred. Please check your internet connection and try again.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      default:
        return 'An unexpected error occurred: ${e.message}. Please try again.';
    }
  }

  static String handleFirebaseExceptions(FirebaseException e) {
    switch (e.code) {
      case 'permission-denied':
        return 'Access Denied: You do not have the required permissions to perform this action. Please contact support if you believe this is an error.';

      case 'not-found':
        return 'Data Not Found: The requested resource could not be located. Ensure the item exists before attempting to access it.';

      case 'already-exists':
        return 'Duplicate Entry: The resource you are trying to add already exists. Please verify the details or update the existing entry.';

      case 'unavailable':
        return 'Service Unavailable: The server is currently unreachable. Please try again later or check the service status.';

      default:
        return 'Unexpected Error: An unknown error occurred. Please try again or contact support if the problem persists.';
    }
  }
}
