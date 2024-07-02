import 'package:bip_hip/controllers/home/all_search_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/search/search_bottom_sheets/search_kids_news_bottom_sheet_content.dart';
import 'package:bip_hip/views/search/search_bottom_sheets/search_photos_videos_bottom_sheet_content.dart';
import 'package:bip_hip/views/search/search_bottom_sheets/search_posts_bottom_sheet_content.dart';
import 'package:bip_hip/views/search/search_bottom_sheets/search_sell_posts_bottom_sheet_content.dart';
import 'package:bip_hip/views/search/search_widgets/search_posted_by_content.dart';

class SearchHelper {
  final AllSearchController allSearchController = Get.find<AllSearchController>();
  final GlobalController globalController = Get.find<GlobalController>();

  void onPressSearchFilter() {
    if (allSearchController.selectedFilterIndex.value == 1) {
      globalController.commonBottomSheet(
          context: Get.context,
          isBottomSheetRightButtonActive: allSearchController.isPostsBottomSheetResetOrShowResult,
          content: SearchPostsBottomSheetContent(),
          bottomSheetHeight: height * 0.4,
          onPressCloseButton: () {
            Get.back();
          },
          onPressRightButton: () {
            allSearchController.resetPostsBottomSheetData();
          },
          rightText: ksReset.tr,
          rightTextStyle: semiBold14TextStyle(cPrimaryColor),
          title: ksPosts.tr,
          isRightButtonShow: true);
    }
    if (allSearchController.selectedFilterIndex.value == 2) {
      Get.find<GlobalController>().commonBottomSheet(
          context: Get.context,
          bottomSheetHeight: height * 0.4,
          content: SearchPostedByContent(),
          onPressCloseButton: () {
            Get.back();
          },
          onPressRightButton: () async {
            allSearchController.selectedPostedBy.value = allSearchController.temporarySelectedPostedBy.value;
            await allSearchController.getSearch();
            Get.back();
          },
          rightText: ksDone.tr,
          rightTextStyle: semiBold14TextStyle(cPrimaryColor),
          title: ksPostedBy.tr,
          isRightButtonShow: true,
          isBottomSheetRightButtonActive: allSearchController.isPostedByBottomSheetState);
    }
    if (allSearchController.selectedFilterIndex.value == 3 || allSearchController.selectedFilterIndex.value == 4) {
      globalController.commonBottomSheet(
          context: Get.context,
          isBottomSheetRightButtonActive: allSearchController.isPhotosVideosBottomSheetResetOrShowResult,
          content: SearchPhotosVideosBottomSheetContent(),
          bottomSheetHeight: height * 0.3,
          onPressCloseButton: () {
            Get.back();
          },
          onPressRightButton: () {
            allSearchController.resetPhotosVideosBottomSheetData();
          },
          rightText: ksReset.tr,
          rightTextStyle: semiBold14TextStyle(cPrimaryColor),
          title: ksPosts.tr,
          isRightButtonShow: true);
    }
    if (allSearchController.selectedFilterIndex.value == 5) {
      globalController.commonBottomSheet(
          context: Get.context,
          isBottomSheetRightButtonActive: allSearchController.isSellPostBottomSheetResetOrShowResult,
          content: SearchSellPostsBottomSheetContent(),
          bottomSheetHeight: height * 0.4,
          onPressCloseButton: () {
            Get.back();
          },
          onPressRightButton: () {
            allSearchController.resetSellPostBottomSheetData();
          },
          rightText: ksReset.tr,
          rightTextStyle: semiBold14TextStyle(cPrimaryColor),
          title: ksSellPost.tr,
          isRightButtonShow: true);
    }
    if (allSearchController.selectedFilterIndex.value == 6 || allSearchController.selectedFilterIndex.value == 7) {
      globalController.commonBottomSheet(
          context: Get.context,
          isBottomSheetRightButtonActive: allSearchController.isKidsNewsBottomSheetResetOrShowResult,
          content: SearchKidsNewsBottomSheetContent(),
          bottomSheetHeight: height * 0.35,
          onPressCloseButton: () {
            Get.back();
          },
          onPressRightButton: () {
            allSearchController.resetKidsNewsBottomSheetData();
          },
          rightText: ksReset.tr,
          rightTextStyle: semiBold14TextStyle(cPrimaryColor),
          title: ksSellPost.tr,
          isRightButtonShow: true);
    }
  }

  void onPressSearchBarCross() {
    allSearchController.searchTextEditingController.clear();
    allSearchController.isSearchSuffixIconVisible.value = false;
    allSearchController.isSearched.value = false;
    allSearchController.selectedFilterIndex.value = -1;
    allSearchController.selectedFilterValue.value = "";
  }

  void onSubmitSearchTextfield() async {
    allSearchController.searchFocusNode.unfocus;
    if (allSearchController.searchTextEditingController.text.toString().trim() == "") {
      allSearchController.isSearchSuffixIconVisible.value = false;
    } else {
      allSearchController.isSearchSuffixIconVisible.value = true;
      allSearchController.selectedFilterIndex.value = 0;
      allSearchController.selectedFilterValue.value = allSearchController.filterTypeList[0];
      allSearchController.isSearched.value = true;
      await allSearchController.getSearch();
    }
  }

  void onChangedSearchTextfield() {
    if (allSearchController.searchTextEditingController.text.toString().trim() == "") {
      allSearchController.isSearchSuffixIconVisible.value = false;
    } else {
      allSearchController.isSearchSuffixIconVisible.value = true;
    }
  }
}
