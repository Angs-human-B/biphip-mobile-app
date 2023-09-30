import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:http/http.dart' as http;

class ApiController {
  final _globalController = Get.find<GlobalController>();

  // CommonDM convertToCommonObject(apiResponse) {
  //   return CommonDM.fromJson(apiResponse);
  // }

  void timeOutFunction() {
    String error = ksConnectionTimeoutMessage.tr;
    _globalController.showSnackBar(title: ksError.tr, message: error, color: cRedTintColor);
  }

  Future<http.Response> methodBasedResponse({
    required String method,
    required String? token,
    Map<String, dynamic>? body,
    required Uri uri,
    int? timer,
    required http.Client client,
    bool? contentType,
  }) async {
    if (method == "GET") {
      return await client.get(
        uri,
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
        },
      ).timeout(
        Duration(seconds: timer ?? 30),
        onTimeout: () {
          timeOutFunction();
          throw TimeoutException(ksConnectionTimeoutMessage.tr);
        },
      );
    } else if (method == "POST") {
      return await client.post(
        uri,
        body: body,
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          if (contentType != null) 'content-Type': 'multipart/form-data',
        },
      ).timeout(
        Duration(seconds: timer ?? 30),
        onTimeout: () {
          timeOutFunction();
          throw TimeoutException(ksConnectionTimeoutMessage.tr);
        },
      );
    } else {
      return await client.delete(
        uri,
        body: body,
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
        },
      ).timeout(
        Duration(seconds: timer ?? 30),
        onTimeout: () {
          timeOutFunction();
          throw TimeoutException(ksConnectionTimeoutMessage.tr);
        },
      );
    }
  }

  //* Common Api call
  Future<dynamic> commonApiCall({
    String? token,
    required String url,
    Map<String, dynamic>? body,
    required String requestMethod,
    int? timer,
  }) async {
    ll("Url : $url");
    final http.Client client = http.Client();
    final Uri uri = Uri.parse(Environment.apiUrl + url);
    ll("uri : $uri");
    http.Response response;
    String error = ksAnErrorOccurred.tr;

    try {
      response = await methodBasedResponse(
        client: client,
        method: requestMethod,
        uri: uri,
        token: token,
        body: body,
      );
      ll("response headers : ${response.statusCode}");
      if (response.statusCode == 200) {
        ll("response body : ${response.body}");
        // CommonDM cm = _convertToCommonObject(jsonDecode(response.body));
        // return cm;
        return jsonDecode(response.body);
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        await SpController().onLogout();
        Get.offAllNamed(krLogin);
      } else {
        return null;
      }
    } on SocketException {
      error = ksNoInternetConnectionMessage.tr;
      _globalController.showSnackBar(title: ksError.tr, message: error, color: cRedTintColor);
      return null;
    } catch (e) {
      log(e.toString());
      _globalController.showSnackBar(title: ksError.tr, message: error, color: cRedTintColor);
      return null;
    } finally {
      client.close();
    }
  }
}
