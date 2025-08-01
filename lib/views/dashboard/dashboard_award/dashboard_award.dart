import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/controllers/menu/award_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/dashboard/dashboard_overview/dashboard_overview.dart';
import 'package:bip_hip/views/dashboard/dashboard_quiz.dart';
import 'package:bip_hip/views/menu/awards/awards_details_page.dart';
import 'package:bip_hip/views/menu/awards/awards_page.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardAward extends StatelessWidget {
  DashboardAward({super.key});
  final DashboardController dashboardController = Get.find<DashboardController>();
  final AwardController awardController = Get.find<AwardController>();

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
              title: ksAwardHistiry.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Obx(
              () => Column(
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
                      // InkWell(
                      //   onTap: () {
                      //     dashboardController.temporarySelectedCategoryId.value = dashboardController.selectedCategoryId.value;
                      //     dashboardController.temporarySelectedCategory.value = dashboardController.selectedCategory.value;
                      //     if (dashboardController.temporarySelectedCategoryId.value == -1) {
                      //       dashboardController.categoryRightButtonState.value = false;
                      //     } else {
                      //       dashboardController.categoryRightButtonState.value = true;
                      //     }
                      //     Get.find<GlobalController>().commonBottomSheet(
                      //       context: context,
                      //       bottomSheetHeight: height * 0.6,
                      //       content: CategoryBottomSheetContent(),
                      //       onPressCloseButton: () {
                      //         Get.back();
                      //       },
                      //       onPressRightButton: () {
                      //         dashboardController.selectedCategoryId.value = dashboardController.temporarySelectedCategoryId.value;
                      //         dashboardController.selectedCategory.value = dashboardController.temporarySelectedCategory.value;
                      //         Get.back();
                      //       },
                      //       rightText: ksDone.tr,
                      //       rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                      //       title: ksSelectCategory.tr,
                      //       isRightButtonShow: true,
                      //       isBottomSheetRightButtonActive: dashboardController.categoryRightButtonState,
                      //     );
                      //   },
                      //   child: Container(
                      //     height: h28,
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(k4BorderRadius),
                      //       color: cNeutralColor,
                      //     ),
                      //     child: Row(
                      //       children: [
                      //         Padding(
                      //           padding: const EdgeInsets.symmetric(horizontal: k8Padding, vertical: k4Padding),
                      //           child: Text(
                      //             dashboardController.selectedCategory.value,
                      //             style: regular12TextStyle(cBlackColor),
                      //           ),
                      //         ),
                      //         const Padding(
                      //           padding: EdgeInsets.only(top: k4Padding, bottom: k4Padding, right: k8Padding),
                      //           child: Icon(
                      //             BipHip.downArrow,
                      //             size: kIconSize20,
                      //             color: cBlackColor,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  kH20sizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ksPerformance.tr,
                        style: semiBold18TextStyle(cBlackColor),
                      ),
                      InkWell(
                          onTap: () {
                            Get.toNamed(krDashboardPerformance);
                          },
                          child: Text(
                            ksSeeAll.tr,
                            style: regular16TextStyle(cPrimaryColor),
                          )),
                    ],
                  ),
                  kH16sizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DashboardCommonContainer(
                        width: (width - 48) / 2,
                        titleText: "Total Win",
                        totalValue: "10",
                        percentValue: "+5%",
                        filterText: dashboardController.selectedQuizTimeRangeValue.value,
                        percentTextColor: cGreenColor,
                      ),
                      kW8sizedBox,
                      DashboardCommonContainer(
                        width: (width - 48) / 2,
                        titleText: "Winning Ratio",
                        totalValue: "1.1",
                        percentValue: "-15.2",
                        filterText: dashboardController.selectedQuizTimeRangeValue.value,
                        percentTextColor: cRedColor,
                      ),
                    ],
                  ),
                  kH20sizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ksRecentAwards.tr,
                        style: semiBold18TextStyle(cBlackColor),
                      ),
                      InkWell(
                          onTap: () {
                            Get.toNamed(krDashboardAllAwards);
                          },
                          child: Text(
                            ksSeeAll.tr,
                            style: regular16TextStyle(cPrimaryColor),
                          )),
                    ],
                  ),
                  kH16sizedBox,
                  // Expanded(
                  //   child: SingleChildScrollView(
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         GridView.builder(
                  //           shrinkWrap: true,
                  //           physics: const NeverScrollableScrollPhysics(),
                  //           itemCount: awardController.myAwardList.length,
                  //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //             childAspectRatio: 0.75,
                  //             crossAxisCount: 3,
                  //             crossAxisSpacing: k16Padding,
                  //             mainAxisSpacing: k16Padding,
                  //           ),
                  //           itemBuilder: (BuildContext context, int index) {
                  //             return InkWell(
                  //               onTap: () {
                  //                 awardController.isOthersWinner.value = false;
                  //                 Get.to(() => AwardDetailsPage(
                  //                       userImage: awardController.myAwardList[index].user!.profilePicture,
                  //                       userName: awardController.myAwardList[index].user!.fullName,
                  //                       ranking: awardController.myAwardList[index].rank.toString(),
                  //                       certificateImage: "",
                  //                       winningDate: DateFormat('d MMM, yyyy').format(awardController.myAwardList[index].winDate!),
                  //                     ));
                  //               },
                  //               child: AwardView(
                  //                 image: awardController.myAwardList[index].user?.profilePicture,
                  //                 ranking: awardController.myAwardList[index].rank.toString(),
                  //                 titleText: DateFormat('d MMM, yyyy').format(awardController.myAwardList[index].winDate!),
                  //               ),
                  //             );
                  //           },
                  //         ),
                  //         kH16sizedBox,
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  dashboardController.allAwardList.isNotEmpty
                      ? Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: dashboardController.allAwardList.length > 6 ? 6 : dashboardController.allAwardList.length,
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
      ),
    );
  }
}

class LineChartWidget extends StatelessWidget {
  const LineChartWidget(
      {super.key,
      this.percentTextColor,
      this.progressColor,
      this.progressBottomColor,
      required this.titleText,
      required this.percentText,
      required this.filterDateTimeText,
      required this.totalValue});
  final Color? percentTextColor, progressColor, progressBottomColor;
  final String titleText, percentText, filterDateTimeText, totalValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width - 40,
      height: 200,
      decoration: BoxDecoration(
        color: cWhiteColor,
        borderRadius: BorderRadius.circular(k8BorderRadius),
        boxShadow: const [
          BoxShadow(
            color: cLineColor,
            blurRadius: 4,
            spreadRadius: 1.5,
            offset: Offset(
              0,
              1,
            ),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 3),
                      FlSpot(1, 3.5),
                      FlSpot(2, 4),
                      FlSpot(3, 4.5),
                      FlSpot(4, 4),
                      FlSpot(5, 5),
                      FlSpot(6, 4.5),
                    ],
                    isCurved: true,
                    color: progressColor ?? cGreenColor,
                    barWidth: 2,
                    isStrokeCapRound: true,
                    belowBarData: BarAreaData(
                      show: true,
                      color: progressBottomColor ?? cGreenTintColor,
                    ),
                    dotData: const FlDotData(show: false),
                  ),
                ],
                minX: 0,
                maxX: 6,
                minY: 2,
                maxY: 6,
              ),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titleText,
                  style: semiBold16TextStyle(cBlackColor),
                ),
                Text(
                  filterDateTimeText,
                  style: regular10TextStyle(cSmallBodyTextColor),
                ),
              ],
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  totalValue,
                  style: semiBold18TextStyle(cBlackColor),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: k4Padding, left: k4Padding),
                  child: Text(
                    percentText,
                    style: regular12TextStyle(percentTextColor ?? cGreenColor),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class CategoryBottomSheetContent extends StatelessWidget {
  CategoryBottomSheetContent({super.key});
  final DashboardController dashboardController = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => kH12sizedBox,
            itemCount: dashboardController.categoryFilterList.length,
            itemBuilder: (context, index) {
              return Obx(
                () => CustomListTile(
                  borderColor:
                      dashboardController.temporarySelectedCategoryId.value == dashboardController.categoryFilterList[index]["id"] ? cPrimaryColor : cLineColor,
                  itemColor: dashboardController.temporarySelectedCategoryId.value == dashboardController.categoryFilterList[index]["id"]
                      ? cPrimaryTint2Color
                      : cWhiteColor,
                  leading: Icon(
                    dashboardController.categoryFilterList[index]["categoryIcon"],
                    size: kIconSize20,
                    color: dashboardController.categoryIconColor(index),
                  ),
                  title: Text(
                    dashboardController.categoryFilterList[index]["categoryName"],
                    style: semiBold14TextStyle(cBlackColor),
                  ),
                  onPressed: () {
                    dashboardController.temporarySelectedCategoryId.value = dashboardController.categoryFilterList[index]["id"];
                    dashboardController.temporarySelectedCategory.value = dashboardController.categoryFilterList[index]["categoryName"];
                    dashboardController.categoryRightButtonState.value = true;
                    ll(dashboardController.temporarySelectedCategoryId.value);
                  },
                  trailing: Obx(() => CustomRadioButton(
                        onChanged: () {
                          dashboardController.temporarySelectedCategoryId.value = dashboardController.categoryFilterList[index]["id"];
                          dashboardController.temporarySelectedCategory.value = dashboardController.categoryFilterList[index]["categoryName"];
                          dashboardController.categoryRightButtonState.value = true;
                        },
                        isSelected: dashboardController.temporarySelectedCategoryId.value == dashboardController.categoryFilterList[index]["id"],
                      )),
                ),
              );
            }),
      ],
    );
  }
}
