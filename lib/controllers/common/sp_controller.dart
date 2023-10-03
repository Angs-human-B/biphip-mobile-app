import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

const kBearerToken = 'kBearerToken';
const kRememberMe = "kRememberMe";
const kRecentSearchList = "kRecentSearchList";
const kUserList = "kUserList";

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

  //* save user list
  Future<void> saveUserList(userInfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List userList = await getUserList();
    bool isUserAlreadySaved = false;
    for (int i = 0; i < userList.length; i++) {
      if (userList[i]['email'] == userInfo['email']) {
        isUserAlreadySaved = true;
        break;
      }
    }
    if (!isUserAlreadySaved) {
      userList.add(userInfo);
      String encodeData = json.encode(userList);
      await preferences.setString(kUserList, encodeData);
    }
  }

  Future<dynamic> getUserList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? data = preferences.getString(kUserList);
    List userList = (data == null) ? [] : json.decode(data);
    return userList;
  }

  Future<void> removeUser(userInfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? data = preferences.getString(kUserList);
    List userList = (data == null) ? [] : json.decode(data);
    for (int i = 0; i < userList.length; i++) {
      if (userList[i]['email'] == userInfo['email']) {
        userList.removeAt(i);
        String encodeData = json.encode(userList);
        await preferences.setString(kUserList, encodeData);
        break;
      }
    }
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

  //* recent  search list
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
