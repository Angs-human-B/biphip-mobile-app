import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/dashboard/dashboard_overview/dashboard_overview_audience.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';
import 'package:intl/intl.dart';

class DashboardOverview extends StatelessWidget {
  DashboardOverview({super.key});
  final DashboardController dashboardController = Get.find<DashboardController>();

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
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                                  // if (dashboardController.dashboardOverviewSelectedFilterIndex.value == 1) {
                                  //   // await Get.find<DashboardController>().getDashboardContents();
                                  //   await Get.find<DashboardController>().getDashboardProfileOverview();
                                  // }
                                  dashboardController.dashboardOverviewSelectedFilterValue.value = dashboardController.dashboardOverviewFilterList[index];
                                },
                              ),
                            ));
                      },
                    ),
                  ),
                  kH20sizedBox,
                  if (dashboardController.dashboardOverviewSelectedFilterIndex.value == 0)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DashboardOverviewCommonRowTextIcon(
                                titleText: ksPerformance.tr,
                                icon: BipHip.info,
                                iconOnPressed: null,
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
                          kH4sizedBox,
                          Row(
                            children: [
                              Text(
                                dashboardController.dashboardOverviewData.value?.followers.toString() ?? ksNA.tr,
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
                          kH16sizedBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              DashboardCommonContainer(
                                width: (width - 48) / 2,
                                height: 88,
                                titleText: ksReach.tr,
                                totalValue: dashboardController.dashboardOverviewData.value?.postReach.toString() ?? ksNA.tr,
                                percentValue: "+39%", //!Percent value missing from api
                                filterText: dashboardController.dashboardOverviewTime.value,
                                percentTextColor: cGreenColor,
                              ),
                              kW8sizedBox,
                              DashboardCommonContainer(
                                width: (width - 48) / 2,
                                height: 88,
                                titleText: ksContentPublished.tr,
                                totalValue: dashboardController.dashboardOverviewData.value?.postEngagement.toString() ??
                                    ksNA.tr, //!published content count value missing in api
                                percentValue: "+0%", //!Percent value missing from api
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
                                totalValue: dashboardController.dashboardOverviewData.value?.postEngagement.toString() ?? ksNA.tr,
                                percentValue: "+350%", //!Percent value missing from api
                                filterText: dashboardController.dashboardOverviewTime.value,
                                percentTextColor: cGreenColor,
                              ),
                              kW8sizedBox,
                              DashboardCommonContainer(
                                width: (width - 48) / 2,
                                height: 88,
                                titleText: ksNetFollowers.tr,
                                totalValue: dashboardController.dashboardOverviewData.value?.newFollowers.toString() ?? ksNA.tr,
                                percentValue: "+12%", //!Percent value missing from api
                                filterText: dashboardController.dashboardOverviewTime.value,
                                percentTextColor: cGreenColor,
                              ),
                            ],
                          ),
                          kH16sizedBox,
                          Container(
                            height: h8,
                            width: width,
                            color: cBackgroundColor,
                          ),
                          kH16sizedBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ksRecentContent.tr,
                                style: semiBold18TextStyle(cBlackColor),
                              ),
                              InkWell(
                                  onTap: () async {
                                    // dashboardController.dashboardOverviewSelectedContentFilterIndex.value = 0;
                                    await dashboardController.getDashboardContents();
                                    Get.toNamed(krDashboardOverviewContent);
                                  },
                                  child: Text(
                                    ksSeeAll.tr,
                                    style: regular16TextStyle(cPrimaryColor),
                                  )),
                            ],
                          ),
                          kH16sizedBox,
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                dashboardController.dashboardOverviewContentList.length > 1 ? 1 : dashboardController.dashboardOverviewContentList.length,
                            separatorBuilder: (context, index) => kH16sizedBox,
                            itemBuilder: (context, index) {
                              return DashboardGiftContentContainer(
                                width: width - 40,
                                height: 150,
                                // productImage: dashboardController.contentList[index].details.,
                                productTitle: dashboardController.dashboardOverviewContentList[index].details?.content ?? "",
                                postDate: DateFormat("dMMM, yyyy").format(dashboardController.dashboardOverviewContentList[index].details!.dateTime!),
                                postCount: dashboardController.dashboardOverviewContentList[index].details?.countComment
                                    .toString(), //!post count data not available from api
                                engagementCount: dashboardController.dashboardOverviewContentList[index].engagement.toString(),
                                giftCount: dashboardController.dashboardOverviewContentList[index].details?.countStar.toString(), //!Gift count missing
                              );
                            },
                          ),
                          kH16sizedBox,
                          Container(
                            height: h8,
                            width: width,
                            color: cBackgroundColor,
                          ),
                          kH16sizedBox,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  DashboardOverviewCommonRowTextIcon(
                                    titleText: ksAudiences.tr,
                                    icon: BipHip.info,
                                    iconOnPressed: null,
                                  ),
                                  InkWell(
                                      onTap: () async {
                                        await dashboardController.getDashboardAudienceInsightByCountry();
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
                          kH16sizedBox,
                        ],
                      ),
                    ),
                  if (dashboardController.dashboardOverviewSelectedFilterIndex.value == 0)
                    SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(left: k20Padding),
                        child: Row(
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
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
                                    child: const DashboardAgeGenderChart())),
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
                                      padding: EdgeInsets.only(left: k12Padding, right: k12Padding),
                                      child: DashboardTopCitiesChart(),
                                    ),
                                  ],
                                )),
                            kW8sizedBox,
                          ],
                        ),
                      ),
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
                                  totalValue: dashboardController.dashboardProfileOverviewData.value!.postReach.toString(),
                                  percentValue: "+39%", //! post reachPercent value missing
                                  filterText: dashboardController.dashboardOverviewTime.value,
                                  percentTextColor: cGreenColor,
                                ),
                                kW8sizedBox,
                                DashboardCommonContainer(
                                  width: (width - 48) / 2,
                                  height: 88,
                                  titleText: ksContentPublished.tr,
                                  totalValue: dashboardController.dashboardProfileOverviewData.value!.gifts.toString(), //!published content data missing in api
                                  percentValue: "+0%",
                                  filterText: ksLast28Days.tr,
                                  percentTextColor: cGreenColor,
                                ),
                                kW8sizedBox,
                                DashboardCommonContainer(
                                  width: (width - 48) / 2,
                                  height: 88,
                                  titleText: ksEngagement.tr,
                                  totalValue: dashboardController.dashboardProfileOverviewData.value!.postEngagement.toString(),
                                  percentValue: "+350%", //!percent value missing
                                  filterText: ksLast28Days.tr,
                                  percentTextColor: cGreenColor,
                                ),
                                kW8sizedBox,
                                DashboardCommonContainer(
                                  width: (width - 48) / 2,
                                  height: 88,
                                  titleText: ksNetFollowers.tr,
                                  totalValue: dashboardController.dashboardProfileOverviewData.value!.newProfileFollowers.toString(),
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
                          DashboardInsightsInteractionContent(
                            reactionsCount: dashboardController.dashboardProfileOverviewData.value?.reactions.toString(),
                            giftCount: dashboardController.dashboardProfileOverviewData.value?.gifts.toString(),
                            starCount: dashboardController.dashboardProfileOverviewData.value?.stars.toString(),
                            pendentValue: dashboardController.dashboardProfileOverviewData.value?.pendents.toString(),
                            commentCount: dashboardController.dashboardProfileOverviewData.value?.comments.toString(),
                            shareCount: dashboardController.dashboardProfileOverviewData.value?.shares.toString(),
                            photoViewCount: dashboardController.dashboardProfileOverviewData.value?.photoViews.toString(),
                            linkClickCount: dashboardController.dashboardProfileOverviewData.value?.linkClicks.toString(),
                            // othersCount: dashboardController.dashboardProfileOverviewData.value!..toString(),
                          ),
                        ],
                      ),
                    ),
                  if (dashboardController.dashboardOverviewSelectedFilterIndex.value == 2)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ksNotYetEligible.tr,
                            style: semiBold18TextStyle(cBlackColor),
                          ),
                          kH4sizedBox,
                          Text(
                            ksAsYouGrowYourAudience.tr,
                            style: regular12TextStyle(cSmallBodyTextColor),
                          ),
                          kH20sizedBox,
                          Text(
                            ksGrowYourAudience.tr,
                            style: semiBold18TextStyle(cBlackColor),
                          ),
                          kH16sizedBox,
                          ProgressItem(
                            title: ksFamilies.tr,
                            progressValue: 0.96,
                            progressColor: cPrimaryColor,
                            currentValue: "19/20",
                            percentage: "96%",
                          ),
                          kH16sizedBox,
                          ProgressItem(
                            title: ksFriendsToFriends.tr,
                            progressValue: 0.33,
                            progressColor: cRedColor,
                            currentValue: "33/100",
                            percentage: "33%",
                          ),
                          kH16sizedBox,
                          ProgressItem(
                            title: ksFamiliesToFamilies.tr,
                            progressValue: 0.54,
                            progressColor: cPrimaryColor,
                            currentValue: "54/100",
                            percentage: "54%",
                          ),
                          kH20sizedBox,
                          Text(
                            ksGrowYourEngagements.tr,
                            style: semiBold18TextStyle(cBlackColor),
                          ),
                          kH16sizedBox,
                          ProgressItem(
                            title: ksReact.tr,
                            progressValue: 0.80,
                            progressColor: cPrimaryColor,
                            currentValue: "80/100",
                            percentage: "80%",
                          ),
                          kH16sizedBox,
                          ProgressItem(
                            title: ksPostShare.tr,
                            progressValue: 0.9,
                            progressColor: cPrimaryColor,
                            currentValue: "90/100",
                            percentage: "90%",
                          ),
                          kH16sizedBox,
                          ProgressItem(
                            title: ksSelfieShare.tr,
                            progressValue: 0.33,
                            progressColor: cRedColor,
                            currentValue: '33/100',
                            percentage: '33%',
                          ),
                        ],
                      ),
                    ),
                  if (dashboardController.dashboardOverviewSelectedFilterIndex.value == 3)
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DashboardToolsContainer(
                              icon: BipHip.giftNew,
                              iconColor: cAmberAccentColor,
                              titleText: ksStarSmall.tr,
                              subTitleText: ksLearnAboutTheAward.tr,
                              toolsOnPressed: () async {
                                await dashboardController.getDashboardStarInsight();
                                Get.toNamed(krDashboardStar);
                              },
                            ),
                            kH12sizedBox,
                            DashboardToolsContainer(
                              icon: BipHip.gift,
                              iconColor: cAmberAccentColor,
                              titleText: ksGift.tr,
                              subTitleText: ksLearnAboutTheAward.tr,
                              toolsOnPressed: () async {
                                await dashboardController.getDashboardGiftInsight();
                                await dashboardController.getGiftEarnedPost();
                                Get.toNamed(krDashboardGift);
                              },
                            ),
                            kH12sizedBox,
                            DashboardToolsContainer(
                              icon: BipHip.badgesFill,
                              iconColor: cPrimaryColor,
                              titleText: ksPendent.tr,
                              subTitleText: ksLearnAboutTheAward.tr,
                              toolsOnPressed: () {},
                            ),
                            kH20sizedBox,
                            Text(
                              ksAchievements.tr,
                              style: semiBold18TextStyle(cBlackColor),
                            ),
                            kH12sizedBox,
                            DashboardToolsContainer(
                              icon: BipHip.activity,
                              iconColor: cPrimaryColor,
                              titleText: ksQuizHistory.tr,
                              subTitleText: ksLearnAboutTheAward.tr,
                              toolsOnPressed: () {
                                Get.toNamed(krDashboardQuiz);
                              },
                            ),
                            kH12sizedBox,
                            DashboardToolsContainer(
                              icon: BipHip.circlePlus,
                              iconColor: cPrimaryColor,
                              titleText: ksAwardHistory.tr,
                              subTitleText: ksLearnAboutTheAward.tr,
                              toolsOnPressed: () {
                                Get.toNamed(krDashboardAward);
                              },
                            ),
                            kH20sizedBox,
                            Text(
                              ksGrowYourAudience.tr,
                              style: semiBold18TextStyle(cBlackColor),
                            ),
                            kH12sizedBox,
                            DashboardToolsContainer(
                              icon: BipHip.shopFill,
                              iconColor: cPrimaryColor,
                              titleText: ksAdCenter.tr,
                              subTitleText: ksLearnAboutTheAward.tr,
                              toolsOnPressed: () {},
                            ),
                            kH20sizedBox,
                            Text(
                              ksYourTools.tr,
                              style: semiBold18TextStyle(cBlackColor),
                            ),
                            kH12sizedBox,
                            DashboardToolsContainer(
                              icon: BipHip.calendarFill,
                              iconColor: cPrimaryColor,
                              titleText: ksCheckInCalender.tr,
                              subTitleText: ksLearnAboutTheAward.tr,
                              toolsOnPressed: () {
                                Get.toNamed(krDashboardCheckInCalender);
                              },
                            ),
                            kH12sizedBox,
                            DashboardToolsContainer(
                              icon: BipHip.addImage,
                              iconColor: cPrimaryColor,
                              titleText: ksPayouts.tr,
                              subTitleText: ksLearnAboutTheAward.tr,
                              toolsOnPressed: () {},
                            ),
                            kH12sizedBox,
                            DashboardToolsContainer(
                              icon: BipHip.spend,
                              iconColor: cPrimaryColor,
                              titleText: ksFundTransfer.tr,
                              subTitleText: ksLearnAboutTheAward.tr,
                              toolsOnPressed: () {
                                Get.toNamed(krDashboardFundTransfer);
                              },
                            ),
                            kH12sizedBox,
                            DashboardToolsContainer(
                              icon: BipHip.donationFill,
                              iconColor: cPrimaryColor,
                              titleText: ksDonation.tr,
                              subTitleText: ksLearnAboutTheAward.tr,
                              toolsOnPressed: () {
                                Get.toNamed(krDashboardDonation);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardToolsContainer extends StatelessWidget {
  const DashboardToolsContainer({super.key, required this.icon, required this.iconColor, this.titleText, this.subTitleText, this.toolsOnPressed});
  final IconData icon;
  final Color iconColor;
  final String? titleText, subTitleText;
  final VoidCallback? toolsOnPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: toolsOnPressed,
      child: Container(
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
              ),
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
      {super.key, this.width, this.height, this.titleText, this.totalValue, this.percentValue, this.filterText, this.percentTextColor});
  final double? width, height;
  final String? titleText, totalValue, filterText, percentValue;
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
              titleText ?? ksNA.tr,
              style: regular14TextStyle(cBlackColor),
            ),
            kH4sizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  totalValue ?? "0",
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
              filterText ?? ksNA.tr,
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
                if (productImage != null)
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
    final audience = Get.find<DashboardController>().dashboardOverviewData.value!.audience;

    return Padding(
      padding: const EdgeInsets.all(k12Padding),
      child: Column(
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
            children: audience!.ageGroup!.entries.map((entry) {
              final ageGroup = entry.key;
              final data = entry.value;
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        kH12sizedBox,
                        Text(
                          ageGroup,
                          style: regular12TextStyle(cBlackColor),
                        ),
                        kH4sizedBox,
                        SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              Expanded(
                                flex: (data.men! * 10),
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
                                flex: (data.women! * 10),
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
                      data.men! > data.women! ? "${data.men!}%" : "${data.women!}%",
                      style: regular12TextStyle(cBlackColor),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class DashboardTopCitiesChart extends StatelessWidget {
  const DashboardTopCitiesChart({super.key,});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var topCitiesList = Get.find<DashboardController>().topCitiesList;
        return Column(
          children: topCitiesList.map((data) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kH12sizedBox,
                      Text(
                        data.country!,
                        style: regular12TextStyle(cBlackColor),
                      ),
                      kH4sizedBox,
                      Row(
                        children: [
                          Container(
                            height: h8,
                            width: (width - 75) * (data.audience! / 100).toDouble(),
                            decoration: BoxDecoration(
                              color: cPrimaryColor,
                              borderRadius: BorderRadius.circular(k20BorderRadius),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: k20Padding),
                  child: Text(
                    "${data.audience.toString()}%",
                    style: regular12TextStyle(cBlackColor),
                  ),
                ),
              ],
            );
          }).toList(),
        );
      },
    );
  
  }
}





// class DashboardTopCountriesChart extends StatelessWidget {
//   const DashboardTopCountriesChart({super.key, this.percentWidth, this.percentColor});
//   final double? percentWidth;
//   final Color? percentColor;

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Column(
//         children: Get.find<DashboardController>().topCountriesList.map((data) {
//           return Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     kH12sizedBox,
//                     Text(
//                       data['countryName'],
//                       style: regular12TextStyle(cBlackColor),
//                     ),
//                     kH4sizedBox,
//                     SizedBox(
//                       width: percentWidth ?? 100,
//                       child: Row(
//                         children: [
//                           Expanded(
//                             flex: (data['percent'] * 10).toInt(),
//                             child: Container(
//                               height: h8,
//                               decoration: BoxDecoration(
//                                 color: percentColor ?? cPrimaryColor,
//                                 borderRadius: BorderRadius.circular(k20BorderRadius),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: k20Padding),
//                 child: Text(
//                   "${data["percent"].toString()}%",
//                   style: regular12TextStyle(cBlackColor),
//                 ),
//               ),
//             ],
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

class DashboardTopCountriesChart extends StatelessWidget {
  const DashboardTopCountriesChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var topCountriesList = Get.find<DashboardController>().dashboardAudienceInsightByCountryList;
        return Column(
          children: topCountriesList.map((data) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kH12sizedBox,
                      Text(
                        data.country!,
                        style: regular12TextStyle(cBlackColor),
                      ),
                      kH4sizedBox,
                      Row(
                        children: [
                          Container(
                            height: h8,
                            width: (width - 75) * (data.audience! / 100).toDouble(),
                            decoration: BoxDecoration(
                              color: cPrimaryColor,
                              borderRadius: BorderRadius.circular(k20BorderRadius),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: k20Padding),
                  child: Text(
                    "${data.audience.toString()}%",
                    style: regular12TextStyle(cBlackColor),
                  ),
                ),
              ],
            );
          }).toList(),
        );
      },
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

class ProgressItem extends StatelessWidget {
  final String title;
  final double progressValue;
  final Color progressColor;
  final String currentValue;
  final String percentage;

  const ProgressItem({
    Key? key,
    required this.title,
    required this.progressValue,
    required this.progressColor,
    required this.currentValue,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(k8BorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: regular12TextStyle(cBlackColor),
          ),
          kH4sizedBox,
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(k20BorderRadius),
                  child: LinearProgressIndicator(
                    value: progressValue,
                    backgroundColor: cNeutralColor,
                    color: progressColor,
                    minHeight: h8,
                    borderRadius: BorderRadius.circular(k20BorderRadius),
                  ),
                ),
              ),
              kW8sizedBox,
              Text(
                percentage,
                style: regular12TextStyle(cBlackColor),
              ),
            ],
          ),
          kH4sizedBox,
          Text(
            currentValue,
            style: regular12TextStyle(cBlackColor),
          ),
        ],
      ),
    );
  }
}
