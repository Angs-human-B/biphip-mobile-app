// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
// import 'package:bip_hip/utils/constants/imports.dart';
// import 'package:http/http.dart' as http;

class ApiController {
  // final _globalController = Get.find<GlobalController>();

  // CommonDM convertToCommonObject(apiResponse) {
  //   return CommonDM.fromJson(apiResponse);
  // }

  //* info:: common get
  // Future<dynamic> commonGet({
  //   required String? token,
  //   required String url,
  //   required bool showLoading,
  //   int? timer,
  // }) async {
  //   log("url:$url");
  //   if (showLoading) {
  //     _globalController.showLoading();
  //   }
  //   final http.Client client = http.Client();
  //   final Uri uri = Uri.parse(Environment.baseUrl + url);

  //   http.Response response;
  //   String error = ksAnErrorOccurred.tr;
  //   try {
  //     response = await client.get(
  //       uri,
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'app-role': 'user',
  //       },
  //     ).timeout(
  //       Duration(seconds: timer ?? 30),
  //       onTimeout: () {
  //         error = ksConnectionTimeoutMessage.tr;
  //         if (showLoading) {
  //           if (_globalController.isLoading.value) {
  //             _globalController.isLoading.value = false;
  //             Get.back();
  //           }
  //         }
  //         _globalController.showSnackBar(title: ksError.tr, message: error, color: cRedTintColor);
  //         throw TimeoutException(ksConnectionTimeoutMessage.tr);
  //       },
  //     );
  //     if (showLoading) {
  //       if (_globalController.isLoading.value) {
  //         _globalController.isLoading.value = false;
  //         Get.back();
  //       }
  //     }
  //     ll("response : ${response.body}");
  //     CommonDM cm = _convertToCommonObject(jsonDecode(response.body));
  //     return cm;
  //     // return jsonDecode(response.body);
  //   } on SocketException {
  //     error = ksNoInternetConnectionMessage.tr;
  //     if (showLoading) {
  //       if (_globalController.isLoading.value) {
  //         _globalController.isLoading.value = false;
  //         Get.back();
  //       }
  //     }
  //     _globalController.showSnackBar(title: ksError.tr, message: error, color: cRedAccentColor);
  //     return null;
  //   } catch (e) {
  //     log(e.toString());
  //     if (showLoading) {
  //       if (_globalController.isLoading.value) {
  //         _globalController.isLoading.value = false;
  //         Get.back();
  //       }
  //     }
  //     _globalController.showSnackBar(title: ksError.tr, message: error, color: cRedAccentColor);
  //     return null;
  //   } finally {
  //     if (showLoading) {
  //       if (_globalController.isLoading.value) {
  //         _globalController.isLoading.value = false;
  //         Get.back();
  //       }
  //     }
  //     client.close();
  //   }
  // }

  // //* info:: common post with body and token
  // Future<dynamic> commonPostWithBodyAndToken({
  //   required String? token,
  //   required String url,
  //   required Map<String, dynamic> body,
  //   required bool showLoading,
  //   int? timer,
  // }) async {
  //   if (showLoading) {
  //     _globalController.showLoading();
  //   }
  //   final http.Client client = http.Client();
  //   final Uri uri = Uri.parse(Environment.baseUrl + url);
  //   http.Response response;
  //   String error = ksAnErrorOccurred.tr;
  //   try {
  //     response = await client
  //         .post(
  //       uri,
  //       headers: {
  //         if (token != null) 'Authorization': 'Bearer $token',
  //         'app-role': 'user',
  //       },
  //       body: body,
  //     )
  //         .timeout(
  //       Duration(seconds: timer ?? 30),
  //       onTimeout: () {
  //         error = ksConnectionTimeoutMessage.tr;
  //         if (showLoading) {
  //           if (_globalController.isLoading.value) {
  //             _globalController.isLoading.value = false;
  //             Get.back();
  //           }
  //         }
  //         _globalController.showSnackBar(title: ksError.tr, message: error, color: cRedAccentColor);
  //         throw TimeoutException(ksConnectionTimeoutMessage.tr);
  //       },
  //     );
  //     if (showLoading) {
  //       if (_globalController.isLoading.value) {
  //         _globalController.isLoading.value = false;
  //         Get.back();
  //       }
  //     }
  //     ll("response : ${jsonDecode(response.body)}");
  //     // return jsonDecode(response.body);
  //     CommonDM cm = _convertToCommonObject(jsonDecode(response.body));
  //     return cm;
  //   } on SocketException {
  //     error = ksNoInternetConnectionMessage.tr;
  //     if (showLoading) {
  //       if (_globalController.isLoading.value) {
  //         _globalController.isLoading.value = false;
  //         Get.back();
  //       }
  //     }
  //     _globalController.showSnackBar(title: ksError.tr, message: error, color: cRedAccentColor);
  //     return null;
  //   } catch (e) {
  //     log(e.toString());
  //     if (showLoading) {
  //       if (_globalController.isLoading.value) {
  //         _globalController.isLoading.value = false;
  //         Get.back();
  //       }
  //     }

  //     _globalController.showSnackBar(title: ksError.tr, message: error, color: cRedAccentColor);
  //     return null;
  //   } finally {
  //     if (showLoading) {
  //       if (_globalController.isLoading.value) {
  //         _globalController.isLoading.value = false;
  //         Get.back();
  //       }
  //     }
  //     client.close();
  //   }
  // }


}
