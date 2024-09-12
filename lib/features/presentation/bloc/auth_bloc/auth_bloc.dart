import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:fork_and_fusion/core/services.dart/services.dart';
import 'package:fork_and_fusion/features/domain/usecase/Auth%20usecase/is_user_already_logged_in_usercase.dart';
import 'package:fork_and_fusion/features/domain/usecase/Auth%20usecase/save_log_in_status.dart';
import 'package:fork_and_fusion/features/domain/usecase/Auth%20usecase/sign_in_with_email.dart';
import 'package:fork_and_fusion/features/domain/usecase/Auth%20usecase/sign_in_with_google.dart';
import 'package:meta/meta.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthSignInWithGoogleEvent>(authSignInWithGoogleEvent);
    on<AuthSignInWithEmailEvent>(authSignInWithEmailEvent);
    on<AuthSignUpWithEmailEvent>(authSignUpWithEmailEvent);
    on<AuthAlreadyLoggedInCheckEvent>(authAlreadyLoggedInCheckEvent);
  }

  FutureOr<void> authSignInWithGoogleEvent(
      AuthSignInWithGoogleEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    SignInWithGoogle google = SignInWithGoogle(await Services.firebaseRepo());
    try {
      final user = await google.call();
      if (user != null) {
        IsUserAlreadyLoggedInUsercase instance =
            IsUserAlreadyLoggedInUsercase(await Services.sessionRepo());
        final isLoggedIn = await instance.call();
        if (!isLoggedIn) {
          SaveLogInStatusUseCase instance =
              SaveLogInStatusUseCase(await Services.sessionRepo());
          instance.call(SaveLogInParams(true, user.userId));
        }

        emit(AuthCompleatedState());
      } else {
        emit(AuthErrorState('Failed to login'));
      }
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  FutureOr<void> authSignInWithEmailEvent(
      AuthSignInWithEmailEvent event, Emitter<AuthState> emit) async {
    SignInWithEmail email = SignInWithEmail(await Services.firebaseRepo());
    try {
      var user = await email.call(event.email, event.password);
      emit(AuthCompleatedState());
      if (user != null) {
        log(user.email);
      }
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  FutureOr<void> authSignUpWithEmailEvent(
      AuthSignUpWithEmailEvent event, Emitter<AuthState> emit) {}

  FutureOr<void> authAlreadyLoggedInCheckEvent(
      AuthAlreadyLoggedInCheckEvent event, Emitter<AuthState> emit) async {
    IsUserAlreadyLoggedInUsercase instance =
        IsUserAlreadyLoggedInUsercase(await Services.sessionRepo());
    final check = await instance.call();
    await Future.delayed(const Duration(seconds: 2));
    if (check) {
      emit(AlreadyLoggedInState());
    } else {
      emit(InitialLoggingState());
    }
  }
}
