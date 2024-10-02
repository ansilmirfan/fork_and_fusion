import 'package:fork_and_fusion/features/domain/repository/auth_repository.dart';

class ForgotPasswordUsecase {
  AuthRepository repo;
  ForgotPasswordUsecase(this.repo);
  Future<void> call(String email) async {
    await repo.resetPassword(email);
  }
}
