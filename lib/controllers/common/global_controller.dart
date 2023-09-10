import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';

class GlobalController extends GetxController {
  final RxMap appLang = RxMap({'langCode': 'en', 'countryCode': 'US'});

  final Rx<String?> bearerToken = Rx<String?>(null);
  final RxList languages = RxList([
    {'langCode': 'bn', 'countryCode': 'BD', 'langName': 'Bengali'},
    {'langCode': 'en', 'countryCode': 'US', 'langName': 'English'},
  ]);

  //* parent route
  final RxString parentRoute = RxString("");

  //* info:: show loading
  final isLoading = RxBool(false);

  void showLoading() {
    isLoading.value = true;
    Get.defaultDialog(
      radius: 2,
      backgroundColor: cWhiteColor,
      barrierDismissible: false,
      title: "",
      onWillPop: () async {
        return true;
      },
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SpinKitFadingCircle(
            color: cPrimaryColor,
            size: 70.0,
          ),
          const SizedBox(height: k10Padding),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              ksLoading.tr,
              style: const TextStyle(color: cPrimaryColor, fontSize: h14),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Future<void> launchURL(url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) throw 'Could not launch $url';
  }

  void showSnackBar({required String title, required String message, required Color color, duration}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: color,
      colorText: cWhiteColor,
      maxWidth: 400,
      duration: Duration(milliseconds: duration ?? 1500),
    );
  }

  Future<void> commonLogOutFunction() async {
    await SpController().onLogout();
  }

  //! end
}
