import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/controllers/messenger/messenger_controller.dart';
import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/models/home/new_post_list_model.dart';
import 'package:bip_hip/models/home/reportlistmode.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/family/widgets/all_family_listview.dart';
import 'package:bip_hip/views/menu/family/widgets/pending_family_listview.dart';
import 'package:bip_hip/views/menu/family/widgets/received_family_listview.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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
  void commonBottomSheet(
      {required context,
      required Widget content,
      required onPressCloseButton,
      required onPressRightButton,
      required String rightText,
      required TextStyle rightTextStyle,
      required String title,
      required bool isRightButtonShow,
      double? bottomSheetHeight,
      bool? isScrollControlled,
      isSearchShow,
      RxBool? isBottomSheetRightButtonActive,
      bool? isDismissible}) {
    showModalBottomSheet<void>(
      isDismissible: isDismissible ?? true,
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
                      onPressed: isBottomSheetRightButtonActive!.value ? onPressRightButton : null,
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
          if (type != null) {
            isMediaChanged.value = true;
            final File imageTemporary = File(mediaList[i].path);
            mediaFileList.add(imageTemporary.obs);
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

  //*For Selling type post max limit 10 and max size per image is 5
  Future<bool> selectMultiMediaSourceForSelling(RxBool isMediaChanged, RxList<RxString> mediaLinkList, RxList<Rx<File?>> mediaFileList) async {
    // if (mediaFileList.length >= 10) {
    //   showSnackBar(title: "Warning", message: "You cannot select more than 10 images.", color: Colors.red);
    //   return false;
    // }
    try {
      final List<XFile> mediaList = await _picker
          .pickMultiImage(
              // maxHeight: 480,
              // maxWidth: 720,
              )
          .then((value) => value.take(10).toList());
      if (mediaList.isNotEmpty) {
        for (int i = 0; i < mediaList.length; i++) {
          final String? type = lookupMimeType(mediaList[i].path);
          if (type != null) {
            final File imageTemporary = File(mediaList[i].path);
            if (mediaFileList.length > 10) {
              showSnackBar(title: "Warning", message: "You cannot select more than 10 images.", color: cAmberColor);
              return false;
            }
            if (await imageTemporary.exists()) {
              final double sizeInMB = imageTemporary.lengthSync() / (1024 * 1024);
              ll('file size is ${sizeInMB.toString()}');
              if (sizeInMB > 5) {
                showSnackBar(title: "Warning", message: "Image size must be less than 5MB.", color: cAmberColor);
                continue;
              }
            }
            isMediaChanged.value = true;
            mediaFileList.add(imageTemporary.obs);
          } else {}
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
  final Rx<int?> userId = Rx<int?>(null);
  final Rx<String?> userToken = Rx<String?>(null);

  Future<void> getUserInfo() async {
    SpController spController = SpController();
    userName.value = await spController.getUserName();
    userFirstName.value = await spController.getUserFirstName();
    userLastName.value = await spController.getUserLastName();
    userImage.value = await spController.getUserImage();
    userEmail.value = await spController.getUserEmail();
    userId.value = await spController.getUserId();
    userToken.value = await spController.getBearerToken();
    var userData = await spController.getUserData(userToken.value);
    ll("--- : $userData");
    if (userData != null) {
      userName.value = userData['name'];
      userFirstName.value = userData['first_name'];
      userLastName.value = userData['last_name'];
      userImage.value = userData['image_url'];
      userEmail.value = userData['email'];
      userId.value = userData['id'];
      userToken.value = userData['token'];
    }
  }

  RxString? getReaction(RxString? selfReaction, reaction, refType, refId) {
    Get.back();
    if (selfReaction != null) {
      if (selfReaction.value == reaction) {
        Get.find<PostReactionController>().postReaction(refType, refId, selfReaction.value);
        selfReaction = null;
      } else {
        selfReaction = RxString(reaction);
        Get.find<PostReactionController>().postReaction(refType, refId, selfReaction.value);
      }
    } else {
      selfReaction = RxString(reaction);
      Get.find<PostReactionController>().postReaction(refType, refId, selfReaction);
    }
    log('-----' + selfReaction.toString());
    return selfReaction;
  }

  List<Map<String, dynamic>> reactionVariant = [
    {"reaction": "Like", "color": cPrimaryColor, "icon": kiLikeSvgImageUrl},
    {"reaction": "Love", "color": cRedColor, "icon": kiLoveSvgImageUrl},
    {"reaction": "Haha", "color": cAmberColor, "icon": kiHahaSvgImageUrl},
    {"reaction": "Sad", "color": cAmberColor, "icon": kiSadSvgImageUrl},
    {"reaction": "Angry", "color": cAmberColor, "icon": kiAngrySvgImageUrl},
    {"reaction": "Wow", "color": cAmberColor, "icon": kiWowSvgImageUrl},
  ];

  Widget getColoredCommentReaction(Rx<String>? myReaction) {
    if (myReaction == null) {
      return Text(
        ksLike,
        style: regular10TextStyle(cSmallBodyTextColor),
      );
    } else {
      for (int i = 0; i < reactionVariant.length; i++) {
        if (reactionVariant[i]["reaction"].toString().toLowerCase() == myReaction.value) {
          return Text(
            reactionVariant[i]["reaction"].toString(),
            style: regular10TextStyle(reactionVariant[i]["color"]),
          );
        }
      }
      return const SizedBox();
    }
  }

  Widget getColoredReactionIcon(RxString? myReaction) {
    if (myReaction == null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            ksLike,
            style: semiBold12TextStyle(cSmallBodyTextColor),
          ),
          kW4sizedBox,
          const Icon(
            BipHip.love,
            color: cIconColor,
            size: kIconSize20,
          )
        ],
      );
    } else {
      for (int i = 0; i < reactionVariant.length; i++) {
        if (reactionVariant[i]["reaction"].toString().toLowerCase() == myReaction.value.toLowerCase()) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                reactionVariant[i]["reaction"],
                style: semiBold12TextStyle(reactionVariant[i]["color"]),
              ),
              kW4sizedBox,
              SvgPicture.asset(
                reactionVariant[i]["icon"],
                width: 20,
              )
            ],
          );
        }
      }
      return const SizedBox();
    }
  }

  Rx<CountReactions>? updateReaction(String reaction, Rx<String>? myReaction, Rx<CountReactions>? countReactionRX) {
    CountReactions? countReaction = countReactionRX?.value;

    void adjustReactionCount(String reaction, bool increment) {
      countReaction ??= CountReactions(
        all: RxInt(0),
        haha: RxInt(0),
        like: RxInt(0),
        love: RxInt(0),
        sad: RxInt(0),
        wow: RxInt(0),
        angry: RxInt(0),
      );

      switch (reaction) {
        case 'haha':
          countReaction!.haha = increment ? (countReaction!.haha ?? RxInt(0)) + 1 : (countReaction!.haha ?? RxInt(0)) - 1;
          break;
        case 'like':
          countReaction!.like = increment ? (countReaction!.like ?? RxInt(0)) + 1 : (countReaction!.like ?? RxInt(0)) - 1;
          break;
        case 'love':
          countReaction!.love = increment ? (countReaction!.love ?? RxInt(0)) + 1 : (countReaction!.love ?? RxInt(0)) - 1;
          break;
        case 'sad':
          countReaction!.sad = increment ? (countReaction!.sad ?? RxInt(0)) + 1 : (countReaction!.sad ?? RxInt(0)) - 1;
          break;
        case 'wow':
          countReaction!.wow = increment ? (countReaction!.wow ?? RxInt(0)) + 1 : (countReaction!.wow ?? RxInt(0)) - 1;
          break;
        case 'angry':
          countReaction!.angry = increment ? (countReaction!.angry ?? RxInt(0)) + 1 : (countReaction!.angry ?? RxInt(0)) - 1;
          break;
        default:
          break;
      }
    }

    if (myReaction == null) {
      adjustReactionCount(reaction, true);
      countReaction!.all = (countReaction!.all ?? RxInt(0)) + 1;
    } else {
      if (myReaction == reaction) {
        adjustReactionCount(reaction, false);
        countReaction!.all = (countReaction!.all ?? RxInt(0)) - 1;
        if (countReaction!.all!.value == 0) {
          return null;
        }
      } else {
        adjustReactionCount(myReaction.value, false);
        adjustReactionCount(reaction, true);
        countReaction!.all = (countReaction!.all ?? RxInt(0)) - 1;
        countReaction!.all = (countReaction!.all ?? RxInt(0)) + 1;
        if (countReaction!.all!.value == 0) {
          return null;
        }
      }
    }

    return Rx<CountReactions>(countReaction!);
  }

  void updateCommentCount(RxList<PostDataRx> postList, postIndex, isAddComment) {
    if (isAddComment) {
      postList[postIndex].countComment!.value = postList[postIndex].countComment!.value + 1;
    } else {
      postList[postIndex].countComment!.value = postList[postIndex].countComment!.value - 1;
    }
    // postList.replaceRange(postIndex, postIndex + 1, [postList[postIndex]]);
  }

  void updateSharedPostCommentCount(isAddComment) {
    if (isAddComment) {
      Get.find<HomeController>().postData.value!.post.countComment!.value = Get.find<HomeController>().postData.value!.post.countComment!.value + 1;
    } else {
      Get.find<HomeController>().postData.value!.post.countComment!.value = Get.find<HomeController>().postData.value!.post.countComment!.value - 1;
    }
    update();
  }

  final RxList<PostDataRx> commonPostList = RxList<PostDataRx>([]);
  void populatePostList(postList) {
    commonPostList.addAll(postList);
  }

  IconData getCategoryIcon(categoryID) {
    if (categoryID == 3) {
      return BipHip.poetry;
    } else if (categoryID == 4) {
      return BipHip.photography;
    } else if (categoryID == 5) {
      return BipHip.painting;
    } else if (categoryID == 6) {
      return BipHip.storytelling;
    } else if (categoryID == 7) {
      return BipHip.kids;
    } else if (categoryID == 8) {
      return BipHip.newsFill;
    } else {
      return BipHip.selling;
    }
  }

  Color getCategoryColor(categoryID) {
    if (categoryID == 3) {
      return cPoetryColor;
    } else if (categoryID == 4) {
      return cPhotographyColor;
    } else if (categoryID == 5) {
      return cPaintingColor;
    } else if (categoryID == 6) {
      return cStoryTellingColor;
    } else if (categoryID == 7) {
      return cKidsColor;
    } else if (categoryID == 8) {
      return cBlackColor;
    } else {
      return cSellingColor;
    }
  }

  String postTimeDifference(DateTime inputDate) {
    final now = DateTime.now();
    final difference = now.difference(inputDate);

    if (difference.inDays >= 7) {
      return DateFormat('dd MMMM yyyy').format(inputDate);
    } else if (difference.inDays >= 1) {
      if (difference.inDays == 1) {
        return '${difference.inDays} day ago';
      } else {
        return '${difference.inDays} days ago';
      }
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} h ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} m ago';
    } else {
      return '${difference.inSeconds} s ago';
    }
  }

  String? getProductCondition(id) {
    for (var privacy in Get.find<CreatePostController>().createPostSellConditionList) {
      if (privacy.id == id) {
        return privacy.name;
      }
    }
    return null;
  }

  String? getProductCategory(id) {
    for (var privacy in Get.find<CreatePostController>().createPostSellCategoryList) {
      if (privacy.id == id) {
        return privacy.name;
      }
    }
    return null;
  }

  final RxString postSelectedAction = RxString("");
  final RxString postAudienceAction = RxString("");
  final RxInt temporaryselectedAudienceId = RxInt(-1);
  final RxInt selectedAudienceId = RxInt(-1);

  IconData privacyIcon(int? isPublic) {
    if (isPublic == 0) {
      return BipHip.lock;
    }
    if (isPublic == 1) {
      return BipHip.world;
    }
    if (isPublic == 2) {
      return BipHip.friends;
    }
    if (isPublic == 3) {
      return BipHip.addFamily;
    } else {
      return BipHip.removeFamily;
    }
  }

  String privacyText(int? isPublic) {
    if (isPublic == 0) {
      return "Only me";
    }
    if (isPublic == 1) {
      return "Public";
    }
    if (isPublic == 2) {
      return "Friends";
    }
    if (isPublic == 3) {
      return "Families";
    } else {
      return "Friend & Family";
    }
  }

  final RxBool editDateBottomSheetRightButtonState = RxBool(false);
  final RxString tempEditDate = RxString('');
  final RxString editDate = RxString('');
  final RxString postDate = RxString('');

  void editPostDate({required BuildContext context, required int postId, required int postIndex}) {
    tempEditDate.value = '';
    if (tempEditDate.value == '') {
      editDateBottomSheetRightButtonState.value = false;
    }
    commonBottomSheet(
      isBottomSheetRightButtonActive: editDateBottomSheetRightButtonState,
      context: context,
      onPressCloseButton: () {
        Get.back();
      },
      onPressRightButton: () {
        Get.back();
        editDate.value = tempEditDate.value;
        postEditDate(
          postId: postId,
          date: editDate.value,
        );
        commonPostList[postIndex].dateTime = DateTime.parse(editDate.value);
        commonPostList.replaceRange(postIndex, postIndex + 1, [commonPostList[postIndex]]);
      },
      rightText: ksDone.tr,
      rightTextStyle: semiBold14TextStyle(cPrimaryColor),
      title: "Edit date".tr,
      isRightButtonShow: true,
      content: SizedBox(
        height: height * 0.4,
        child: CupertinoDatePicker(
          minimumDate: DateTime(1900),
          maximumDate: DateTime.now(),
          use24hFormat: true,
          // initialDateTime: createPostController.biddingEndDate.value != ''
          //     ? DateTime.parse(createPostController.biddingEndDate.value)
          //     : DateTime.parse(createPostController.biddingStartDate.value),
          initialDateTime: DateTime.parse(postDate.value),
          mode: CupertinoDatePickerMode.dateAndTime,
          onDateTimeChanged: (value) {
            editDateBottomSheetRightButtonState.value = true;
            tempEditDate.value = DateFormat("yyyy-MM-dd HH:mm:ss").format(value);
          },
        ),
      ),
    );
  }

  //*Post Notification off Api implement
  RxBool isPostNotificationOffLoading = RxBool(false);
  Future<void> postNotificationOff({required int postId}) async {
    try {
      isPostNotificationOffLoading.value = true;
      String? token = await SpController().getBearerToken();
      Map<String, dynamic> body = {};
      var response = await ApiController().commonApiCall(
        requestMethod: kPost,
        url: "$kuPostNotificationOff/${postId.toString()}",
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        for (int i = 0; i < commonPostList.length; i++) {
          if (commonPostList[i].id == postId) {
            commonPostList[i].isNotifaction = false;
          }
        }
        isPostNotificationOffLoading.value = false;
        showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isPostNotificationOffLoading.value = false;
        if (errorModel.errors.isEmpty) {
          showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isPostNotificationOffLoading.value = false;
      ll('postNotificationOff error: $e');
    }
  }

  //*Post Notification off Api implement
  Future<void> postNotificationOn({required int postId}) async {
    try {
      isPostNotificationOffLoading.value = true;
      String? token = await SpController().getBearerToken();
      Map<String, dynamic> body = {};
      var response = await ApiController().commonApiCall(
        requestMethod: kPost,
        url: "$kuPostNotificationOn/${postId.toString()}",
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        for (int i = 0; i < commonPostList.length; i++) {
          if (commonPostList[i].id == postId) {
            commonPostList[i].isNotifaction = true;
          }
        }
        isPostNotificationOffLoading.value = false;
        showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isPostNotificationOffLoading.value = false;
        if (errorModel.errors.isEmpty) {
          showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isPostNotificationOffLoading.value = false;
      ll('postNotificationOff error: $e');
    }
  }

//*Update Date Time Api implement

  Future<void> postEditDate({required int postId, required String date}) async {
    try {
      isPostNotificationOffLoading.value = true;
      String? token = await SpController().getBearerToken();
      Map<String, dynamic> body = {
        "id": postId.toString(),
        "date_time": date.toString(),
      };
      var response = await ApiController().commonApiCall(
        requestMethod: kPost,
        url: kuEditDateTime,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        isPostNotificationOffLoading.value = false;
        showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isPostNotificationOffLoading.value = false;
        if (errorModel.errors.isEmpty) {
          showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isPostNotificationOffLoading.value = false;
      ll('postEditDate error: $e');
    }
  }

  final RxInt reportId = RxInt(-1);
  final RxInt selectedReportIndex = RxInt(-1);
  final RxBool reportBottomSheetState = RxBool(false);
  //   //*Get Report  List Api Call
  final Rx<ReportListModel?> reportListData = Rx<ReportListModel?>(null);
  final RxList<Report> reportList = RxList<Report>([]);
  final RxBool isReportListLoading = RxBool(false);
  Future<void> getReportList() async {
    try {
      isReportListLoading.value = true;
      String? token = await SpController().getBearerToken();
      var response = await ApiController().commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetReoportList,
      ) as CommonDM;
      if (response.success == true) {
        reportList.clear();
        reportListData.value = ReportListModel.fromJson(response.data);
        reportList.addAll(reportListData.value!.reports);
        isReportListLoading.value = false;
      } else {
        isReportListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isReportListLoading.value = true;
      ll('getReportList error: $e');
    }
  }

  Future<void> postReportAndUndoReport(int? reportId, String? reason, {required String reportOrUndo, required int postId}) async {
    try {
      isPostNotificationOffLoading.value = true;
      String? token = await SpController().getBearerToken();
      Map<String, dynamic> body = {
        "post_id": postId.toString(),
        if (reportOrUndo == "report") "report_id": reportId.toString(),
        if (reportOrUndo == "report" && reason != null) "reason": null,
      };
      var response = await ApiController().commonApiCall(
        requestMethod: kPost,
        url: reportOrUndo == "report" ? kuPostReport : kuUndoPostReport,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        if (reportOrUndo == "report") {
          for (int i = 0; i < commonPostList.length; i++) {
            if (commonPostList[i].id == postId) {
              commonPostList[i].hasReport = true;
            }
          }
        } else {
          for (int i = 0; i < commonPostList.length; i++) {
            if (commonPostList[i].id == postId) {
              commonPostList[i].hasReport = false;
            }
          }
        }
        isPostNotificationOffLoading.value = false;
        showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isPostNotificationOffLoading.value = false;
        if (errorModel.errors.isEmpty) {
          showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isPostNotificationOffLoading.value = false;
      ll('postEditDate error: $e');
    }
  }

  //*Edit Audience Api call
  final RxBool isEditAudienceLoading = RxBool(false);
  Future<void> editAudience(int postId) async {
    try {
      isEditAudienceLoading.value = true;
      String? token = await SpController().getBearerToken();
      Map<String, dynamic> body = {
        "post_id": postId.toString(),
        "is_public": selectedAudienceId.value.toString(),
      };
      var response = await ApiController().commonApiCall(
        requestMethod: kPost,
        url: kuEditAudience,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        isEditAudienceLoading.value = false;
        selectedAudienceId.value = -1;
        showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isEditAudienceLoading.value = false;
        if (errorModel.errors.isEmpty) {
          showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isEditAudienceLoading.value = false;
      ll('editAudience error: $e');
    }
  }

  // //*Delete Post Api Call
  final RxBool isDeletePostLoading = RxBool(false);
  Future<void> postDelete({required int postId}) async {
    try {
      isDeletePostLoading.value = true;
      String? token = await SpController().getBearerToken();
      Map<String, dynamic> body = {};
      var response = await ApiController().commonApiCall(
        requestMethod: kDelete,
        url: '$kuDeletePost/${postId.toString()}',
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        commonPostList.removeWhere((post) => post.id == postId);
        isDeletePostLoading.value = false;
        showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isDeletePostLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isDeletePostLoading.value = false;
      ll('postDelete error: $e');
    }
  }

  final RxList<Map<String, dynamic>> privacyList = RxList([
    {'icon': BipHip.lock, 'action': 'Only me', 'id': 0},
    {'icon': BipHip.world, 'action': 'Public', 'id': 1},
    {'icon': BipHip.friends, 'action': 'Friends', 'id': 2},
    {'icon': BipHip.addFamily, 'action': 'Families', 'id': 3},
    {'icon': BipHip.addFamily, 'action': 'Friends & Families', 'id': 4},
  ]);

  //*Hide Post Api implement
  RxBool isHidePostLoading = RxBool(false);
  Future<void> hidePost({required int postId}) async {
    try {
      isHidePostLoading.value = true;
      String? token = await SpController().getBearerToken();
      Map<String, dynamic> body = {};
      var response = await ApiController().commonApiCall(
        requestMethod: kPost,
        url: "$kuHidePost/${postId.toString()}",
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        commonPostList.removeWhere((post) => post.id == postId);
        isHidePostLoading.value = false;
        showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isHidePostLoading.value = false;
        if (errorModel.errors.isEmpty) {
          showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isHidePostLoading.value = false;
      ll('hidePost error: $e');
    }
  }

  final RxBool isFollowUnfollowLoading = RxBool(false);

  //*Unfollow User
  Future<void> followUnfollowUser({required int userId, required String followOrUnfollow}) async {
    try {
      isFollowUnfollowLoading.value = true;
      String? token = await SpController().getBearerToken();
      Map<String, dynamic> body = {
        'user_id': userId.toString(),
      };
      var response = await ApiController().commonApiCall(
        requestMethod: kPost,
        url: followOrUnfollow == "Follow" ? kuFollowUser : kuUnFollowUser,
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        if (followOrUnfollow == "Follow") {
          for (int i = 0; i < commonPostList.length; i++) {
            if (userId == commonPostList[i].user!.id) {
              commonPostList[i].user!.followStatus = 1;
            }
          }
        } else {
          for (int i = 0; i < commonPostList.length; i++) {
            if (userId == commonPostList[i].user!.id) {
              commonPostList[i].user!.followStatus = 0;
            }
          }
        }
        if (followOrUnfollow == "Follow") {}
        isFollowUnfollowLoading.value = false;
        showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isFollowUnfollowLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isFollowUnfollowLoading.value = false;
      ll('followUnfollowUser error: $e');
    }
  }

  RxList<Map<String, dynamic>> allConnectedPeers = RxList<Map<String, dynamic>>([]);
  void socketInit() {
    ll("Connecting...");

    socket.connect();

    socket.on('connect', (_) {
      ll('Connected: ${socket.id}');
    });

    socket.on('mobile-chat-channel', (data) {
      ll('Received peer data: $data');
      populatePeerList(data);
      Get.find<MessengerController>().connectWithPeer(data["peerID"]);
      ll("All connections: $allConnectedPeers");
    });

    socket.on("mobile-chat-peer-exchange-${userId.value}", (data) {
      ll('Received peer exchange ID: $data');
      int index = allConnectedPeers.indexWhere((user) => user['peerID'] == data["peerID"]);
      if (index == -1) {
        Get.find<MessengerController>().connectWithPeer(data["peerID"]);
      } else {
        populatePeerList(data);
        Get.find<MessengerController>().connectWithPeer(data["peerID"]);
      }
    });

    socket.on('disconnect', (_) {
      ll('Disconnected');
    });

    socket.on('error', (error) {
      ll('Socket error: $error');
    });
  }

  void populatePeerList(Map<String, dynamic> newUserData) {
    int index = allConnectedPeers.indexWhere((user) => user['userID'] == newUserData['userID']);
    Get.find<MessengerController>().connectedUserID.add(newUserData['userID']);
    if (index != -1) {
      allConnectedPeers[index]['peerID'] = newUserData['peerID'];
    } else {
      allConnectedPeers.add(newUserData);
    }
  }
  //! end
}
