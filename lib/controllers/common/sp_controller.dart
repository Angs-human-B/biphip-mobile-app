import 'package:shared_preferences/shared_preferences.dart';

const kBearerToken = 'kBearerToken';
const kRememberMe = "kRememberMe";

class SpController {
  //* save Bearer Token
  Future<void> saveBearerToken(token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(kBearerToken, token.toString());
  }

  Future<String?> getBearerToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(kBearerToken);
  }

  //* Remember me status
  Future<void> saveRememberMe(value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(kRememberMe, value);
  }

  Future<bool?> getRememberMe() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(kRememberMe);
  }

  //* on logout
  Future<void> onLogout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(kBearerToken);
    await preferences.remove(kRememberMe);
  }
}
