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
  final RxInt allSelfieListIndex = RxInt(-1);

  final Rx<Color> textSelectedColor = Rx<Color>(cWhiteColor);
  void customoOnInit() async {
    await getFriendSelfieList();
    allSelfieData();
    x.value = width * 0.4;
    y.value = height * 0.5;
    final initialPage = allSelfieList.indexOf(allSelfieList);
    pageController = PageController(initialPage: initialPage);
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final Rx<double> x = Rx<double>(1.0);
  final Rx<double> y = Rx<double>(1.0);
  final RxList<bool> isPeopleSelected = RxList<bool>([]);

  final RxString selectedPrivacy = RxString("");
  final RxInt selectedPrivacyId = RxInt(1);
  final RxInt temporarySelectedPrivacyId = RxInt(1);

  void resetSelfieData() {
    selfieTextEditingController.clear();
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
  }

  // void storeAllSelfieData() {
  //   // allSelfieList.value = [
  //   //   AllSelfieData(
  //   //     userId: globalController.userId.value!,
  //   //     userName: globalController.userName.value!,
  //   //     userImage: globalController.userImage.value!,
  //   //     selfies: mySelfieList,
  //   //   ),
  //   //    AllSelfieData(
  //   //     userId: friendSelfiesList,
  //   //     userName: globalController.userName.value!,
  //   //     userImage: globalController.userImage.value!,
  //   //     selfies: friendSelfiesList,
  //   //   ),
  //   // ];
  // }

  void allSelfieData() {
    allSelfieList.clear();
    allSelfieList.add({
      "userId": globalController.userId.value,
      "userName": globalController.userName.value,
      "userImage": globalController.userImage.value,
      "selfies": mySelfieList,
    });
    for (int i = 0; i < friendSelfiesList.length; i++) {
      allSelfieList.add({
        "userId": friendSelfiesList[i].id,
        "userName": friendSelfiesList[i].fullName,
        "userImage": friendSelfiesList[i].profilePicture,
        "selfies": friendSelfiesList[i].currentSelfies
      });
    }

    for (int i = 0; i < allSelfieList.length; i++) {
      for (int k = 0; k < allSelfieList[i]["selfies"].length; k++) {
        ll(allSelfieList[i]["selfies"][k].fullPath);
      }
    }
  }

  ScreenshotController screenshotController = ScreenshotController();
  StoryController storyController = StoryController();
  PageController pageController = PageController();
  // void handleCompleted() {
  //   //     final initialPage = allStories.indexOf(allStories);
  //   // pageController = PageController(initialPage: initialPage);
  //   // addStoryItems();
  //   pageController.nextPage(
  //     duration: const Duration(milliseconds: 10),
  //     curve: Curves.linear,
  //   );
  //   final currentIndex = allStories.indexOf(allStories);
  //   final isLastPage = allStories.length - 1 == currentIndex;
  //   if (isLastPage) {
  //     Get.back();
  //   }
  // }

  // void handleCompleted() {
  //   pageController.nextPage(
  //     duration: const Duration(milliseconds: 10),
  //     curve: Curves.linear,
  //   );
  //   final currentIndex = allStories.indexOf(allStories.first);
  //   final isLastPage = allStories.length - 1 == currentIndex;
  //   if (isLastPage) {
  //     Get.back();
  //   }
  // }
  void startNextStory() {
    addStoryItems(allSelfieList[0]["selfies"]);
  }

  void showSelfiesAtIndex(int index) {
    // Add the selfies from the specified index
    addStoryItems(allSelfieList[index]["selfies"]);

    // Start showing the selfies (assuming you have a function to start the story view)
    // startStoryView();
    Get.toNamed(krSelfieViewPage);
  }

  void playNextSelfieSet() {
    // Update the storyItems
    // storyItems.addAll(allSelfieList[allSelfieListIndex.value]["selfies"]);
    addStoryItems(allSelfieList[allSelfieListIndex.value]["selfies"]);
  }

  void handleCompleted() {
    // ll("SCREAM");
    // pageController.nextPage(
    //   duration: const Duration(milliseconds: 300),
    //   curve: Curves.ease,
    // );

    // final currentIndex = allSelfieList.indexOf(allSelfieList.first);
    // final isLastPage = allSelfieList.length - 1 == currentIndex;
    // if (isLastPage) {
    //   Get.offAllNamed(krHome); // Suggested change
    // }
  }

  // void handleCompleted() {
  //   final currentIndex = allStories.indexOf(allStories.first);
  //   final isLastPage = allStories.length - 1 == currentIndex;
  //   if (isLastPage) {
  //     Get.back();
  //   } else {
  //     pageController.nextPage(
  //       duration: const Duration(milliseconds: 10),
  //       curve: Curves.linear,
  //     );
  //   }
  // }

  // void handleCompleted() {
  //   // Assuming you have a way to access the current page index
  //   int currentPageIndex = pageController.page?.round() ?? 1;

  //   pageController.nextPage(
  //     duration: const Duration(milliseconds: 1000),
  //     curve: Curves.easeIn,
  //   );

  //   final isLastPage = allStories.length - 1 == currentPageIndex;
  //   if (isLastPage) {
  //     Get.back();
  //   }
  // }

  // var stories = [
  //   StoryItem.pageImage(
  //     url: 'https://impulse.aarafacademy.com/uploads/samples/g1.jpg',
  //     controller: StoryController(),
  //   ),
  //   StoryItem.pageImage(
  //     url: 'https://cdn.vectorstock.com/i/preview-2x/95/78/young-female-doctor-in-medical-uniform-vector-36659578.webp',
  //     controller: StoryController(),
  //   ),
  // ];

  // final storyItems = <StoryItem>[];
  // void addStoryItems() {
  //   for (final story in allStories) {
  //     storyItems.add(StoryItem.pageImage(url: story["storyImage"], controller: storyController));
  //   }
  // }
// final storyItems = <StoryItem>[];

// void addStoryItems() {
//   allStories.asMap().forEach((index, story) {
//     storyItems.add(StoryItem.pageImage(url: story["storyImage"], controller: storyController));
//   });
// }

  List<StoryItem> addStoryItems(List<Selfy> selfieList) {
    List<StoryItem> storyItems = <StoryItem>[];
    for (int i = 0; i < selfieList.length; i++) {
      storyItems.add(StoryItem.pageImage(
        url: selfieList[i].fullPath!,
        controller: storyController,
      ));
    }
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

  //*Scroll controller for pagination
  final ScrollController friendListScrollController = ScrollController();

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

  //* post Reaction API Implementation
  final RxBool isSelfieLoading = RxBool(false);
  Future<void> storeSelfie() async {
    try {
      isSelfieLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, String> body = {
        "privacy": selectedPrivacyId.value.toString(),
        // "private_ids": //*for custom privacy selfie
      };
      var response = await apiController.mediaUpload(
        url: kuStoreSelfie,
        token: token,
        body: body,
        key: 'image',
        value: selfieFile.value.path,
      ) as CommonDM;
      ll("Store selfie $response");

      if (response.success == true) {
        // commentMentionList.clear();
        // isCommentImageChanged.value = false;
        // commentMentionKey.currentState?.controller?.text = "";
        // commentImageLink.value = "";
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
