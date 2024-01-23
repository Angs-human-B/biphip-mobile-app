import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter_svg/svg.dart';

class PostReactionController extends GetxController with GetSingleTickerProviderStateMixin {
  final RxInt selectedBidIndex = RxInt(-1);
  final RxInt selectedGiftIndex = RxInt(-1);
  final RxInt balance = RxInt(200);
  final TextEditingController bidingTextEditingController = TextEditingController();
  final TextEditingController giftTextEditingController = TextEditingController();
  final TextEditingController commentTextEditingController = TextEditingController();
  final RxBool isPackageSelected = RxBool(false);
  final Rx<Map?> selectedPackage = Rx<Map?>(null);
  final RxBool giftCheckBox = RxBool(false);
  final RxList gift1 = RxList([]);
  final RxInt badgeCount1 = RxInt(0);
  final RxInt badgeCount2 = RxInt(0);
  final RxInt badgeCount3 = RxInt(0);
  final RxInt badgeCount4 = RxInt(0);
  final RxInt tabIndex = RxInt(-1);
  late TabController tabController;
  final Rx<int?> yourBid = Rx<int?>(null);
  final RxBool showMoreBiddingInsights = RxBool(true);

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
      length: 6,
      animationDuration: Duration.zero,
      vsync: this,
    );
    tabController.addListener(() {
      giftFilter(tabController.index);
    });
  }

  void clearBadgeCount() {
    badgeCount1.value = 0;
    badgeCount2.value = 0;
    badgeCount3.value = 0;
    badgeCount4.value = 0;
  }

  void giftFilter(index) {
    gift1.clear();
    clearBadgeCount();
    for (int i = 0; i < giftContributors.length; i++) {
      if (giftContributors[i]['giftType'] == 'badge1') {
        badgeCount1.value++;
      } else if (giftContributors[i]['giftType'] == 'badge2') {
        badgeCount2.value++;
      } else if (giftContributors[i]['giftType'] == 'badge3') {
        badgeCount3.value++;
      } else if (giftContributors[i]['giftType'] == 'badge4') {
        badgeCount4.value++;
      }
    }
    for (int i = 0; i < giftContributors.length; i++) {
      if (index == 0) {
        gift1.add(giftContributors[i]);
      } else if (giftContributors[i]['giftType'] == 'badge1' && index == 1) {
        gift1.add(giftContributors[i]);
      } else if (giftContributors[i]['giftType'] == 'badge2' && index == 2) {
        gift1.add(giftContributors[i]);
      } else if (giftContributors[i]['giftType'] == 'badge3' && index == 3) {
        gift1.add(giftContributors[i]);
      } else if (giftContributors[i]['giftType'] == 'badge4' && index == 4) {
        gift1.add(giftContributors[i]);
      }
    }
  }

  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController mmyyStarController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final RxBool giftAgreeCheckBox = RxBool(false);
  final RxList reactEmojiList = RxList([]);

  List reactionView(map) {
    map.remove('All');
    reactEmojiList.clear();
    List<MapEntry<String, dynamic>> entries = map.entries.toList();
    ll(entries);
    if (entries.length > 1) {
      entries.sort((a, b) => b.value.compareTo(a.value));
    }

    List<MapEntry<String, dynamic>> topThree = entries.take(3).toList();

    for (int index = 0; index < topThree.length; index++) {
      if (topThree[index].value == 0) {
        continue;
      }
      if (topThree[index].key == 'like') {
        reactEmojiList.add(kiLikeSvgImageUrl);
      } else if (topThree[index].key == 'love') {
        reactEmojiList.add(kiLoveSvgImageUrl);
      } else if (topThree[index].key == 'sad') {
        reactEmojiList.add(kiSadSvgImageUrl);
      } else if (topThree[index].key == 'wow') {
        reactEmojiList.add(kiWowSvgImageUrl);
      } else if (topThree[index].key == 'haha') {
        reactEmojiList.add(kiHahaSvgImageUrl);
      } else {
        reactEmojiList.add(kiAngrySvgImageUrl);
      }
    }
    // ll(reactEmojiList);
    return reactEmojiList;
  }

  double reactStackWidthGetter() {
    if (reactEmojiList.length == 1) {
      return 15;
    } else if (reactEmojiList.length == 2) {
      return 30;
    } else {
      return 35;
    }
  }

  List<Map<String, dynamic>> reactions = [
    // {'value': 'Love', 'State': false},
    // {'value': 'Like', 'State': false},
    // {'value': 'Haha', 'State': false},
    // {'value': 'Wow', 'State': false},
    // {'value': 'Sad', 'State': false},
    // {'value': 'Angry', 'State': false},
  ];
  final Rx<String?> selectedReactionText = Rx<String?>(null);
  final ScrollController scrollController = ScrollController();
  // final RxBool isReactionSelected = RxBool(false);
//  selectedReaction({required int index}){
//    if (selectedReactionText.value == 'Love') {
//       return SvgPicture.asset(
//         kiLoveSvgImageUrl,
//         width: 20,
//       );
//     } else if (selectedReactionText.value == 'Like') {
//       return SvgPicture.asset(
//         kiLikeSvgImageUrl,
//         width: 20,
//       );
//     } else if (selectedReactionText.value == 'Haha') {
//       return SvgPicture.asset(
//         kiHahaSvgImageUrl,
//         width: 20,
//       );
//     } else if (selectedReactionText.value == 'Wow') {
//       return SvgPicture.asset(
//         kiWowSvgImageUrl,
//         width: 20,
//       );
//     } else if (selectedReactionText.value == 'Sad') {
//       return SvgPicture.asset(
//         kiSadSvgImageUrl,
//         width: 20,
//       );
//     } else if (selectedReactionText.value == 'Angry') {
//       return SvgPicture.asset(
//         kiAngrySvgImageUrl,
//         width: 20,
//       );
//     }
// }

  selectedReaction(postIndex) {
    if (Get.find<PostReactionController>().reactions[postIndex]['reaction'].value == 'Love') {
      return SvgPicture.asset(
        kiLoveSvgImageUrl,
        width: 20,
      );
    } else if (Get.find<PostReactionController>().reactions[postIndex]['reaction'].value == 'Like') {
      return SvgPicture.asset(
        kiLikeSvgImageUrl,
        width: 20,
      );
    } else if (Get.find<PostReactionController>().reactions[postIndex]['reaction'].value == 'Haha') {
      return SvgPicture.asset(
        kiHahaSvgImageUrl,
        width: 20,
      );
    } else if (Get.find<PostReactionController>().reactions[postIndex]['reaction'].value == 'Wow') {
      return SvgPicture.asset(
        kiWowSvgImageUrl,
        width: 20,
      );
    } else if (Get.find<PostReactionController>().reactions[postIndex]['reaction'].value == 'Sad') {
      return SvgPicture.asset(
        kiSadSvgImageUrl,
        width: 20,
      );
    } else if (Get.find<PostReactionController>().reactions[postIndex]['reaction'].value == 'Angry') {
      return SvgPicture.asset(
        kiAngrySvgImageUrl,
        width: 20,
      );
    }
  }
}
