import 'package:fork_and_fusion/features/domain/entity/user_entity.dart';
import 'package:fork_and_fusion/features/domain/repository/auth_repository.dart';

class CurrentUserUsecase {
  AuthRepository repo;
  CurrentUserUsecase(this.repo);
  Future<UserEntity?> call() {
    return repo.currentUser();
  }
}
