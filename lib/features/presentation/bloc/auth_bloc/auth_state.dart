part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthCompleatedState extends AuthState {}

class AuthErrorState extends AuthState {
  String message;
  AuthErrorState(this.message);
}

class AlreadyLoggedInState extends AuthState {}

class InitialLoggingState extends AuthState {}