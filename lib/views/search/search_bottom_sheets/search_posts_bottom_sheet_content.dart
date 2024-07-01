import 'package:bip_hip/controllers/home/all_search_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/search/search.dart';
import 'package:bip_hip/views/search/search_widgets/date_posted_content.dart';
import 'package:bip_hip/views/search/search_widgets/posts_category_content.dart';
import 'package:bip_hip/views/search/search_widgets/search_posted_by_content.dart';

class SearchPostsBottomSheetContent extends StatelessWidget {
  SearchPostsBottomSheetContent({super.key});
  final AllSearchController allSearchController = Get.find<AllSearchController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            CustomListTile(
              leading: const IconContainer(icon: Icons.timer), //!Icon must change
              title: ksRecentPost.tr,
              trailing: Obx(() => SizedBox(
                    width: (width - 330) / 2,
                    child: CustomCheckBox(
                        value: allSearchController.isRecentPostCheckBoxSelected.value,
                        label: "",
                        onChanged: (v) {
                          allSearchController.isRecentPostCheckBoxSelected.value = !allSearchController.isRecentPostCheckBoxSelected.value;
                          allSearchController.postsBottomSheetState();
                        },
                        textStyle: regular14TextStyle(cBlackColor)),
                  )),
            ),
            CustomListTile(
              leading: const IconContainer(icon: BipHip.world),
              title: ksPostedBy.tr,
              subtitle: allSearchController.selectedPostedBy.value,
              trailing: allSearchController.selectedPostedBy.value != ""
                  ? CustomIconButton(
                      onPress: () {
                        allSearchController.selectedPostedBy.value = "";
                        allSearchController.postsBottomSheetState();
                      },
                      icon: BipHip.circleCrossNew,
                      size: kIconSize20,
                    )
                  : null,
              onPressed: () {
                allSearchController.temporarySelectedPostedBy.value = allSearchController.selectedPostedBy.value;
                if (allSearchController.temporarySelectedPostedBy.value == '') {
                  allSearchController.isPostedByBottomSheetState.value = false;
                } else {
                  allSearchController.isPostedByBottomSheetState.value = true;
                }
                Get.find<GlobalController>().commonBottomSheet(
                    context: context,
                    bottomSheetHeight: height * 0.4,
                    content: SearchPostedByContent(),
                    onPressCloseButton: () {
                      Get.back();
                    },
                    onPressRightButton: () {
                      allSearchController.selectedPostedBy.value = allSearchController.temporarySelectedPostedBy.value;
                      allSearchController.postsBottomSheetState();
                      Get.back();
                    },
                    rightText: ksDone.tr,
                    rightTextStyle: semiBold14TextStyle(cPrimaryColor),
                    title: ksPostedBy.tr,
                    isRightButtonShow: true,
                    isBottomSheetRightButtonActive: allSearchController.isPostedByBottomSheetState);
              },
            ),
            CustomListTile(
              leading: const IconContainer(icon: Icons.date_range), //!Icon must change
              title: ksDatePosted.tr,
              subtitle: allSearchController.selectedDatePosted.value,
              trailing: allSearchController.selectedDatePosted.value == ""
                  ? null
                  : CustomIconButton(
                      onPress: () {
                        allSearchController.selectedDatePosted.value = "";
                        allSearchController.postsBottomSheetState();
                      },
                      icon: BipHip.circleCrossNew,
                      size: kIconSize20,
                    ),
              onPressed: () {
                allSearchController.temporarySelectedDatePosted.value = allSearchController.selectedDatePosted.value;
                // kidsController.temporaryKidRelationId.value = kidsController.kidRelationId.value;
                if (allSearchController.temporarySelectedDatePosted.value == "") {
                  allSearchController.isDatePostedBottomSheetState.value = false;
                } else {
                  allSearchController.isDatePostedBottomSheetState.value = true;
                }
                Get.find<GlobalController>().commonBottomSheet(
                    context: context,
                    content: DatePostedContent(),
                    onPressCloseButton: () {
                      Get.back();
                    },
                    onPressRightButton: () {
                      allSearchController.selectedDatePosted.value = allSearchController.temporarySelectedDatePosted.value;
                      allSearchController.postsBottomSheetState();
                      Get.back();
                    },
                    rightText: ksDone.tr,
                    rightTextStyle: semiBold14TextStyle(cPrimaryColor),
                    title: ksDatePosted.tr,
                    isRightButtonShow: true,
                    isBottomSheetRightButtonActive: allSearchController.isDatePostedBottomSheetState);
              },
            ),
            CustomListTile(
              leading: const IconContainer(icon: BipHip.menuFill),
              title: ksCategory.tr,
              subtitle: allSearchController.selectedCategory.value,
              trailing: allSearchController.selectedCategory.value == ""
                  ? null
                  : CustomIconButton(
                      onPress: () {
                        allSearchController.selectedCategory.value = "";
                        allSearchController.selectedCategoryId.value = -1;
                        allSearchController.postsBottomSheetState();
                      },
                      icon: BipHip.circleCrossNew,
                      size: kIconSize20,
                    ),
              onPressed: () {
                allSearchController.temporarySelectedCategory.value = allSearchController.selectedCategory.value;
                allSearchController.temporarySelectedCategoryId.value = allSearchController.selectedCategoryId.value;
                if (allSearchController.temporarySelectedCategory.value == '') {
                  allSearchController.isCategoryBottomSheetState.value = false;
                } else {
                  allSearchController.isCategoryBottomSheetState.value = true;
                }
                Get.find<GlobalController>().commonBottomSheet(
                    context: context,
                    content: PostsCategoryContent(),
                    onPressCloseButton: () {
                      Get.back();
                    },
                    onPressRightButton: () {
                      allSearchController.selectedCategory.value = allSearchController.temporarySelectedCategory.value;
                      allSearchController.selectedCategoryId.value = allSearchController.temporarySelectedCategoryId.value;
                      allSearchController.postsBottomSheetState();
                      Get.back();
                    },
                    rightText: ksDone.tr,
                    rightTextStyle: semiBold14TextStyle(cPrimaryColor),
                    title: ksCategory.tr,
                    isRightButtonShow: true,
                    isBottomSheetRightButtonActive: allSearchController.isCategoryBottomSheetState);
              },
            ),
            kH24sizedBox,
            CustomElevatedButton(
              label: ksShowResult.tr,
              buttonWidth: width - 40,
              buttonHeight: h32,
              onPressed: allSearchController.isPostsBottomSheetResetOrShowResult.value
                  ? () async {
                      Get.back();
                      await allSearchController.getSearch();
                    }
                  : null,
              buttonColor: cPrimaryColor,
              textStyle: semiBold14TextStyle(cWhiteColor),
            ),
          ],
        ));
  }
}
