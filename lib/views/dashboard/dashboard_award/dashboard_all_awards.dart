import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/dashboard/dashboard_award/dashboard_award.dart';
import 'package:bip_hip/views/dashboard/dashboard_quiz.dart';
import 'package:bip_hip/views/menu/awards/awards_details_page.dart';
import 'package:bip_hip/views/menu/awards/awards_page.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';

class DashboardAllAwards extends StatelessWidget {
  DashboardAllAwards({super.key});
  final DashboardController dashboardController = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: cWhiteColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              title: ksAllAwards.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kH16sizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.find<GlobalController>().blankBottomSheet(
                          context: context,
                          bottomSheetHeight: height * 0.5,
                          content: QuizTimeFilterBottomSheetContent(),
                        );
                      },
                      child: Container(
                        height: h28,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(k4BorderRadius),
                          color: cNeutralColor,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: k8Padding, vertical: k4Padding),
                              child: Text(
                                dashboardController.selectedQuizTimeRangeValue.value,
                                style: regular12TextStyle(cBlackColor),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: k4Padding, bottom: k4Padding, right: k8Padding),
                              child: Icon(
                                BipHip.downArrow,
                                size: kIconSize20,
                                color: cBlackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    kW12sizedBox,
                    InkWell(
                      onTap: () {
                        dashboardController.temporarySelectedCategoryId.value = dashboardController.selectedCategoryId.value;
                        dashboardController.temporarySelectedCategory.value = dashboardController.selectedCategory.value;
                        if (dashboardController.temporarySelectedCategoryId.value == -1) {
                          dashboardController.categoryRightButtonState.value = false;
                        } else {
                          dashboardController.categoryRightButtonState.value = true;
                        }
                        Get.find<GlobalController>().commonBottomSheet(
                          context: context,
                          bottomSheetHeight: height * 0.6,
                          content: CategoryBottomSheetContent(),
                          onPressCloseButton: () {
                            Get.back();
                          },
                          onPressRightButton: () {
                            dashboardController.selectedCategoryId.value = dashboardController.temporarySelectedCategoryId.value;
                            dashboardController.selectedCategory.value = dashboardController.temporarySelectedCategory.value;
                            Get.back();
                          },
                          rightText: ksDone.tr,
                          rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                          title: ksSelectCategory.tr,
                          isRightButtonShow: true,
                          isBottomSheetRightButtonActive: dashboardController.categoryRightButtonState,
                        );
                      },
                      child: Container(
                        height: h28,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(k4BorderRadius),
                          color: cNeutralColor,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: k8Padding, vertical: k4Padding),
                              child: Text(
                                dashboardController.selectedCategory.value,
                                style: regular12TextStyle(cBlackColor),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: k4Padding, bottom: k4Padding, right: k8Padding),
                              child: Icon(
                                BipHip.downArrow,
                                size: kIconSize20,
                                color: cBlackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                kH20sizedBox,
                Text(
                  ksYouWon.tr,
                  style: semiBold18TextStyle(cBlackColor),
                ),
                kH16sizedBox,
                dashboardController.allAwardList.isNotEmpty
                    ? Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: dashboardController.allAwardList.length,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 0.75,
                                  crossAxisCount: 3,
                                  crossAxisSpacing: k16Padding,
                                  mainAxisSpacing: k16Padding,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(() => AwardDetailsPage(
                                            userImage: dashboardController.allAwardList[index]['image'],
                                            ranking: dashboardController.allAwardList[index]['ranking'],
                                            certificateImage: dashboardController.allAwardList[index]['certificate'],
                                            winningDate: dashboardController.allAwardList[index]['WinningDate'],
                                          ));
                                    },
                                    child: AwardView(
                                      image: dashboardController.allAwardList[index]['image'],
                                      ranking: dashboardController.allAwardList[index]['ranking'],
                                      titleText: dashboardController.allAwardList[index]['WinningDate'],
                                    ),
                                  );
                                },
                              ),
                              kH20sizedBox,
                            ],
                          ),
                        ),
                      )
                    : Container(
                        width: width - 40,
                        height: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(k8BorderRadius),
                          border: Border.all(width: 1, color: cLineColor),
                        ),
                        child: EmptyView(title: ksYouHavenotWonAnyAward.tr)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
