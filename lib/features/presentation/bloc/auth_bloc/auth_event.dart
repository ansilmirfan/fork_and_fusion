part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthSignInWithGoogleEvent extends AuthEvent {}

class AuthSignInWithEmailEvent extends AuthEvent {
  String email;
  String password;
  AuthSignInWithEmailEvent(this.email, this.password);
}

class AuthSignUpWithEmailEvent extends AuthEvent {
  String email;
  String password;
  AuthSignUpWithEmailEvent(this.email, this.password);
}

class AuthAlreadyLoggedInCheckEvent extends AuthEvent {}
