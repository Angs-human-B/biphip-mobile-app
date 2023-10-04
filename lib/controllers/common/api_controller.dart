import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bip_hip/models/common/common_data_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:http/http.dart' as http;

class ApiController {
  final _globalController = Get.find<GlobalController>();

  CommonDM convertToCommonObject(apiResponse) {
    return CommonDM.fromJson(apiResponse);
  }

  void timeOutFunction() {
    String error = ksConnectionTimeoutMessage.tr;
    if (!Get.isSnackbarOpen) {
      _globalController.showSnackBar(title: ksError.tr, message: error, color: cRedColor);
    }
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
    bool? contentType,
  }) async {
    ll("Url : $url");
    final http.Client client = http.Client();
    final Uri uri = Uri.parse(Environment.apiUrl + url);
    ll("uri : $uri");
    http.Response response;
    String error = ksSomethingWentWrong.tr;

    try {
      response = await methodBasedResponse(
        method: requestMethod,
        token: token,
        body: body,
        uri: uri,
        timer: timer,
        client: client,
        contentType: contentType,
      );
      ll("response headers : ${response.statusCode}");
      if (response.statusCode == 200) {
        ll("response body : ${response.body}");
        CommonDM cm = convertToCommonObject(jsonDecode(response.body));
        return cm;
        // return jsonDecode(response.body);
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        await SpController().onLogout();
        Get.offAllNamed(krLogin);
      } else {
        if (!Get.isSnackbarOpen) {
          _globalController.showSnackBar(title: ksError.tr, message: error, color: cRedColor);
        }
        return null;
      }
    } on SocketException {
      error = ksNoInternetConnectionMessage.tr;
      if (!Get.isSnackbarOpen) {
        _globalController.showSnackBar(title: ksError.tr, message: error, color: cRedColor);
      }
      return null;
    } catch (e) {
      log(e.toString());
      if (!Get.isSnackbarOpen) {
        _globalController.showSnackBar(title: ksError.tr, message: error, color: cRedColor);
      }
      return null;
    } finally {
      client.close();
    }
  }
}
