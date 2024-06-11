import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';

class DashboardOverview extends StatelessWidget {
  DashboardOverview({super.key});
  final DashboardController dashboardController = DashboardController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Obx(
        () => SafeArea(
          top: false,
          child: Scaffold(
            backgroundColor: cWhiteColor,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kAppBarSize),
              //* info:: appBar
              child: CustomAppBar(
                appBarColor: cWhiteColor,
                title: dashboardController.dashboardOverviewAppbarTitle(dashboardController.dashboardOverviewSelectedFilterIndex.value),
                hasBackButton: true,
                isCenterTitle: true,
                onBack: () {
                  Get.back();
                },
              ),
            ),
            body: Obx(
              () => SingleChildScrollView(
                child: Column(
                  children: [
                    kH16sizedBox,
                    SizedBox(
                      width: width,
                      height: 50,
                      child: ListView.separated(
                        itemCount: dashboardController.dashboardOverviewFilterList.length,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => kW8sizedBox,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, index) {
                          return Obx(() => Padding(
                                padding: index == 0 ? const EdgeInsets.only(left: k20Padding) : const EdgeInsets.only(left: k0Padding),
                                child: CustomChoiceChips(
                                  label: dashboardController.dashboardOverviewFilterList[index],
                                  isSelected: (dashboardController.dashboardOverviewSelectedFilterIndex.value == index),
                                  onSelected: (value) async {
                                    dashboardController.dashboardOverviewSelectedFilterIndex.value = index;
                                    dashboardController.dashboardOverviewSelectedFilterValue.value = dashboardController.dashboardOverviewFilterList[index];
                                  },
                                ),
                              ));
                        },
                      ),
                    ),
                    kH20sizedBox,
                    if (dashboardController.dashboardOverviewSelectedFilterIndex.value == 0)
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      ksPerformance.tr,
                                      style: semiBold18TextStyle(cBlackColor),
                                    ),
                                    kW8sizedBox,
                                    const Icon(
                                      BipHip.info,
                                      size: kIconSize14,
                                      color: cIconColor,
                                    ),
                                  ],
                                ),
                                InkWell(
                                    onTap: () {
                                      dashboardController.dashboardOverviewSelectedFilterIndex.value = 1;
                                    },
                                    child: Text(
                                      ksSeeAll.tr,
                                      style: regular16TextStyle(cPrimaryColor),
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                kH4sizedBox,
                                Row(
                                  children: [
                                    Text(
                                      "750",
                                      style: regular14TextStyle(cBlackColor),
                                    ),
                                    kW4sizedBox,
                                    Text(
                                      ksFollowers,
                                      style: regular10TextStyle(cSmallBodyTextColor),
                                    ),
                                  ],
                                ),
                                kH4sizedBox,
                                Text(
                                  ksLast28Days.tr,
                                  style: regular10TextStyle(cSmallBodyTextColor),
                                ),
                              ],
                            ),
                          ),
                          kH16sizedBox,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    DashboardCommonContainer(
                                      width: (width - 48) / 2,
                                      height: 88,
                                      titleText: ksReach.tr,
                                      totalValue: "20,874",
                                      percentValue: "+39%",
                                      filterText: dashboardController.dashboardOverviewTime.value,
                                      percentTextColor: cGreenColor,
                                    ),
                                    kW8sizedBox,
                                    DashboardCommonContainer(
                                      width: (width - 48) / 2,
                                      height: 88,
                                      titleText: ksContentPublished.tr,
                                      totalValue: "0",
                                      percentValue: "+0%",
                                      filterText: dashboardController.dashboardOverviewTime.value,
                                      percentTextColor: cGreenColor,
                                    ),
                                  ],
                                ),
                                kH8sizedBox,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    DashboardCommonContainer(
                                      width: (width - 48) / 2,
                                      height: 88,
                                      titleText: ksEngagement.tr,
                                      totalValue: "1,250",
                                      percentValue: "+350%",
                                      filterText: dashboardController.dashboardOverviewTime.value,
                                      percentTextColor: cGreenColor,
                                    ),
                                    kW8sizedBox,
                                    DashboardCommonContainer(
                                      width: (width - 48) / 2,
                                      height: 88,
                                      titleText: ksNetFollowers.tr,
                                      totalValue: "874",
                                      percentValue: "+12%",
                                      filterText: dashboardController.dashboardOverviewTime.value,
                                      percentTextColor: cGreenColor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          kH16sizedBox,
                          Container(
                            height: h8,
                            width: width,
                            color: cBackgroundColor,
                          ),
                          kH16sizedBox,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ksRecentContent.tr,
                                  style: semiBold18TextStyle(cBlackColor),
                                ),
                                InkWell(
                                    onTap: () {
                                      dashboardController.dashboardOverviewSelectedContentFilterIndex.value = 0;
                                      Get.toNamed(krDashboardOverviewContent);
                                    },
                                    child: Text(
                                      ksSeeAll.tr,
                                      style: regular16TextStyle(cPrimaryColor),
                                    )),
                              ],
                            ),
                          ),
                          kH16sizedBox,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  dashboardController.dashboardEarnedGiftPostList.length > 1 ? 1 : dashboardController.dashboardEarnedGiftPostList.length,
                              separatorBuilder: (context, index) => kH16sizedBox,
                              itemBuilder: (context, index) {
                                return DashboardGiftContentContainer(
                                  width: width - 40,
                                  height: 150,
                                  productImage: dashboardController.dashboardEarnedGiftPostList[index]["productImage"],
                                  productTitle: dashboardController.dashboardEarnedGiftPostList[index]["productTitle"],
                                  postDate: dashboardController.dashboardEarnedGiftPostList[index]["postDate"],
                                  postCount: dashboardController.dashboardEarnedGiftPostList[index]["postCount"],
                                  engagementCount: dashboardController.dashboardEarnedGiftPostList[index]["engagementCount"],
                                  giftCount: dashboardController.dashboardEarnedGiftPostList[index]["giftCount"],
                                );
                              },
                            ),
                          ),
                          kH16sizedBox,
                          Container(
                            height: h8,
                            width: width,
                            color: cBackgroundColor,
                          ),
                          kH16sizedBox,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          ksAudiences.tr,
                                          style: semiBold18TextStyle(cBlackColor),
                                        ),
                                        kW8sizedBox,
                                        const Icon(
                                          BipHip.info,
                                          size: kIconSize14,
                                          color: cIconColor,
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                        onTap: () {
                                          Get.toNamed(krDashboardOverviewAudience);
                                        },
                                        child: Text(
                                          ksSeeAll.tr,
                                          style: regular16TextStyle(cPrimaryColor),
                                        )),
                                  ],
                                ),
                                kH4sizedBox,
                                Text(
                                  ksTheseValuesAreBasedOnTheFollowers.tr,
                                  style: regular12TextStyle(cSmallBodyTextColor),
                                ),
                              ],
                            ),
                          ),
                          kH16sizedBox,
                          SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: k20Padding),
                                      child: Container(
                                          width: (width - 40) / 1.2,
                                          height: 264,
                                          decoration: BoxDecoration(
                                            color: cWhiteColor,
                                            borderRadius: BorderRadius.circular(k8BorderRadius),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: cLineColor,
                                                blurRadius: 3,
                                                spreadRadius: 0,
                                                offset: Offset(
                                                  0,
                                                  1,
                                                ), // Shadow position
                                              ),
                                            ],
                                          ),
                                          child: const DashboardAgeGenderChart()),
                                    )),
                                kW8sizedBox,
                                Container(
                                    width: (width - 40) / 1.2,
                                    height: 264,
                                    decoration: BoxDecoration(
                                      color: cWhiteColor,
                                      borderRadius: BorderRadius.circular(k8BorderRadius),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: cLineColor,
                                          blurRadius: 3,
                                          spreadRadius: 0,
                                          offset: Offset(
                                            0,
                                            1,
                                          ), // Shadow position
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: k12Padding, top: k12Padding),
                                          child: Text(
                                            ksTopCities.tr,
                                            style: semiBold16TextStyle(cBlackColor),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(left: k12Padding),
                                          child: DashboardTopCitiesChart(),
                                        ),
                                      ],
                                    )),
                                kW8sizedBox,
                              ],
                            ),
                          ),
                        ],
                      ),
                    if (dashboardController.dashboardOverviewSelectedFilterIndex.value == 1)
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
                              ksPerformance.tr,
                              style: semiBold18TextStyle(cBlackColor),
                            ),
                            kH16sizedBox,
                            SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  DashboardCommonContainer(
                                    width: (width - 48) / 2,
                                    height: 88,
                                    titleText: ksReach.tr,
                                    totalValue: "20,874",
                                    percentValue: "+39%",
                                    filterText: dashboardController.dashboardOverviewTime.value,
                                    percentTextColor: cGreenColor,
                                  ),
                                  kW8sizedBox,
                                  DashboardCommonContainer(
                                    width: (width - 48) / 2,
                                    height: 88,
                                    titleText: ksContentPublished.tr,
                                    totalValue: "0",
                                    percentValue: "+0%",
                                    filterText: dashboardController.dashboardOverviewTime.value,
                                    percentTextColor: cGreenColor,
                                  ),
                                  kW8sizedBox,
                                  DashboardCommonContainer(
                                    width: (width - 48) / 2,
                                    height: 88,
                                    titleText: ksEngagement.tr,
                                    totalValue: "1,250",
                                    percentValue: "+350%",
                                    filterText: dashboardController.dashboardOverviewTime.value,
                                    percentTextColor: cGreenColor,
                                  ),
                                  kW8sizedBox,
                                  DashboardCommonContainer(
                                    width: (width - 48) / 2,
                                    height: 88,
                                    titleText: ksNetFollowers.tr,
                                    totalValue: "874",
                                    percentValue: "+12%",
                                    filterText: dashboardController.dashboardOverviewTime.value,
                                    percentTextColor: cGreenColor,
                                  ),
                                ],
                              ),
                            ),
                            kH20sizedBox,
                            Text(
                              ksInteractions.tr,
                              style: semiBold18TextStyle(cBlackColor),
                            ),
                            kH16sizedBox,
                            const DashboardInsightsInteractionContent(
                              reactionsCount: "21252",
                              giftCount: "453",
                              starCount: "54",
                              pendentValue: "King Pendent",
                              commentCount: "114",
                              shareCount: "25",
                              photoViewCount: "45",
                              linkClickCount: "67",
                              othersCount: "64",
                            ),
                          ],
                        ),
                      ),
                    if (dashboardController.dashboardOverviewSelectedFilterIndex.value == 3)
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DashboardToolsContainer(
                              icon: BipHip.giftNew,
                              iconColor: cAmberAccentColor,
                              titleText: ksStarSmall.tr,
                              subTitleText: ksLearnAboutTheAward.tr,
                            ),
                            kH12sizedBox,
                            DashboardToolsContainer(
                              icon: BipHip.gift,
                              iconColor: cAmberAccentColor,
                              titleText: ksGift.tr,
                              subTitleText: ksLearnAboutTheAward.tr,
                            ),
                            kH12sizedBox,
                            DashboardToolsContainer(
                              icon: BipHip.badgesFill,
                              iconColor: cAmberAccentColor,
                              titleText: ksPendent.tr,
                              subTitleText: ksLearnAboutTheAward.tr,
                            ),
                            kH20sizedBox,
                            Text(
                              ksAchievements.tr,
                              style: semiBold18TextStyle(cBlackColor),
                            ),
                            kH12sizedBox,
                            DashboardToolsContainer(
                              icon: BipHip.activity,
                              iconColor: cAmberAccentColor,
                              titleText: ksQuizHistory.tr,
                              subTitleText: ksLearnAboutTheAward.tr,
                            ),
                            kH12sizedBox,
                            DashboardToolsContainer(
                              icon: BipHip.circlePlus,
                              iconColor: cAmberAccentColor,
                              titleText: ksAwardHistory.tr,
                              subTitleText: ksLearnAboutTheAward.tr,
                            ),
                            kH20sizedBox,
                            Text(
                              ksGrowYourAudience.tr,
                              style: semiBold18TextStyle(cBlackColor),
                            ),
                            kH12sizedBox,
                            DashboardToolsContainer(
                              icon: BipHip.shopFill,
                              iconColor: cAmberAccentColor,
                              titleText: ksAdCenter.tr,
                              subTitleText: ksLearnAboutTheAward.tr,
                            ),
                            kH20sizedBox,
                            Text(
                              ksYourTools.tr,
                              style: semiBold18TextStyle(cBlackColor),
                            ),
                            kH12sizedBox,
                            DashboardToolsContainer(
                              icon: BipHip.calendarFill,
                              iconColor: cAmberAccentColor,
                              titleText: ksCheckInCalender.tr,
                              subTitleText: ksLearnAboutTheAward.tr,
                            ),
                            kH12sizedBox,
                            DashboardToolsContainer(
                              icon: BipHip.addImage,
                              iconColor: cAmberAccentColor,
                              titleText: ksPayouts.tr,
                              subTitleText: ksLearnAboutTheAward.tr,
                            ),
                            kH12sizedBox,
                            DashboardToolsContainer(
                              icon: BipHip.spend,
                              iconColor: cAmberAccentColor,
                              titleText: ksFundTransfer.tr,
                              subTitleText: ksLearnAboutTheAward.tr,
                            ),
                            kH12sizedBox,
                            DashboardToolsContainer(
                              icon: BipHip.donationFill,
                              iconColor: cAmberAccentColor,
                              titleText: ksDonation.tr,
                              subTitleText: ksLearnAboutTheAward.tr,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardToolsContainer extends StatelessWidget {
  const DashboardToolsContainer({super.key, required this.icon, required this.iconColor, this.titleText, this.subTitleText});
  final IconData icon;
  final Color iconColor;
  final String? titleText, subTitleText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width - 40,
      height: 64,
      decoration: BoxDecoration(
        color: cWhiteColor,
        borderRadius: BorderRadius.circular(k8BorderRadius),
        boxShadow: const [
          BoxShadow(
            color: cLineColor,
            blurRadius: 3,
            spreadRadius: 0,
            offset: Offset(
              0,
              1,
            ), // Shadow position
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(k12Padding),
        child: Row(
          children: [
            Icon(
              icon,
              size: kIconSize30,
              color: iconColor,
            ),
            kW12sizedBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titleText ?? ksNA.tr,
                  style: semiBold16TextStyle(cBlackColor),
                ),
                kH4sizedBox,
                Text(
                  subTitleText ?? ksNA.tr,
                  style: regular12TextStyle(cSmallBodyTextColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardInsightsInteractionContent extends StatelessWidget {
  const DashboardInsightsInteractionContent(
      {super.key,
      this.titleText,
      this.reactionsCount,
      this.giftCount,
      this.starCount,
      this.pendentValue,
      this.commentCount,
      this.shareCount,
      this.photoViewCount,
      this.linkClickCount,
      this.othersCount});
  final String? titleText, reactionsCount, giftCount, starCount, pendentValue, commentCount, shareCount, photoViewCount, linkClickCount, othersCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width - 40,
      decoration: BoxDecoration(
        color: cWhiteColor,
        borderRadius: BorderRadius.circular(k8BorderRadius),
        boxShadow: const [
          BoxShadow(
            color: cLineColor,
            blurRadius: 3,
            spreadRadius: 0,
            offset: Offset(
              0,
              1,
            ), // Shadow position
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(k12Padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titleText ?? ksInteractionType.tr,
              style: semiBold16TextStyle(cBlackColor),
            ),
            kH12sizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ksReactions.tr,
                  style: regular12TextStyle(cBlackColor),
                ),
                Text(
                  reactionsCount ?? "0",
                  style: regular12TextStyle(cBlackColor),
                ),
              ],
            ),
            kH12sizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ksGift.tr,
                  style: regular12TextStyle(cBlackColor),
                ),
                Text(
                  giftCount ?? "0",
                  style: regular12TextStyle(cBlackColor),
                ),
              ],
            ),
            kH12sizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ksStar.tr,
                  style: regular12TextStyle(cBlackColor),
                ),
                Text(
                  starCount ?? "0",
                  style: regular12TextStyle(cBlackColor),
                ),
              ],
            ),
            kH12sizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ksPendents.tr,
                  style: regular12TextStyle(cBlackColor),
                ),
                Text(
                  pendentValue ?? "0",
                  style: regular12TextStyle(cBlackColor),
                ),
              ],
            ),
            kH12sizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ksComments.tr,
                  style: regular12TextStyle(cBlackColor),
                ),
                Text(
                  commentCount ?? "0",
                  style: regular12TextStyle(cBlackColor),
                ),
              ],
            ),
            kH12sizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ksShares.tr,
                  style: regular12TextStyle(cBlackColor),
                ),
                Text(
                  shareCount ?? "0",
                  style: regular12TextStyle(cBlackColor),
                ),
              ],
            ),
            kH12sizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ksPhotoViews.tr,
                  style: regular12TextStyle(cBlackColor),
                ),
                Text(
                  photoViewCount ?? "0",
                  style: regular12TextStyle(cBlackColor),
                ),
              ],
            ),
            kH12sizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ksLinkClicks.tr,
                  style: regular12TextStyle(cBlackColor),
                ),
                Text(
                  linkClickCount ?? "0",
                  style: regular12TextStyle(cBlackColor),
                ),
              ],
            ),
            kH12sizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ksOthers.tr,
                  style: regular12TextStyle(cBlackColor),
                ),
                Text(
                  othersCount ?? "0",
                  style: regular12TextStyle(cBlackColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCommonContainer extends StatelessWidget {
  const DashboardCommonContainer(
      {super.key,
      this.width,
      this.height,
      required this.titleText,
      required this.totalValue,
      this.percentValue,
      required this.filterText,
      this.percentTextColor});
  final double? width, height;
  final String titleText, totalValue, filterText;
  final String? percentValue;
  final Color? percentTextColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: cWhiteColor,
        borderRadius: BorderRadius.circular(k8BorderRadius),
        boxShadow: const [
          BoxShadow(
            color: cLineColor,
            blurRadius: 3,
            spreadRadius: 0,
            offset: Offset(
              0,
              1,
            ), // Shadow position
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(k12Padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titleText,
              style: regular14TextStyle(cBlackColor),
            ),
            kH4sizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  totalValue,
                  style: semiBold18TextStyle(cBlackColor),
                ),
                kW4sizedBox,
                if (percentValue != null)
                  Text(
                    percentValue!,
                    style: regular14TextStyle(percentTextColor ?? cBlackColor),
                  ),
              ],
            ),
            kH4sizedBox,
            Text(
              filterText,
              style: regular10TextStyle(cSmallBodyTextColor),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardGiftContentContainer extends StatelessWidget {
  const DashboardGiftContentContainer(
      {super.key,
      this.width,
      this.height,
      this.productImage,
      this.productTitle,
      this.postDate,
      this.postCount,
      this.engagementCount,
      this.giftCount,
      this.isVideoContent = false,
      this.isOnlyTextContent = false});
  final double? width, height;
  final String? productImage, productTitle, postDate, postCount, engagementCount, giftCount;
  final bool isVideoContent, isOnlyTextContent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: cWhiteColor,
        borderRadius: BorderRadius.circular(k8BorderRadius),
        boxShadow: const [
          BoxShadow(
            color: cLineColor,
            blurRadius: 3,
            spreadRadius: 0,
            offset: Offset(
              0,
              1,
            ),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(k12Padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isOnlyTextContent == false)
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(k4BorderRadius),
                        child: Image.network(
                          productImage ?? "",
                          fit: BoxFit.cover,
                          width: 80,
                          height: h60,
                          loadingBuilder: imageLoadingBuilder,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              kiUploadImage,
                              width: 80,
                              height: h60,
                            );
                          },
                        ),
                      ),
                      if (isVideoContent)
                        const Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          top: 0,
                          child: Icon(
                            BipHip.play,
                            color: cWhiteColor,
                            size: kIconSize24,
                          ),
                        ),
                    ],
                  ),
                kW12sizedBox,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productTitle ?? ksNA,
                        style: regular14TextStyle(cBlackColor),
                        overflow: TextOverflow.clip,
                      ),
                      Text(
                        postDate ?? ksNA,
                        style: regular12TextStyle(cSmallBodyTextColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            kH20sizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      postCount ?? "0",
                      style: semiBold16TextStyle(cBlackColor),
                    ),
                    kH4sizedBox,
                    Text(
                      ksPostView.tr,
                      style: regular12TextStyle(cBlackColor),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      engagementCount ?? "0",
                      style: semiBold16TextStyle(cBlackColor),
                    ),
                    kH4sizedBox,
                    Text(
                      ksEngagement.tr,
                      style: regular12TextStyle(cBlackColor),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      giftCount ?? "0",
                      style: semiBold16TextStyle(cBlackColor),
                    ),
                    kH4sizedBox,
                    Text(
                      ksGift.tr,
                      style: regular12TextStyle(cBlackColor),
                    ),
                  ],
                ),
                CustomElevatedButton(
                  buttonWidth: 80,
                  buttonHeight: h32,
                  buttonColor: cPrimaryColor,
                  textStyle: regular14TextStyle(cWhiteColor),
                  label: ksBoostPost.tr,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardAgeGenderChart extends StatelessWidget {
  const DashboardAgeGenderChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(k12Padding),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ksAgeAndGender.tr,
              style: semiBold16TextStyle(cBlackColor),
            ),
            kH12sizedBox,
            Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: cPrimaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                kW4sizedBox,
                Text(
                  ksMen.tr,
                  style: regular12TextStyle(cBlackColor),
                ),
                kW12sizedBox,
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: cOrangeColor,
                    shape: BoxShape.circle,
                  ),
                ),
                kW4sizedBox,
                Text(
                  ksWomen.tr,
                  style: regular12TextStyle(cBlackColor),
                ),
              ],
            ),
            Column(
              children: Get.find<DashboardController>().ageGenderDataList.map((data) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kH12sizedBox,
                          Text(
                            data['ageGroup'],
                            style: regular12TextStyle(cBlackColor),
                          ),
                          kH4sizedBox,
                          SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: (data['men'] * 10).toInt(),
                                  child: Container(
                                    height: h8,
                                    decoration: const BoxDecoration(
                                      color: cPrimaryColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: (data['women'] * 10).toInt(),
                                  child: Container(
                                    height: h8,
                                    decoration: const BoxDecoration(
                                      color: cOrangeColor,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: k20Padding),
                      child: Text(
                        '51.5%',
                        style: regular12TextStyle(cBlackColor),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardTopCitiesChart extends StatelessWidget {
  const DashboardTopCitiesChart({super.key, this.percentWidth, this.percentColor});
  final double? percentWidth;
  final Color? percentColor;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: Get.find<DashboardController>().topCitiesList.map((data) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kH12sizedBox,
                    Text(
                      data['cityName'],
                      style: regular12TextStyle(cBlackColor),
                    ),
                    kH4sizedBox,
                    SizedBox(
                      width: percentWidth ?? 100,
                      child: Row(
                        children: [
                          Expanded(
                            flex: (data['percent'] * 10).toInt(),
                            child: Container(
                              height: h8,
                              decoration: BoxDecoration(
                                color: percentColor ?? cPrimaryColor,
                                borderRadius: BorderRadius.circular(k20BorderRadius),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: k20Padding),
                child: Text(
                  "${data["percent"].toString()}%",
                  style: regular12TextStyle(cBlackColor),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class DashboardTopCountriesChart extends StatelessWidget {
  const DashboardTopCountriesChart({super.key, this.percentWidth, this.percentColor});
  final double? percentWidth;
  final Color? percentColor;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: Get.find<DashboardController>().topCountriesList.map((data) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kH12sizedBox,
                    Text(
                      data['countryName'],
                      style: regular12TextStyle(cBlackColor),
                    ),
                    kH4sizedBox,
                    SizedBox(
                      width: percentWidth ?? 100,
                      child: Row(
                        children: [
                          Expanded(
                            flex: (data['percent'] * 10).toInt(),
                            child: Container(
                              height: h8,
                              decoration: BoxDecoration(
                                color: percentColor ?? cPrimaryColor,
                                borderRadius: BorderRadius.circular(k20BorderRadius),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: k20Padding),
                child: Text(
                  "${data["percent"].toString()}%",
                  style: regular12TextStyle(cBlackColor),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

//!This content is removed after code merge
class QuizTimeFilterBottomSheetContent extends StatelessWidget {
  QuizTimeFilterBottomSheetContent({super.key});
  final DashboardController dashboardController = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => kH12sizedBox,
            itemCount: dashboardController.selectDateTimeFilterList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: Obx(() => CustomListTile(
                      borderColor: dashboardController.selectedQuizTimeRangeValue.value.toLowerCase() ==
                              dashboardController.selectDateTimeFilterList[index].toString().toLowerCase()
                          ? cPrimaryColor
                          : cLineColor,
                      itemColor: dashboardController.selectedQuizTimeRangeValue.value.toLowerCase() ==
                              dashboardController.selectDateTimeFilterList[index].toString().toLowerCase()
                          ? cPrimaryTint2Color
                          : cWhiteColor,
                      leading: Text(
                        dashboardController.selectDateTimeFilterList[index],
                        style: semiBold14TextStyle(cBlackColor),
                      ),
                      onPressed: () {
                        dashboardController.selectedQuizTimeRangeValue.value = dashboardController.selectDateTimeFilterList[index];
                        Get.back();
                      },
                    )),
              );
            }),
      ],
    );
  }
}
