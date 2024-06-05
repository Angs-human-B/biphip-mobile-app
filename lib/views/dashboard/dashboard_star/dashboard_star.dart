import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardStar extends StatelessWidget {
  DashboardStar({super.key});
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
              title: ksStar.tr,
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
                  Container(
                    width: width - 40,
                    height: 76,
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
                    child: Padding(
                      padding: const EdgeInsets.all(k12Padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ksTotalStar.tr,
                            style: regular14TextStyle(cBlackColor),
                          ),
                          kH8sizedBox,
                          Text(
                            "14,29",
                            style: semiBold18TextStyle(cBlackColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  kH16sizedBox,
                  Container(
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
                            ), // Shadow position
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(k12Padding),
                        child: StarGiftReport(),
                      )),
                  kH20sizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ksStarPurchaseHistory.tr,
                        style: semiBold18TextStyle(cBlackColor),
                      ),
                      Text(
                        ksSeeAll.tr,
                        style: regular16TextStyle(cPrimaryColor),
                      ),
                    ],
                  ),
                  kH16sizedBox,
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dashboardController.starPurchaseHistoryList.length,
                    separatorBuilder: (context, index) => kH16sizedBox,
                    itemBuilder: (context, index) {
                      return StarPurchaseAndGiftContent(
                        date: dashboardController.starPurchaseHistoryList[index]["date"],
                        packageIcon: dashboardController.starPurchaseHistoryList[index]["packageIcon"],
                        packageName: dashboardController.starPurchaseHistoryList[index]["packageName"],
                        packageAmount: dashboardController.starPurchaseHistoryList[index]["starAmount"].toString(),
                        price: dashboardController.starPurchaseHistoryList[index]["price"].toString(),
                      );
                    },
                  ),
                  kH20sizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ksStarGiftHistory.tr,
                        style: semiBold18TextStyle(cBlackColor),
                      ),
                      Text(
                        ksSeeAll.tr,
                        style: regular16TextStyle(cPrimaryColor),
                      ),
                    ],
                  ),
                  kH16sizedBox,
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dashboardController.starGiftHistoryList.length,
                    separatorBuilder: (context, index) => kH16sizedBox,
                    itemBuilder: (context, index) {
                      return StarPurchaseAndGiftContent(
                        date: dashboardController.starGiftHistoryList[index]["date"],
                        packageIcon: dashboardController.starGiftHistoryList[index]["packageIcon"],
                        packageName: dashboardController.starGiftHistoryList[index]["packageName"],
                        packageAmount: dashboardController.starGiftHistoryList[index]["starAmount"].toString(),
                        price: dashboardController.starGiftHistoryList[index]["price"].toString(),
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

class StarGiftReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Star Gift Report',
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

class StarPurchaseAndGiftContent extends StatelessWidget {
  const StarPurchaseAndGiftContent(
      {super.key, required this.date, required this.packageName, required this.packageAmount, required this.price, required this.packageIcon});
  final String date, packageName, packageAmount, price;
  final IconData packageIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          date,
          style: regular12TextStyle(cBlackColor),
        ),
        Row(
          children: [
            Icon(
              packageIcon,
              size: kIconSize12,
              color: cAmberColor,
            ),
            kW4sizedBox,
            Text(
              packageName,
              style: regular12TextStyle(cBlackColor),
            ),
          ],
        ),
        Text(
          packageAmount,
          style: regular12TextStyle(cBlackColor),
        ),
        Text(
          price,
          style: regular12TextStyle(cBlackColor),
        ),
      ],
    );
  }
}
