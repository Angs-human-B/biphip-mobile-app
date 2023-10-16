import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

const kBearerToken = 'kBearerToken';
const kRememberMe = "kRememberMe";
const kUserName = "kUserName";
const kUserImage = "kUserImage";
const kUserEmail = "kUserEmail";
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
    for (int i = 0; i < userList.length; i++) {
      if (userList[i]['email'] == userInfo['email']) {
        userList.removeAt(i);
        break;
      }
    }
    userList.add(userInfo);
    String encodeData = json.encode(userList);
    await preferences.setString(kUserList, encodeData);
  }

  Future<dynamic> getUserList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? data = preferences.getString(kUserList);
    List userList = (data == null) ? [] : json.decode(data);
    return userList;
  }

  Future<dynamic> getUserData(token) async {
    List userList = await getUserList();
    for (int i = 0; i < userList.length; i++) {
      if (userList[i]['token'] == token) {
        return userList[i];
      }
    }
    return null;
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

  //* save user name
  Future<void> saveUserName(name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(kUserName, name.toString());
  }

  Future<String?> getUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(kUserName);
  }

  //* save user Image
  Future<void> saveUserImage(imageUrl) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(kUserImage, imageUrl.toString());
  }

  Future<String?> getUserImage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(kUserImage);
  }

  //* save user email
  Future<void> saveUserEmail(email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(kUserEmail, email.toString());
  }

  Future<String?> getUserEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(kUserEmail);
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
    await preferences.remove(kUserName);
    await preferences.remove(kUserImage);
    await preferences.remove(kUserEmail);
  }
}
