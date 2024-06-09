import 'package:shared_preferences/shared_preferences.dart';

class Utilities {
  static Future<void> saveLocalUser(user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('User', user);
  }

  static Future<String?> getLocalUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? user = pref.getString('User');
    return user;
  }

  static Future<void> saveLocalPassword(password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('Password', password);
  }

  static Future<String?> getLocalPassword() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? password = pref.getString('Password');
    return password;
  }
}
