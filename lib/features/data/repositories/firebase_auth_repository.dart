import 'package:fork_and_fusion/features/data/data_source/firebase/firebase_authentication.dart';
import 'package:fork_and_fusion/features/data/model/user_model.dart';
import 'package:fork_and_fusion/features/domain/entity/user_entity.dart';
import 'package:fork_and_fusion/features/domain/repository/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  FireBaseAuthDataSource dataSource;
  FirebaseAuthRepository(this.dataSource);
  @override
  Future<UserEntity?> signInWithGoogle() async {
    final user = await dataSource.signInWithGoogle();
    if (user != null) {
      return UserModel.fromFireBaseUser(user);
    }
    return null;
  }

  @override
  Future<UserEntity?> signInWithEmail(String email, String password) async {
    final user = await dataSource.signInWithEmail(email, password);
    if (user != null) {
      return UserModel.fromFireBaseUser(user);
    }
    return null;
  }

  @override
  Future<UserEntity?> signUpWithEmail(
      String email, String password, String name) async {
    final user = await dataSource.signUpWithEmail(email, password, name);
    if (user != null) {
      return UserModel.fromFireBaseUser(user);
    }
    return null;
  }

  @override
  bool alreadyLoggedIn() {
    return dataSource.alreadyLoggedIn();
  }

  @override
  Future<void> signOut() async {
    await dataSource.signOut();
  }

  @override
  Future<UserEntity?> currentUser() async {
    final user = await dataSource.currentUser();
    if (user != null) {
      return UserModel.fromFireBaseUser(user);
    }
    return null;
  }

  @override
  Future<void> resetPassword(String email) async {
    await dataSource.resetPassword(email);
  }
}
