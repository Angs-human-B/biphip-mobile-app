import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/dashboard/dashboard_overview/dashboard_overview.dart';
import 'package:bip_hip/views/dashboard/dashboard_overview/dashboard_overview_post_insights.dart';
import 'package:bip_hip/views/dashboard/dashboard_quiz.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';

class DashboardOverviewContent extends StatelessWidget {
  DashboardOverviewContent({super.key});
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
              appBarColor: cWhiteColor,
              title: ksContent.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: Obx(
            () => Column(
              children: [
                kH16sizedBox,
                SizedBox(
                  width: width,
                  height: 50,
                  child: ListView.separated(
                    itemCount: dashboardController.dashboardOverviewContentFilterList.length,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => kW8sizedBox,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, index) {
                      return Obx(() => Padding(
                            padding: index == 0 ? const EdgeInsets.only(left: k20Padding) : const EdgeInsets.only(left: k0Padding),
                            child: CustomChoiceChips(
                              label: dashboardController.dashboardOverviewContentFilterList[index],
                              isSelected: (dashboardController.dashboardOverviewSelectedContentFilterIndex.value == index),
                              onSelected: (value) async {
                                dashboardController.dashboardOverviewSelectedContentFilterIndex.value = index;
                                dashboardController.dashboardOverviewSelectedContentFilterValue.value =
                                    dashboardController.dashboardOverviewContentFilterList[index];
                              },
                            ),
                          ));
                    },
                  ),
                ),
                kH12sizedBox,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
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
                      kH20sizedBox,
                      Text(
                        ksAllContent.tr,
                        style: semiBold18TextStyle(cBlackColor),
                      ),
                      kH16sizedBox,
                      if (dashboardController.dashboardOverviewSelectedContentFilterIndex.value == 0)
                        SizedBox(
                          height: height - (kAppBarSize + MediaQuery.of(context).padding.top + 50 + 113),
                          child: SingleChildScrollView(
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: dashboardController.dashboardEarnedGiftPostList.length,
                              separatorBuilder: (context, index) => kH16sizedBox,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(() => DashboardOverviewPostInsights(
                                          postContent: dashboardController.dashboardEarnedGiftPostList[index]["productTitle"],
                                          postImage: dashboardController.dashboardEarnedGiftPostList[index]["productImage"],
                                        ));
                                  },
                                  child: DashboardGiftContentContainer(
                                    width: width - 40,
                                    height: 150,
                                    productImage: dashboardController.dashboardEarnedGiftPostList[index]["productImage"],
                                    productTitle: dashboardController.dashboardEarnedGiftPostList[index]["productTitle"],
                                    postDate: dashboardController.dashboardEarnedGiftPostList[index]["postDate"],
                                    postCount: dashboardController.dashboardEarnedGiftPostList[index]["postCount"],
                                    engagementCount: dashboardController.dashboardEarnedGiftPostList[index]["engagementCount"],
                                    giftCount: dashboardController.dashboardEarnedGiftPostList[index]["giftCount"],
                                    isVideoContent: dashboardController.dashboardEarnedGiftPostList[index]["isVideoContent"],
                                    isOnlyTextContent: dashboardController.dashboardEarnedGiftPostList[index]["isTextOnly"],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      if (dashboardController.dashboardOverviewSelectedContentFilterIndex.value == 1)
                        SizedBox(
                          height: height - (kAppBarSize + MediaQuery.of(context).padding.top + 50 + 113),
                          child: SingleChildScrollView(
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: dashboardController.dashboardEarnedGiftPhotosPostList.length,
                              separatorBuilder: (context, index) => kH16sizedBox,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(() => DashboardOverviewPostInsights(
                                          postContent: dashboardController.dashboardEarnedGiftPhotosPostList[index]["productTitle"],
                                          postImage: dashboardController.dashboardEarnedGiftPhotosPostList[index]["productImage"],
                                        ));
                                  },
                                  child: DashboardGiftContentContainer(
                                    width: width - 40,
                                    height: 150,
                                    productImage: dashboardController.dashboardEarnedGiftPhotosPostList[index]["productImage"],
                                    productTitle: dashboardController.dashboardEarnedGiftPhotosPostList[index]["productTitle"],
                                    postDate: dashboardController.dashboardEarnedGiftPhotosPostList[index]["postDate"],
                                    postCount: dashboardController.dashboardEarnedGiftPhotosPostList[index]["postCount"],
                                    engagementCount: dashboardController.dashboardEarnedGiftPhotosPostList[index]["engagementCount"],
                                    giftCount: dashboardController.dashboardEarnedGiftPhotosPostList[index]["giftCount"],
                                    isVideoContent: dashboardController.dashboardEarnedGiftPhotosPostList[index]["isVideoContent"],
                                    isOnlyTextContent: dashboardController.dashboardEarnedGiftPhotosPostList[index]["isTextOnly"],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      if (dashboardController.dashboardOverviewSelectedContentFilterIndex.value == 2)
                        SizedBox(
                          height: height - (kAppBarSize + MediaQuery.of(context).padding.top + 50 + 113),
                          child: SingleChildScrollView(
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: dashboardController.dashboardEarnedGiftVideosPostList.length,
                              separatorBuilder: (context, index) => kH16sizedBox,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(() => DashboardOverviewPostInsights(
                                          postContent: dashboardController.dashboardEarnedGiftVideosPostList[index]["productTitle"],
                                          postImage: dashboardController.dashboardEarnedGiftVideosPostList[index]["productImage"],
                                        ));
                                  },
                                  child: DashboardGiftContentContainer(
                                    width: width - 40,
                                    height: 150,
                                    productImage: dashboardController.dashboardEarnedGiftVideosPostList[index]["productImage"],
                                    productTitle: dashboardController.dashboardEarnedGiftVideosPostList[index]["productTitle"],
                                    postDate: dashboardController.dashboardEarnedGiftVideosPostList[index]["postDate"],
                                    postCount: dashboardController.dashboardEarnedGiftVideosPostList[index]["postCount"],
                                    engagementCount: dashboardController.dashboardEarnedGiftVideosPostList[index]["engagementCount"],
                                    giftCount: dashboardController.dashboardEarnedGiftVideosPostList[index]["giftCount"],
                                    isVideoContent: dashboardController.dashboardEarnedGiftVideosPostList[index]["isVideoContent"],
                                    isOnlyTextContent: dashboardController.dashboardEarnedGiftVideosPostList[index]["isTextOnly"],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      if (dashboardController.dashboardOverviewSelectedContentFilterIndex.value == 3)
                        SizedBox(
                          height: height - (kAppBarSize + MediaQuery.of(context).padding.top + 50 + 113),
                          child: SingleChildScrollView(
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: dashboardController.dashboardEarnedGiftTextPostList.length,
                              separatorBuilder: (context, index) => kH16sizedBox,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(() => DashboardOverviewPostInsights(
                                          postContent: dashboardController.dashboardEarnedGiftTextPostList[index]["productTitle"],
                                          postImage: dashboardController.dashboardEarnedGiftTextPostList[index]["productImage"],
                                        ));
                                  },
                                  child: DashboardGiftContentContainer(
                                    width: width - 40,
                                    height: 150,
                                    productImage: dashboardController.dashboardEarnedGiftTextPostList[index]["productImage"],
                                    productTitle: dashboardController.dashboardEarnedGiftTextPostList[index]["productTitle"],
                                    postDate: dashboardController.dashboardEarnedGiftTextPostList[index]["postDate"],
                                    postCount: dashboardController.dashboardEarnedGiftTextPostList[index]["postCount"],
                                    engagementCount: dashboardController.dashboardEarnedGiftTextPostList[index]["engagementCount"],
                                    giftCount: dashboardController.dashboardEarnedGiftTextPostList[index]["giftCount"],
                                    isVideoContent: dashboardController.dashboardEarnedGiftTextPostList[index]["isVideoContent"],
                                    isOnlyTextContent: dashboardController.dashboardEarnedGiftTextPostList[index]["isTextOnly"],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardEmptyView extends StatelessWidget {
  const DashboardEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: k140Padding),
      child: Column(
        children: [
          const Icon(
            BipHip.report,
            color: cIconColor,
            size: 130,
          ),
          kH16sizedBox,
          Text(
            ksContentUnavailable.tr,
            style: semiBold18TextStyle(cSmallBodyTextColor),
          ),
          kH4sizedBox,
          Text(
            "${ksYouDontHaveAnyTopPostsToBoostWithinTheTimeRange.tr}.",
            style: regular12TextStyle(cSmallBodyTextColor),
            textAlign: TextAlign.center,
            overflow: TextOverflow.clip,
          )
        ],
      ),
    );
  }
}
