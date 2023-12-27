import 'dart:io';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/family/widgets/all_family_listview.dart';
import 'package:bip_hip/views/menu/family/widgets/pending_family_listview.dart';
import 'package:bip_hip/views/menu/family/widgets/received_family_listview.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:url_launcher/url_launcher.dart';

class GlobalController extends GetxController {
  final RxMap appLang = RxMap({'langCode': 'en', 'countryCode': 'US'});

  final Rx<String?> bearerToken = Rx<String?>(null);
  final RxList professionList = RxList([]);
  final RxList interestList = RxList([]);
  final RxList<int> interestIndex = RxList<int>([]);
  final RxInt professionIndex = RxInt(-1);
  RxString selectedProfession = RxString('');
  RxList selectedInterests = RxList([]);
  final RxList tapAbleButtonState = RxList([true, false, false]);
  final RxList tapAbleButtonText = RxList(["All", "Received", "Pending"]);
  final RxList languages = RxList([
    {'langCode': 'bn', 'countryCode': 'BD', 'langName': 'Bengali'},
    {'langCode': 'en', 'countryCode': 'US', 'langName': 'English'},
  ]);
  void resetChipSelection() {
    professionIndex.value = -1;
    interestIndex.clear();
  }

  //*For tapAble button
  void toggleType(int index) {
    switch (index) {
      case 0:
        tapAbleButtonState[0] = true;
        tapAbleButtonState[1] = false;
        tapAbleButtonState[2] = false;
        break;
      case 1:
        tapAbleButtonState[0] = false;
        tapAbleButtonState[1] = true;
        tapAbleButtonState[2] = false;
        break;
      case 2:
        tapAbleButtonState[0] = false;
        tapAbleButtonState[1] = false;
        tapAbleButtonState[2] = true;
        break;
    }
  }

  void resetTapButtonData() {
    tapAbleButtonState.clear();
    tapAbleButtonState.addAll([true, false, false]);
  }

  //*friends page list data show
  StatelessWidget familyListView() {
    if (tapAbleButtonState[0] == true) {
      return AllFamilyListView();
    } else if (tapAbleButtonState[1] == true) {
      return ReceivedFamilyListView();
    } else {
      return PendingFamilyListView();
    }
  }

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
        if (isLoading.value) {
          return false;
        }
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
    double? bottomSheetHeight,
    bool? isScrollControlled,
    bool? isSearchShow,
  }) {
    showModalBottomSheet<void>(
      isScrollControlled: isScrollControlled ?? false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(k16BorderRadius), topRight: Radius.circular(k16BorderRadius)),
      ),
      context: context,
      builder: (BuildContext context) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(k16BorderRadius), topRight: Radius.circular(k16BorderRadius)), color: cWhiteColor),
              width: width,
              height: MediaQuery.of(context).viewInsets.bottom > 0.0 ? height * .9 : bottomSheetHeight ?? height * .5,
              constraints: BoxConstraints(minHeight: bottomSheetHeight ?? height * .5, maxHeight: height * .9),
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
                  const CustomDivider(
                    thickness: 1,
                  ),
                  if (isSearchShow == true)
                    Padding(
                      padding: const EdgeInsets.only(left: k16Padding, right: k16Padding, top: k16Padding),
                      child: CustomModifiedTextField(
                        borderRadius: h8,
                        controller: searchController,
                        prefixIcon: BipHip.search,
                        suffixIcon: BipHip.voiceFill,
                        hint: ksSearch.tr,
                        contentPadding: const EdgeInsets.symmetric(horizontal: k16Padding),
                        textInputStyle: regular16TextStyle(cBlackColor),
                      ),
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
              top: h12,
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
                child: Obx(() => CustomTextButton(
                      onPressed: isBottomSheetRightButtonActive.value ? onPressRightButton : null,
                      icon: BipHip.circleCross,
                      text: rightText,
                      textStyle: isBottomSheetRightButtonActive.value ? rightTextStyle : medium14TextStyle(cLineColor2),
                    )),
              ),
          ],
        );
      },
    );
  }

  final RxBool isBottomSheetRightButtonActive = RxBool(true);

  //* Image picker
  final ImagePicker _picker = ImagePicker();

  Future<bool> selectImageSource(RxBool isChanged, imageLink, imageFile, String source, [bool? isFromBottomSheet, isList = false]) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source == 'gallery' ? ImageSource.gallery : ImageSource.camera,
        maxHeight: 480,
        maxWidth: 720,
      );
      if (image != null) {
        // final List<int> imageBytes = await image.readAsBytes();
        // final String base64Image = base64Encode(imageBytes);
        final File imageTemporary = File(image.path);
        if (isList) {
          imageFile.add(imageTemporary.obs);
        } else {
          imageFile(imageTemporary);
        }
        isChanged.value = true;
        // imageLink.value = 'data:image/png;base64,$base64Image';
        // log(imageLink.toString());
        if (isFromBottomSheet != false) {
          Get.back();
        }
        return true;
      } else {
        ll('image not selected');
        return false;
      }
    } on PlatformException catch (e) {
      ll("Failed to Pick Image $e");
      return false;
    }
  }

  Future<bool> selectMultiMediaSource(RxBool isMediaChanged, RxList<RxString> mediaLinkList, RxList<Rx<File?>> mediaFileList) async {
    try {
      final List<XFile> mediaList = await _picker.pickMultiImage(
        maxHeight: 480,
        maxWidth: 720,
      );
      if (mediaList.isNotEmpty) {
        for (int i = 0; i < mediaList.length; i++) {
          final String? type = lookupMimeType(mediaList[i].path);
          ll(type);
          // final List<int> imageBytes = await mediaList[i].readAsBytes();
          // final String base64Image = base64Encode(imageBytes);
          if (type != null) {
            isMediaChanged.value = true;
            final File imageTemporary = File(mediaList[i].path);
            mediaFileList.add(imageTemporary.obs);
            // if (type.contains('image')) {
            //   mediaLinkList.add('data:image/png;base64,$base64Image'.obs);
            // }
            // if (type.contains('video')) {
            //   mediaLinkList.add('data:video/mp4;base64,$base64Image'.obs);
            // }
          } else {
            showSnackBar(title: ksWarning.tr, message: ksFileFormatNotSupported.tr, color: cSecondaryColor);
          }
        }
        return true;
      } else {
        ll('file not selected');
        return false;
      }
    } on PlatformException catch (e) {
      ll("Failed to Pick file $e");
      return false;
    }
  }

  Future<bool> selectMultiMediaSourceForSelling(
    RxBool isMediaChanged,
    RxList<RxString> mediaLinkList,
    RxList<Rx<File?>> mediaFileList,
  ) async {
    try {
      // Maximum allowed images
      const int maxImageCount = 10;

      // Check if the maximum count is reached
      if (mediaFileList.length >= maxImageCount) {
        // You can show a message or take appropriate action when the limit is reached
        showSnackBar(
          title: ksWarning.tr,
          message: 'Maximum of $maxImageCount images allowed.',
          color: cSecondaryColor,
        );
        return false;
      }

      final List<XFile> mediaList = await _picker.pickMultiImage(
        // maxHeight: 480,
        // maxWidth: 720,
      );

      if (mediaList.isNotEmpty) {
        for (int i = 0; i < mediaList.length; i++) {
          final String? type = lookupMimeType(mediaList[i].path);

          if (type != null) {
            isMediaChanged.value = true;
            final File imageTemporary = File(mediaList[i].path);
            mediaFileList.add(imageTemporary.obs);

            // You can add the mediaLinkList logic here if needed

            if (mediaFileList.length >= maxImageCount) {
              // Disable further selection when the limit is reached
              showSnackBar(
                title: ksWarning.tr,
                message: 'Maximum of $maxImageCount images reached.',
                color: cSecondaryColor,
              );
              break; // Exit the loop
            }
          } else {
            showSnackBar(
              title: ksWarning.tr,
              message: ksFileFormatNotSupported.tr,
              color: cSecondaryColor,
            );
          }
        }
        return true;
      } else {
        ll('file not selected');
        return false;
      }
    } on PlatformException catch (e) {
      ll("Failed to Pick file $e");
      return false;
    }
  }

  //*For Selling type post max limit 10 and max size per image is 5
  // Future<bool> selectMultiMediaSourceForSelling(RxBool isMediaChanged, RxList<RxString> mediaLinkList, RxList<Rx<File?>> mediaFileList) async {
  //   // if (mediaFileList.length >= 10) {
  //   //   showSnackBar(title: "Warning", message: "You cannot select more than 10 images.", color: Colors.red);
  //   //   return false;
  //   // }
  //   try {
  //     final List<XFile> mediaList = await _picker
  //         .pickMultiImage(
  //             // maxHeight: 480,
  //             // maxWidth: 720,
  //             )
  //         .then((value) => value.take(10).toList());
  //     if (mediaList.isNotEmpty) {
  //       for (int i = 0; i < mediaList.length; i++) {
  //         final String? type = lookupMimeType(mediaList[i].path);
  //         if (type != null) {
  //           final File imageTemporary = File(mediaList[i].path);
  //           if (mediaFileList.length > 10) {
  //             showSnackBar(title: "Warning", message: "You cannot select more than 10 images.", color: cAmberColor);
  //             return false;
  //           }
  //           if (await imageTemporary.exists()) {
  //             final double sizeInMB = imageTemporary.lengthSync() / (1024 * 1024);
  //             ll('file size is ${sizeInMB.toString()}');
  //             if (sizeInMB > 5) {
  //               showSnackBar(title: "Warning", message: "Image size must be less than 5MB.", color: cAmberColor);
  //               continue;
  //             }
  //           }
  //           isMediaChanged.value = true;
  //           mediaFileList.add(imageTemporary.obs);
  //         } else {}
  //       }
  //       return true;
  //     } else {
  //       ll('file not selected');
  //       return false;
  //     }
  //   } on PlatformException catch (e) {
  //     ll("Failed to Pick file $e");
  //     return false;
  //   }
  // }

  Future<bool> selectVideoSource(RxBool isChanged, videoLink, videoFile, String source, [isList = false]) async {
    try {
      final XFile? video = await _picker.pickVideo(
          source: source == 'gallery' ? ImageSource.gallery : ImageSource.camera,
          preferredCameraDevice: CameraDevice.rear,
          maxDuration: const Duration(seconds: 600));
      if (video != null) {
        // final List<int> videoBytes = await video.readAsBytes();
        // final String base64Video = base64Encode(videoBytes);
        final File videoTemporary = File(video.path);
        if (isList) {
          videoFile.add(videoTemporary.obs);
        } else {
          videoFile(videoTemporary);
        }
        isChanged.value = true;
        // videoLink.value = 'data:video/mp4;base64,$base64Video';
        // log(videoLink.toString());
        return true;
      } else {
        ll('video not selected');
        return false;
      }
    } on PlatformException catch (e) {
      ll("Failed to Pick Video $e");
      return false;
    }
  }

  void setKeyboardValue(value, keyValue) {
    keyValue.value = value;
    ll(value);
  }

  void blankBottomSheet({
    required context,
    required Widget content,
    double? bottomSheetHeight,
    bool? isScrollControlled,
  }) {
    showModalBottomSheet<void>(
      isScrollControlled: isScrollControlled ?? false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(k16BorderRadius), topRight: Radius.circular(k16BorderRadius)),
      ),
      context: context,
      builder: (BuildContext context) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(k16BorderRadius), topRight: Radius.circular(k16BorderRadius)), color: cWhiteColor),
              width: width,
              height: MediaQuery.of(context).viewInsets.bottom > 0.0 ? height * .9 : bottomSheetHeight ?? height * .5,
              constraints: BoxConstraints(minHeight: bottomSheetHeight ?? height * .5, maxHeight: height * .9),
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
                  kH10sizedBox,
                  Expanded(
                    child: SingleChildScrollView(
                      child: content,
                    ),
                  ),
                  kH4sizedBox,
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  final searchController = TextEditingController();
  final recentSearch = RxList();

  final Rx<String?> userName = Rx<String?>(null);
  final Rx<String?> userFirstName = Rx<String?>(null);
  final Rx<String?> userLastName = Rx<String?>(null);
  final Rx<String?> userImage = Rx<String?>(null);
  final Rx<String?> userEmail = Rx<String?>(null);
  final Rx<String?> userToken = Rx<String?>(null);

  Future<void> getUserInfo() async {
    SpController spController = SpController();
    userName.value = await spController.getUserName();
    userFirstName.value = await spController.getUserFirstName();
    userLastName.value = await spController.getUserLastName();
    userImage.value = await spController.getUserImage();
    userEmail.value = await spController.getUserEmail();
    userToken.value = await spController.getBearerToken();
    var userData = await spController.getUserData(userToken.value);
    ll("--- : $userData");
    if (userData != null) {
      userName.value = userData['name'];
      userFirstName.value = userData['first_name'];
      userLastName.value = userData['last_name'];
      userImage.value = userData['image_url'];
      userEmail.value = userData['email'];
      userToken.value = userData['token'];
    }
  }

  //! end
}
