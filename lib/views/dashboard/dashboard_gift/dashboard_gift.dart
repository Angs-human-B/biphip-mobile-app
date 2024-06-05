import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardGift extends StatelessWidget {
  DashboardGift({super.key});
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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kH16sizedBox,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DashboardCommonContainer(
                        width: (width - 48) / 2,
                        height: 88,
                        titleText: ksMyGiftBalance.tr,
                        totalValue: "71",
                        filterText: dashboardController.selectedQuizTimeRangeValue.value,
                        percentTextColor: cGreenColor,
                      ),
                      kW8sizedBox,
                      DashboardCommonContainer(
                        width: (width - 48) / 2,
                        height: 88,
                        titleText: ksGrowthStatics.tr,
                        totalValue: "15k",
                        percentValue: "+15.2",
                        filterText: dashboardController.selectedQuizTimeRangeValue.value,
                        percentTextColor: cGreenColor,
                      ),
                    ],
                  ),
                  kH16sizedBox,
                  const GiftEaringReport(),
                  kH20sizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ksGiftEarnedPost,
                        style: semiBold18TextStyle(cBlackColor),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          ksSeeAll.tr,
                          style: regular16TextStyle(cPrimaryColor),
                        ),
                      ),
                    ],
                  ),
                  kH16sizedBox,
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dashboardController.dashboardEarnedGiftPostList.length > 2 ? 2 : dashboardController.dashboardEarnedGiftPostList.length,
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
                  kH16sizedBox,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardGiftContentContainer extends StatelessWidget {
  const DashboardGiftContentContainer(
      {super.key, this.width, this.height, this.productImage, this.productTitle, this.postDate, this.postCount, this.engagementCount, this.giftCount});
  final double? width, height;
  final String? productImage, productTitle, postDate, postCount, engagementCount, giftCount;

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
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
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

// class GiftTopContainerWidget extends StatelessWidget {
//   const GiftTopContainerWidget({super.key, this.percentValue, required this.titleText, required this.giftAmount, required this.timeRangeValue});
//   final String titleText,giftAmount,timeRangeValue;
//   final String ? percentValue;

//   @override
//   Widget build(BuildContext context) {
//     return  Container(
//                   width: (width - 48) / 2,
//                   height: 88,
//                   decoration: BoxDecoration(
//                     color: cWhiteColor,
//                     border: Border.all(width: 1, color: cLineColor),
//                     borderRadius: BorderRadius.circular(k8BorderRadius),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: cLineColor,
//                         blurRadius: 4,
//                         spreadRadius: 1.5,
//                         offset: Offset(
//                           0,
//                           1,
//                         ),
//                       ),
//                     ],
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(k12Padding),
//                     child: Column(
//                       children: [
//                         Text(titleText,style: ,),
//                       ],
//                     ),
//                   ),
//                 );
//   }
// }

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

//! This is removed when dashboard star is merged in main branch
class GiftEaringReport extends StatelessWidget {
  const GiftEaringReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width - 40,
      height: 280,
      decoration: BoxDecoration(
        color: cWhiteColor,
        border: Border.all(width: 1, color: cLineColor),
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
      child: Padding(
        padding: const EdgeInsets.all(k12Padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Gift Earning Report',
                  style: semiBold16TextStyle(cBlackColor),
                ),
                Container(
                  width: 80,
                  height: h28,
                  decoration: BoxDecoration(
                    color: cNeutralColor,
                    borderRadius: BorderRadius.circular(k4BorderRadius),
                  ),
                  child: Center(
                    child: Text(
                      "Last year",
                      style: regular12TextStyle(cBlackColor),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              'From this year',
              style: regular10TextStyle(cSmallBodyTextColor),
            ),
            SizedBox(height: 20),
            AspectRatio(
              aspectRatio: 1.7,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 400,
                  barGroups: [
                    makeGroupData(0, 200),
                    makeGroupData(1, 100),
                    makeGroupData(2, 200),
                    makeGroupData(3, 300),
                    makeGroupData(4, 200),
                    makeGroupData(5, 100),
                    makeGroupData(6, 100),
                    makeGroupData(7, 200),
                    makeGroupData(8, 150),
                    makeGroupData(9, 200),
                    makeGroupData(10, 250),
                    makeGroupData(11, 100),
                  ],
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const style = TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          );
                          Widget text;
                          switch (value.toInt()) {
                            case 0:
                              text = const Text('Jan', style: style);
                              break;
                            case 1:
                              text = const Text('Feb', style: style);
                              break;
                            case 2:
                              text = const Text('Mar', style: style);
                              break;
                            case 3:
                              text = const Text('Apr', style: style);
                              break;
                            case 4:
                              text = const Text('May', style: style);
                              break;
                            case 5:
                              text = const Text('Jun', style: style);
                              break;
                            case 6:
                              text = const Text('Jul', style: style);
                              break;
                            case 7:
                              text = const Text('Aug', style: style);
                              break;
                            case 8:
                              text = const Text('Sep', style: style);
                              break;
                            case 9:
                              text = const Text('Oct', style: style);
                              break;
                            case 10:
                              text = const Text('Nov', style: style);
                              break;
                            case 11:
                              text = const Text('Dec', style: style);
                              break;
                            default:
                              text = const Text('', style: style);
                              break;
                          }
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            space: 16.0,
                            child: text,
                          );
                        },
                        reservedSize: 40,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const style = TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          );
                          String text;
                          switch (value.toInt()) {
                            case 0:
                              text = '0k';
                              break;
                            case 100:
                              text = '100k';
                              break;
                            case 200:
                              text = '200k';
                              break;
                            case 300:
                              text = '300k';
                              break;
                            case 400:
                              text = '400k';
                              break;
                            default:
                              return Container();
                          }
                          return Text(text, style: style);
                        },
                        reservedSize: 40,
                        interval: 100,
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  gridData: FlGridData(
                    show: false,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: cPrimaryTint1Color,
          width: 16,
          borderRadius: BorderRadius.circular(k20BorderRadius),
        ),
      ],
    );
  }
}
