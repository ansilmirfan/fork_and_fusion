import 'package:fork_and_fusion/features/domain/repository/session_repo.dart';

class ClearLogInStatusUseCase {
  SessionRepo repo;
  ClearLogInStatusUseCase(this.repo);
  Future<void> call() async {
    await repo.clearLogInStatus();
  }
}
