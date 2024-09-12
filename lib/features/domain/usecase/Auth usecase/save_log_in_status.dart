import 'package:fork_and_fusion/features/domain/repository/session_repo.dart';

class SaveLogInStatusUseCase {
  SessionRepo repo;
  SaveLogInStatusUseCase(this.repo);
  Future<void> call(SaveLogInParams params) async {
    await repo.saveLogInStatus(params.isLoggedIn, params.uid);
  }
}

class SaveLogInParams {
  bool isLoggedIn;
  String uid;
  SaveLogInParams(this.isLoggedIn, this.uid);
}
