import 'package:bip_hip/controllers/home/all_search_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/search.dart';
import 'package:bip_hip/widgets/common/utils/search_widgets/date_posted_content.dart';
import 'package:bip_hip/widgets/common/utils/search_widgets/search_posted_by_content.dart';

class SearchPhotosVideosBottomSheetContent extends StatelessWidget {
  SearchPhotosVideosBottomSheetContent({super.key});
  final AllSearchController allSearchController = Get.find<AllSearchController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            CustomListTile(
              leading: const IconContainer(icon: BipHip.world),
              title: ksPostedBy.tr,
              subtitle: allSearchController.selectedPostedBy.value,
              trailing: allSearchController.selectedPostedBy.value == ""
                  ? null
                  : CustomIconButton(
                      onPress: () {
                        allSearchController.selectedPostedBy.value = "";
                        allSearchController.photosVideosBottomSheetState();
                      },
                      icon: BipHip.circleCrossNew,
                      size: kIconSize20,
                    ),
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
                      allSearchController.photosVideosBottomSheetState();
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
                        allSearchController.photosVideosBottomSheetState();
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
                      allSearchController.photosVideosBottomSheetState();
                      Get.back();
                    },
                    rightText: ksDone.tr,
                    rightTextStyle: semiBold14TextStyle(cPrimaryColor),
                    title: ksDatePosted.tr,
                    isRightButtonShow: true,
                    isBottomSheetRightButtonActive: allSearchController.isDatePostedBottomSheetState);
              },
            ),
            kH24sizedBox,
            CustomElevatedButton(
              label: ksShowResult.tr,
              buttonWidth: width - 40,
              buttonHeight: h32,
              onPressed: allSearchController.isPhotosVideosBottomSheetResetOrShowResult.value
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
