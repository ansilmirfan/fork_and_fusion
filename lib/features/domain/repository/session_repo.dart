abstract class SessionRepo {
  Future<void> saveLogInStatus(bool isLoggedIn, String uid);
  Future<void> clearLogInStatus();
  Future<bool> isUserAlreadyLoggedIn();
}
