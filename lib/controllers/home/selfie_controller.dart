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

  final Rx<Color> textSelectedColor = Rx<Color>(cWhiteColor);
  // final RxList<bool> isPeopleSelect = RxList<bool>[(false)];
  void customoOnInit() {
    x.value = width * 0.4;
    y.value = height * 0.5;
    final initialPage = allStories.indexOf(allStories);
    pageController = PageController(initialPage: initialPage);
    addStoryItems();
    ll(allStories.length);
    ll(initialPage);
    ll(pageController);
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  // @override
  // void dispose() {
  //   pageController.dispose();
  //   storyController.dispose();
  //   super.dispose();
  // }

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

  void handleCompleted() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 10),
      curve: Curves.linear,
    );
    final currentIndex = allStories.indexOf(allStories.first);
    final isLastPage = allStories.length - 1 == currentIndex;
    if (isLastPage) {
      Get.back();
    }
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

  final storyItems = <StoryItem>[];

  void addStoryItems() {
    for (int i = 0; i < allStories.length; i++) {
      storyItems.add(StoryItem.pageImage(url: allStories[i]["storyImage"], controller: storyController));
    }
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

  // kuGetFriendSelfie

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

      // if (isCommentImageChanged.value != true) {
      //  var response = await apiController.commonApiCall(
      //     requestMethod: kPost,
      //     url: kuStoreSelfie,
      //     body: body,
      //     token: token,
      //   ) as CommonDM;
      // } else {
      var response = await apiController.mediaUpload(
        url: kuStoreSelfie,
        token: token,
        body: body,
        key: 'image',
        value: selfieFile.value.path,
      ) as CommonDM;
      ll("Store selfie $response");

      if (response.success == true) {
        // commentId.value = -1;
        // commentMentionList.clear();
        // isCommentImageChanged.value = false;
        // commentMentionKey.currentState?.controller?.text = "";
        // commentImageLink.value = "";
        // commentImageFile.value = File("");
        // isCommentSendEnable.value = false;
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

// class User {
//   final String name;
//   final String imgUrl;
//   final List<Story> stories;

//   const User({
//     required this.name,
//     required this.imgUrl,
//     required this.stories,
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
