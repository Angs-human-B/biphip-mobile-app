import 'package:bip_hip/controllers/home/all_search_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/search.dart';
import 'package:bip_hip/widgets/common/utils/search_widgets/search_posted_by_content.dart';
import 'package:bip_hip/widgets/common/utils/search_widgets/sell_post_post_type_content.dart';
import 'package:bip_hip/widgets/common/utils/search_widgets/sell_post_product_condition.dart';
import 'package:bip_hip/widgets/common/utils/search_widgets/sell_post_product_condition_content.dart';

class SearchSellPostsBottomSheetContent extends StatelessWidget {
  SearchSellPostsBottomSheetContent({super.key});
  final AllSearchController allSearchController = Get.find<AllSearchController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            CustomListTile(
              leading: const IconContainer(icon: BipHip.world),
              title: ksPostType.tr,
              subtitle: allSearchController.selectedSellPostType.value,
              trailing: allSearchController.selectedSellPostType.value == ""
                  ? null
                  : CustomIconButton(
                      onPress: () {
                        allSearchController.selectedSellPostType.value = "";
                        allSearchController.sellPostBottomSheetState();
                      },
                      icon: BipHip.circleCrossNew,
                      size: kIconSize20,
                    ),
              onPressed: () {
                allSearchController.temporarySelectedSellPostType.value = allSearchController.selectedSellPostType.value;
                if (allSearchController.temporarySelectedSellPostType.value == '') {
                  allSearchController.isSellPostTypeBottomSheetState.value = false;
                } else {
                  allSearchController.isSellPostTypeBottomSheetState.value = true;
                }
                Get.find<GlobalController>().commonBottomSheet(
                    context: context,
                    bottomSheetHeight: height * 0.25,
                    content: SellPostPostTypeContent(),
                    onPressCloseButton: () {
                      Get.back();
                    },
                    onPressRightButton: () {
                      allSearchController.selectedSellPostType.value = allSearchController.temporarySelectedSellPostType.value;
                      allSearchController.selectedSellPostTypeIndex.value = allSearchController.temporarySelectedSellPostTypeIndex.value;
                      allSearchController.sellPostBottomSheetState();
                      Get.back();
                    },
                    rightText: ksDone.tr,
                    rightTextStyle: semiBold14TextStyle(cPrimaryColor),
                    title: ksPostType.tr,
                    isRightButtonShow: true,
                    isBottomSheetRightButtonActive: allSearchController.isSellPostTypeBottomSheetState);
              },
            ),
            CustomListTile(
              leading: const IconContainer(icon: BipHip.activity), //!Icon must change
              title: ksCondition.tr,
              subtitle: allSearchController.selectedSellPostCondition.value,
              trailing: allSearchController.selectedSellPostCondition.value == ""
                  ? null
                  : CustomIconButton(
                      onPress: () {
                        allSearchController.selectedSellPostCondition.value = "";
                        allSearchController.selectedSellPostConditionId.value = -1;
                        allSearchController.sellPostBottomSheetState();
                      },
                      icon: BipHip.circleCrossNew,
                      size: kIconSize20,
                    ),
              onPressed: () {
                allSearchController.temporarySelectedSellPostCondition.value = allSearchController.selectedSellPostCondition.value;
                allSearchController.temporarySelectedSellPostConditionId.value = allSearchController.selectedSellPostConditionId.value;
                if (allSearchController.temporarySelectedSellPostCondition.value == '') {
                  allSearchController.isSellPostConditionBottomSheetState.value = false;
                } else {
                  allSearchController.isSellPostConditionBottomSheetState.value = true;
                }
                Get.find<GlobalController>().commonBottomSheet(
                    context: context,
                    content: SellPostProductConditionContent(),
                    onPressCloseButton: () {
                      Get.back();
                    },
                    onPressRightButton: () {
                      allSearchController.selectedSellPostCondition.value = allSearchController.temporarySelectedSellPostCondition.value;
                      allSearchController.selectedSellPostConditionId.value = allSearchController.temporarySelectedSellPostConditionId.value;
                      allSearchController.sellPostBottomSheetState();
                      Get.back();
                    },
                    rightText: ksDone.tr,
                    rightTextStyle: semiBold14TextStyle(cPrimaryColor),
                    title: ksCondition.tr,
                    isRightButtonShow: true,
                    isBottomSheetRightButtonActive: allSearchController.isSellPostConditionBottomSheetState);
              },
            ),
            CustomListTile(
              leading: const IconContainer(icon: BipHip.world),
              title: ksPostedBy.tr,
              subtitle: allSearchController.selectedPostedBy.value,
              trailing: allSearchController.selectedPostedBy.value == ""
                  ? null
                  : CustomIconButton(
                      onPress: () {
                        allSearchController.selectedPostedBy.value = "";
                        allSearchController.sellPostBottomSheetState();
                      },
                      icon: BipHip.circleCrossNew,
                      size: kIconSize20,
                    ),
              onPressed: () {
                allSearchController.temporarySelectedPostedBy.value = allSearchController.selectedPostedBy.value;
                if (allSearchController.temporarySelectedPostedBy.value == "") {
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
                      allSearchController.sellPostBottomSheetState();
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
              leading: const IconContainer(icon: BipHip.menuFill),
              title: ksCategory.tr,
              subtitle: allSearchController.selectedSellPostProductCategory.value,
              trailing: allSearchController.selectedSellPostProductCategory.value == ""
                  ? null
                  : CustomIconButton(
                      onPress: () {
                        allSearchController.selectedSellPostProductCategory.value = "";
                        allSearchController.sellPostBottomSheetState();
                      },
                      icon: BipHip.circleCrossNew,
                      size: kIconSize20,
                    ),
              onPressed: () {
                allSearchController.temporarySelectedSellPostProductCategory.value = allSearchController.selectedSellPostProductCategory.value;
                allSearchController.temporarySelectedSellPostProductCategoryId.value = allSearchController.selectedSellPostProductCategoryId.value;
                if (allSearchController.temporarySelectedSellPostProductCategory.value == '') {
                  allSearchController.isSellPostProductConditionBottomSheetState.value = false;
                } else {
                  allSearchController.isSellPostProductConditionBottomSheetState.value = true;
                }
                Get.find<GlobalController>().commonBottomSheet(
                    context: context,
                    content: SellPostProductCategoryContent(),
                    onPressCloseButton: () {
                      Get.back();
                    },
                    onPressRightButton: () {
                      allSearchController.selectedSellPostProductCategory.value = allSearchController.temporarySelectedSellPostProductCategory.value;
                      allSearchController.selectedSellPostProductCategoryId.value = allSearchController.temporarySelectedSellPostProductCategoryId.value;
                      allSearchController.sellPostBottomSheetState();
                      Get.back();
                    },
                    rightText: ksDone.tr,
                    rightTextStyle: semiBold14TextStyle(cPrimaryColor),
                    title: ksCategory.tr,
                    isRightButtonShow: true,
                    isBottomSheetRightButtonActive: allSearchController.isSellPostProductConditionBottomSheetState);
              },
            ),
            kH24sizedBox,
            CustomElevatedButton(
              label: ksShowResult.tr,
              buttonWidth: width - 40,
              buttonHeight: h32,
              onPressed: allSearchController.isSellPostBottomSheetResetOrShowResult.value ? () {} : null,
              buttonColor: cPrimaryColor,
              textStyle: semiBold14TextStyle(cWhiteColor),
            ),
          ],
        ));
  }
}
