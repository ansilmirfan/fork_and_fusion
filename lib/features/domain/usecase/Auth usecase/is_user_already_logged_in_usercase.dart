import 'package:fork_and_fusion/features/domain/repository/session_repo.dart';

class IsUserAlreadyLoggedInUsercase {
  SessionRepo repo;
  IsUserAlreadyLoggedInUsercase(this.repo);
  Future<bool> call() async {
    return repo.isUserAlreadyLoggedIn();
  }
}
