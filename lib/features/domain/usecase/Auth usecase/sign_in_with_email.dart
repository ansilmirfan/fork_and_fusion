import 'package:fork_and_fusion/features/domain/entity/user_entity.dart';
import 'package:fork_and_fusion/features/domain/repository/auth_repository.dart';

class SignInWithEmail {
  final AuthRepository repository;
  SignInWithEmail(this.repository);
  Future<UserEntity?> call(String email, String password) async {
    return await repository.signInWithEmail(email, password);
  }
}
