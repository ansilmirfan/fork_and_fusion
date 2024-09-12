import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource {
  SharedPreferences instantce;
  LocalDataSource(this.instantce);
  Future<void> saveLoginStatus(bool isLoggedIn, String uid) async {
    try {
      await instantce.setBool('isLoggedIn', isLoggedIn);
      await instantce.setString('uid', uid);
    } catch (e) {
      throw Exception('Something went wrong please try again');
    }
  }

  Future<void> clearLogInStatus() async {
    try {
      await instantce.remove('isLoggedIn');
      await instantce.remove('uid');
    } catch (e) {
      throw Exception('Something went wrong please try again');
    }
  }

  Future<bool> isUserAlreadyLoggedIn() async {
    return await instantce.getBool('isLoggedIn') ?? false;
  }
}
