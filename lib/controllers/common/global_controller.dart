import 'dart:convert';
import 'dart:io';

import 'package:bip_hip/controllers/authentication_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
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

  //* info:: common bottom-sheet
  void commonBottomSheet({
    required context,
    required Widget content,
    required onPressCloseButton,
    required onPressRightButton,
    required String rightText,
    required TextStyle rightTextStyle,
    required String title,
    required bool isRightButtonShow,
  }) {
    showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(k16BorderRadius), topRight: Radius.circular(k16BorderRadius)),
      ),
      context: context,
      builder: (BuildContext context) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              width: width,
              child: Column(
                children: [
                  kH4sizedBox,
                  Container(
                    decoration: BoxDecoration(
                      color: cLineColor,
                      borderRadius: k4CircularBorderRadius,
                    ),
                    height: 5,
                    width: width * .1,
                  ),
                  kH40sizedBox,
                  const Divider(
                    color: cLineColor,
                    thickness: 1,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: k16Padding, vertical: k8Padding),
                        child: content,
                      ),
                    ),
                  ),
                  kH4sizedBox,
                ],
              ),
            ),
            Positioned(
              top: h16,
              left: 5,
              child: CustomIconButton(
                onPress: onPressCloseButton,
                icon: BipHip.circleCrossNew,
                iconColor: cIconColor,
                size: screenWiseSize(kIconSize24, 4),
              ),
            ),
            Positioned(
              top: h20,
              child: Text(
                title,
                style: semiBold18TextStyle(cBlackColor),
              ),
            ),
            if (isRightButtonShow)
              Positioned(
                top: h20,
                right: 10,
                child: CustomTextButton(
                  onPressed: onPressRightButton,
                  icon: BipHip.circleCross,
                  text: rightText,
                  textStyle: rightTextStyle,
                ),
              ),
          ],
        );
      },
    );
  }

  //* Image picker
  final ImagePicker _picker = ImagePicker();

  Future<void> selectImageSource(RxBool isChanged, imageLink, imageFile, String source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source == 'gallery' ? ImageSource.gallery : ImageSource.camera,
        maxHeight: 480,
        maxWidth: 720,
      );
      if (image != null) {
        final List<int> imageBytes = await image.readAsBytes();
        final String base64Image = base64Encode(imageBytes);
        final File imageTemporary = File(image.path);
        // var value = await _image.length();
        // ll(value);
        imageFile(imageTemporary);
        isChanged.value = true;
        imageLink.value = 'data:image/png;base64,$base64Image';
        // log(imageLink.toString());
        Get.back();
        ll(Get.find<AuthenticationController>().isProfileImageChanged.value);
      } else {
        ll('image not selected');
        return;
      }
    } on PlatformException catch (e) {
      ll("Failed to Pick Image $e");
    }
  }

  //! end
}
