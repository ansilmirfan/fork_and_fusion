import 'package:fork_and_fusion/features/domain/entity/user_entity.dart';
import 'package:fork_and_fusion/features/domain/repository/auth_repository.dart';

class SignUpWithEmail {
  final AuthRepository repository;

  SignUpWithEmail(this.repository);

  Future<UserEntity?> call(String email, String password, String name) async {
    return await repository.signUpWithEmail(email, password, name);
  }
}
