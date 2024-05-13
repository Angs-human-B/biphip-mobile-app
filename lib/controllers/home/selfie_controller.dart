import 'dart:io';

import 'package:bip_hip/utils/constants/imports.dart';
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
  final RxInt selectedPrivacyId = RxInt(-1);
  final RxInt temporarySelectedPrivacyId = RxInt(-1);

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
    selectedPrivacyId.value = -1;
    isSelectPeopleCrossShow.value = false;
    selectPeopleTextEditingController.clear();
  }

  StoryController storyController = StoryController();
  PageController pageController = PageController();
  void handleCompleted() {
    //     final initialPage = allStories.indexOf(allStories);
    // pageController = PageController(initialPage: initialPage);
    // addStoryItems();
    pageController.nextPage(
      duration: const Duration(milliseconds: 10),
      curve: Curves.easeIn,
    );
    final currentIndex = allStories.indexOf(allStories);
    final isLastPage = allStories.length - 1 == currentIndex;
    if (isLastPage) {
      Get.back();
    }
  }
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
//   allStories.forEach((story, index) {
//     storyItems.add(StoryItem.pageImage(url: story["storyImage"], controller: storyController));
//   });
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
      // ll(allStories.length);
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
}

class User {
  final String name;
  final String imgUrl;
  final List<Story> stories;

  const User({
    required this.name,
    required this.imgUrl,
    required this.stories,
  });
}

class Story {
  final String url;
  final double duration;
  final String caption;
  final String date;
  final Color color;

  Story({
    required this.caption,
    required this.date,
    required this.url,
    this.duration = 5.0,
    this.color = Colors.grey,
  });
}
