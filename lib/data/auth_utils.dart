import 'package:shared_preferences/shared_preferences.dart';

class AuthUtils {
  static String? token;
  static String? phoneNumber;
  static int? profileID;

  static Future<void> saveUserData(String uToken, String pNumber, String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString('token', uToken);
    sharedPreferences.setString('phoneNumber', pNumber);
    sharedPreferences.setString('profileID', id);

    token = uToken;
    phoneNumber = pNumber;
    profileID = int.parse(id);


  }

  static Future<bool> checkLoginState() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    if (token == null) {
      return false;
    } else {
      return true;
    }
  }

  static Future<void> getAuthData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    token = sharedPreferences.getString('token');
    phoneNumber = sharedPreferences.getString('phoneNumber');
    profileID = int.parse(sharedPreferences.getString('profileID').toString());
  }

  static Future<void> clearAllData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}
