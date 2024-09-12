import 'package:fork_and_fusion/features/data/data_source/local_data_source.dart';
import 'package:fork_and_fusion/features/domain/repository/session_repo.dart';

class SessionRepository implements SessionRepo {
  LocalDataSource source;
  SessionRepository(this.source);
  @override
  Future<void> saveLogInStatus(bool isLoggedIn, String uid) async {
    await source.saveLoginStatus(isLoggedIn, uid);
  }

  @override
  Future<void> clearLogInStatus() async {
    await source.clearLogInStatus();
  }

  @override
  Future<bool> isUserAlreadyLoggedIn() {
    return source.isUserAlreadyLoggedIn();
  }
}
