import 'dart:io';

import 'package:bip_hip/models/home/selfie/selfie_common_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:story_view/story_view.dart';

class SelfieController extends GetxController {
  final ApiController apiController = ApiController();
  final SpController spController = SpController();
  final GlobalController globalController = Get.find<GlobalController>();

  final RxString selfieImageLink = RxString('');
  final Rx<File> selfieImageFile = File('').obs;
  final RxBool isSelfieImageChanged = RxBool(false);
  final RxBool isTextFieldShow = RxBool(false);
  final RxBool isColorsShow = RxBool(false);
  final TextEditingController selfieTextEditingController = TextEditingController();
  final TextEditingController selectPeopleTextEditingController = TextEditingController();
  final RxBool isSelectPeopleCrossShow = RxBool(false);
  final RxString selfieText = RxString("");
  final RxInt allSelfieListIndex = RxInt(0);

  final Rx<Color> textSelectedColor = Rx<Color>(cWhiteColor);
  void customoOnInit() async {
    // await getFriendSelfieList();
    // allSelfieData();
    x.value = width * 0.4;
    y.value = height * 0.5;
    final initialPage = allSelfieList.indexOf(allSelfieList[allSelfieListIndex.value]);
    ll(initialPage);
    pageController = PageController(initialPage: 0);
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final Rx<double> x = Rx<double>(1.0);
  final Rx<double> y = Rx<double>(1.0);

  final RxString selectedPrivacy = RxString("");
  final RxInt selectedPrivacyId = RxInt(1);
  final RxInt temporarySelectedPrivacyId = RxInt(1);
  final Rx<IconData> temporarySelectedPrivacyIcon = Rx<IconData>(BipHip.world);
  final Rx<IconData> selectedPrivacyIcon = Rx<IconData>(BipHip.world);

  final RxList<bool> isCustomPeopleSelected = RxList<bool>([]);
  final RxList customPeopleNames = RxList([]);
  final RxList customPeopleIds = RxList([]);

  void resetSelfieData() {
    selfieTextEditingController.clear();
    isCustomPeopleSelected.clear();
    customPeopleNames.clear();
    customPeopleIds.clear();
    selfieImageLink.value = "";
    selfieImageFile.value = File("");
    isSelfieImageChanged.value = false;
    isTextFieldShow.value = false;
    isColorsShow.value = false;
    textSelectedColor.value = cWhiteColor;
    selfieText.value = "";
    selectedPrivacy.value = "";
    selectedPrivacyId.value = 1;
    temporarySelectedPrivacyId.value = 1;
    isSelectPeopleCrossShow.value = false;
    selectPeopleTextEditingController.clear();
    selectedPrivacyIcon.value = BipHip.world;
    temporarySelectedPrivacyIcon.value = BipHip.world;
  }

  void allSelfieData() {
    allSelfieList.clear();
    if (mySelfieList.isNotEmpty) {
      allSelfieList.add({
        "userId": globalController.userId.value,
        "userName": globalController.userName.value,
        "userImage": globalController.userImage.value,
        "selfies": mySelfieList,
      });
    }
    for (int i = 0; i < friendSelfiesList.length; i++) {
      allSelfieList.add({
        "userId": friendSelfiesList[i].id,
        "userName": friendSelfiesList[i].fullName,
        "userImage": friendSelfiesList[i].profilePicture,
        "followStatus": friendSelfiesList[i].followStatus,
        "selfies": friendSelfiesList[i].currentSelfies
      });
    }

    // for (int i = 0; i < allSelfieList.length; i++) {
    //   for (int k = 0; k < allSelfieList[i]["selfies"].length; k++) {
    //     ll(allSelfieList[i]["selfies"][k].fullPath);
    //   }
    // }
  }

  void handleCompleted() {
    // ll(allSelfieListIndex.value);
    int currentIndex = allSelfieList.indexOf(allSelfieList[allSelfieListIndex.value]);
    addStoryItems(allSelfieList[allSelfieListIndex.value]["selfies"]);
    pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );

    final isLastPage = allSelfieList.length - 1 == currentIndex;
    if (isLastPage) {
      Get.back();
    }
  }

  final RxInt selfieId = RxInt(-1);
  final RxInt currentSelfieIndex = RxInt(-1);
  final RxInt selectedReportIndex = RxInt(-1);
  final RxInt reportId = RxInt(-1);
  final RxBool reportBottomSheetState = RxBool(false);
  ScreenshotController screenshotController = ScreenshotController();
  StoryController storyController = StoryController();
  PageController pageController = PageController();

  List<StoryItem> addStoryItems(List<Selfy> selfieList) {
    List<StoryItem> storyItems = <StoryItem>[];
    for (int i = 0; i < selfieList.length; i++) {
      storyItems.add(StoryItem.pageImage(
        url: selfieList[i].fullPath!,
        controller: storyController,
      ));
    }
    // ll(storyItems[0].shown);
    return storyItems;
  }

  final RxList<Map<String, dynamic>> privacyList = RxList([
    {'icon': BipHip.world, 'action': 'Public', 'id': 1},
    {'icon': BipHip.friends, 'action': 'Friends', 'id': 2},
    {'icon': BipHip.addFamily, 'action': 'Families', 'id': 3},
    {'icon': BipHip.addFamily, 'action': 'Friends & Families', 'id': 4},
    {'icon': BipHip.unfriend, 'action': 'Custom', 'id': 5},
  ]);

  final List colorList = [
    {"color": "White", "colorCode": cWhiteColor},
    {"color": "Black", "colorCode": cBlackColor},
    {"color": "Blue", "colorCode": cPrimaryColor},
    {"color": "Green", "colorCode": cGreenColor},
    {"color": "Red", "colorCode": cRedColor},
    {"color": "Bidding", "colorCode": cBiddingColor},
    {"color": "Category", "colorCode": cCategoryColor},
    {"color": "DarkRed", "colorCode": cDarkRedColor},
    {"color": "Pink", "colorCode": cPinkColor},
    {"color": "AmberAccent", "colorCode": cAmberAccentColor},
  ];

  final Rx<File> selfieFile = File('').obs;

  Future<String> saveScreenshot(Uint8List bytes) async {
    await [Permission.storage].request();
    const String name = "Screenshot";
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    ll(result['filePath']);
    return result['filePath'];
  }

  final RxList<Map<String, dynamic>> allSelfieList = RxList<Map<String, dynamic>>([]);

  //*Report Selfie
  final RxBool isReportSelfieLoading = RxBool(false);
  Future<void> reportSelfie(String? reason) async {
    try {
      isReportSelfieLoading.value = true;
      String? token = await SpController().getBearerToken();
      Map<String, dynamic> body = {
        "selfie_id": selfieId.toString(),
        "report_id": reportId.toString(),
        "reason": reason,
      };
      var response = await ApiController().commonApiCall(
        requestMethod: kPost,
        url: kuReportSelfie,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        isReportSelfieLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isReportSelfieLoading.value = false;
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isReportSelfieLoading.value = false;
      ll('reportSelfie error: $e');
    }
  }

  //*Scroll controller for pagination
  final ScrollController friendSelfieListScrollController = ScrollController();

  //*Friend List Api Call
  final Rx<SelfieCommonModel?> selfieListData = Rx<SelfieCommonModel?>(null);
  final RxList<Selfy> mySelfieList = RxList<Selfy>([]);
  final RxList<FriendSelfieData> friendSelfiesList = RxList<FriendSelfieData>([]);
  final Rx<String?> friendSelfieListSubLink = Rx<String?>(null);
  final RxBool friendSelfieListScrolled = RxBool(false);
  final RxBool isFriendSelfieListLoading = RxBool(false);
  Future<void> getFriendSelfieList() async {
    try {
      isFriendSelfieListLoading.value = true;
      String suffixUrl = '?take=15';
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetFriendSelfie + suffixUrl,
      ) as CommonDM;
      if (response.success == true) {
        mySelfieList.clear();
        friendSelfiesList.clear();
        friendSelfieListScrolled.value = false;
        selfieListData.value = SelfieCommonModel.fromJson(response.data);
        mySelfieList.addAll(selfieListData.value!.mySelfies);
        friendSelfiesList.addAll(selfieListData.value!.friendSelfies!.data);
        allSelfieData();
        friendSelfieListSubLink.value = selfieListData.value!.friendSelfies!.nextPageUrl;
        if (friendSelfieListSubLink.value != null) {
          friendSelfieListScrolled.value = false;
        } else {
          friendSelfieListScrolled.value = true;
        }

        isFriendSelfieListLoading.value = false;
      } else {
        isFriendSelfieListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isFriendSelfieListLoading.value = true;
      ll('getFriendSelfieList error: $e');
    }
  }

  //*Get More Friend List for pagination
  Future<void> getMoreFriendSelfieList(take) async {
    try {
      String? token = await spController.getBearerToken();
      dynamic friendSelfieListSub;

      if (friendSelfieListSubLink.value == null) {
        return;
      } else {
        friendSelfieListSub = friendSelfieListSubLink.value!.split('?');
      }

      String friendListSuffixUrl = '';

      friendListSuffixUrl = '?${friendSelfieListSub[1]}&take=15';

      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetFriendSelfie + friendListSuffixUrl,
      ) as CommonDM;

      if (response.success == true) {
        friendSelfieListSubLink.value = selfieListData.value!.friendSelfies!.nextPageUrl;
        if (friendSelfieListSubLink.value != null) {
          friendSelfieListScrolled.value = false;
        } else {
          friendSelfieListScrolled.value = true;
        }

        isFriendSelfieListLoading.value = false;
      } else {
        isFriendSelfieListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isFriendSelfieListLoading.value = true;
      ll('getMoreFriendSelfieList error: $e');
    }
  }

  //* Store selfie API Implementation
  final RxBool isSelfieLoading = RxBool(false);
  Future<void> storeSelfie() async {
    List customIds = [];
    for (int i = 0; i < customPeopleIds.length; i++) {
      customIds.add(customPeopleIds[i]);
    }
    ll(customIds);
    try {
      isSelfieLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, String> body = {
        "privacy": selectedPrivacyId.value.toString(),
        if (selectedPrivacyId.value == 5) "private_ids": customIds.join(','),
      };
      ll("Store selfie $body");
      var response = await apiController.mediaUpload(
        url: kuStoreSelfie,
        token: token,
        body: body,
        key: 'image',
        value: selfieFile.value.path,
      ) as CommonDM;

      if (response.success == true) {
        await getFriendSelfieList();

        Get.back();
        isSelfieLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isSelfieLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isSelfieLoading.value = false;
      ll('storeSelfie error: $e');
    }
  }

  //*Delete Selfie history Api Call
  final RxBool isDeleteSelfie = RxBool(false);
  Future<void> deleteSelfie({required int selfieId}) async {
    try {
      isDeleteSelfie.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiController.commonApiCall(
        requestMethod: kDelete,
        url: '$kuDeleteSelfie/${selfieId.toString()}',
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        Get.back();
        await getFriendSelfieList();
        isDeleteSelfie.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isDeleteSelfie.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isDeleteSelfie.value = false;
      ll('deleteSearchHistory error: $e');
    }
  }

  //*Unfollow User
  final RxBool isFollowUnfollowLoading = RxBool(false);
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
          for (int i = 0; i < allSelfieList.length; i++) {
            if (userId == allSelfieList[i]["userId"]) {
              allSelfieList[allSelfieListIndex.value]["followStatus"] = 1;
            }
          }
        } else {
          for (int i = 0; i < allSelfieList.length; i++) {
            if (userId == allSelfieList[i]["userId"]) {
              allSelfieList[allSelfieListIndex.value]["followStatus"] = 0;
            }
          }
        }
        if (followOrUnfollow == "Follow") {}
        isFollowUnfollowLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isFollowUnfollowLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isFollowUnfollowLoading.value = false;
      ll('followUnfollowUser error: $e');
    }
  }

  String customUserName() {
    if (customPeopleNames.length <= 2) {
      return customPeopleNames.join(", ");
    } else {
      List temporaryCustomPeopleName = [];
      for (int i = 0; i < 2; i++) {
        temporaryCustomPeopleName.add(customPeopleNames[i]);
      }
      return "${temporaryCustomPeopleName.join(", ")} & ${customPeopleNames.length - 2} others";
    }
  }

  IconData privacyIcon(int? isPublic) {
    if (isPublic == 1) {
      return BipHip.world;
    }
    if (isPublic == 2) {
      return BipHip.friends;
    }
    if (isPublic == 3) {
      return BipHip.addFamily;
    }
    if (isPublic == 4) {
      return BipHip.removeFamily;
    } else {
      return BipHip.add;
    }
  }

  final TextEditingController giftAddCommentTextEditingController = TextEditingController();
  final RxBool isGiftAddCommentSuffixIconVisible = RxBool(false);
  final RxInt selectedBadgeId = RxInt(-1);

  //*Report Selfie
  final RxBool isSelfieSendGiftLoading = RxBool(false);
  Future<void> sendGiftSelfie() async {
    try {
      isSelfieSendGiftLoading.value = true;
      String? token = await SpController().getBearerToken();
      Map<String, dynamic> body = {
        "selfie_id": selfieId.toString(),
        "badge_id": selectedBadgeId.value.toString(),
      };
      var response = await ApiController().commonApiCall(
        requestMethod: kPost,
        url: kuSelfieSendGift,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        isSelfieSendGiftLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isSelfieSendGiftLoading.value = false;
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isSelfieSendGiftLoading.value = false;
      ll('postEditDate error: $e');
    }
  }
}

// class AllSelfieData {
//   final int userId;
//   final String userName;
//   final String userImage;
//   final List<Selfy> selfies;

//   const AllSelfieData({
//     required this.userId,
//     required this.userName,
//     required this.userImage,
//     required this.selfies,
//   });
// }

// class Story {
//   final String url;
//   final double duration;
//   final String caption;
//   final String date;
//   final Color color;

//   Story({
//     required this.caption,
//     required this.date,
//     required this.url,
//     this.duration = 5.0,
//     this.color = Colors.grey,
//   });
// }
