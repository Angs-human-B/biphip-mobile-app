import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

const kBearerToken = 'kBearerToken';
const kRememberMe = "kRememberMe";
const kRecentSearchList = "kRecentSearchList";

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

  //* recent shop search list
  Future<void> saveRecentSearchList(recentSearchList) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var data = recentSearchList;
    String encodeData = json.encode(data);
    await preferences.setString(kRecentSearchList, encodeData);
  }

  Future<dynamic> getRecentSearchList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? data = preferences.getString(kRecentSearchList);
    var recentSearchList = (data == null) ? [] : json.decode(data);
    return recentSearchList;
  }

  //* on logout
  Future<void> onLogout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(kBearerToken);
    await preferences.remove(kRememberMe);
  }
}
