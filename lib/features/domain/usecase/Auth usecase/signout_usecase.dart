import 'package:fork_and_fusion/features/domain/repository/auth_repository.dart';

class SignoutUsecase {
  AuthRepository repo;
  SignoutUsecase(this.repo);
  Future<void> call() async {
    await repo.signOut();
  }
}
