import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fork_and_fusion/core/services.dart/services.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/domain/entity/user_entity.dart';
import 'package:fork_and_fusion/features/domain/usecase/Auth%20usecase/already_logged_in_usecase.dart';
import 'package:fork_and_fusion/features/domain/usecase/Auth%20usecase/sign_in_with_email.dart';
import 'package:fork_and_fusion/features/domain/usecase/Auth%20usecase/sign_in_with_google.dart';
import 'package:fork_and_fusion/features/domain/usecase/Auth%20usecase/sign_up_with_email.dart';
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
  //---------------google sign in---------------
  FutureOr<void> authSignInWithGoogleEvent(
      AuthSignInWithGoogleEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    SignInWithGoogle google = SignInWithGoogle(await Services.firebaseRepo());
    try {
      final user = await google.call();
      if (user != null) {
        Constants.user = user;
        emit(AuthCompleatedState(user));
      } else {
        emit(AuthErrorState('Failed to login'));
      }
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

//----------------email sign in-----------------
  FutureOr<void> authSignInWithEmailEvent(
      AuthSignInWithEmailEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    SignInWithEmail email = SignInWithEmail(await Services.firebaseRepo());
    try {
      var user = await email.call(event.email, event.password);

      if (user != null) {
        Constants.user = user;
        emit(AuthCompleatedState(user));
      } else {
        emit(AuthErrorState('Something went wrong'));
      }
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

// ------------already logged in----------
  FutureOr<void> authSignUpWithEmailEvent(
      AuthSignUpWithEmailEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      SignUpWithEmail email = SignUpWithEmail(await Services.firebaseRepo());
      final user = await email.call(event.email, event.password, event.name);
      if (user != null) {
        emit(AuthCompleatedState(user));
      } else {
        emit(AuthErrorState('Failed to login'));
      }
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  FutureOr<void> authAlreadyLoggedInCheckEvent(
      AuthAlreadyLoggedInCheckEvent event, Emitter<AuthState> emit) async {
    await Future.delayed(const Duration(seconds: 2));
    AlreadyLoggedInUsecase useCase =
        AlreadyLoggedInUsecase(await Services.firebaseRepo());
    bool check = useCase.call();
    if (check) {
      emit(AlreadyLoggedInState());
    } else {
      emit(InitialLoggingState());
    }
  }
}
