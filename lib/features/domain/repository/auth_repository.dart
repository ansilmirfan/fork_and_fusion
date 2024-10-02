import 'package:fork_and_fusion/features/domain/entity/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> signInWithGoogle();
  Future<UserEntity?> signInWithEmail(String email, String password);
  Future<UserEntity?> signUpWithEmail(
      String email, String password, String name);
  bool alreadyLoggedIn();
  Future<UserEntity?> currentUser();
  Future<void> resetPassword(String email);
  Future<void> signOut();
}
