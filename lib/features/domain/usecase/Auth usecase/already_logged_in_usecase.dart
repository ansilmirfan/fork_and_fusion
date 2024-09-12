import 'package:fork_and_fusion/features/domain/repository/auth_repository.dart';

class AlreadyLoggedInUsecase {
  AuthRepository repo;
  AlreadyLoggedInUsecase(this.repo);
  bool call() {
    return repo.alreadyLoggedIn();
  }
}
