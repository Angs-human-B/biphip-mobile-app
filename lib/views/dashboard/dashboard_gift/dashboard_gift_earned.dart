import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/dashboard/dashboard_gift/dashboard_gift.dart';

class DashboardGiftEarned extends StatelessWidget {
  DashboardGiftEarned({super.key});
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
              title: ksGift.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kH16sizedBox,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Text(
                      "Feb 4 - Mar 2",
                      style: semiBold14TextStyle(cBlackColor),
                    ),
                  ],
                ),
              ),
              kH20sizedBox,
              Expanded(
                child: SingleChildScrollView(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dashboardController.dashboardEarnedGiftPostList.length,
                    separatorBuilder: (context, index) => kH16sizedBox,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                        child: DashboardGiftContentContainer(
                          width: width - 40,
                          height: 150,
                          productImage: dashboardController.dashboardEarnedGiftPostList[index]["productImage"],
                          productTitle: dashboardController.dashboardEarnedGiftPostList[index]["productTitle"],
                          postDate: dashboardController.dashboardEarnedGiftPostList[index]["postDate"],
                          postCount: dashboardController.dashboardEarnedGiftPostList[index]["postCount"],
                          engagementCount: dashboardController.dashboardEarnedGiftPostList[index]["engagementCount"],
                          giftCount: dashboardController.dashboardEarnedGiftPostList[index]["giftCount"],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
