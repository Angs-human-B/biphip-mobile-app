import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardPayouts extends StatelessWidget {
  DashboardPayouts({super.key});
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
              title: ksPayouts.tr,
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
                children: [
                  kH16sizedBox,
                  kH16sizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DashboardCommonContainer(
                        width: (width - 48) / 2,
                        height: 88,
                        titleText: ksTotalEarning.tr,
                        totalValue: "\$365",
                        percentTextColor: cGreenColor,
                      ),
                      kW8sizedBox,
                      DashboardCommonContainer(
                        width: (width - 48) / 2,
                        height: 88,
                        titleText: ksTotalWithdraw.tr,
                        totalValue: "\$170",
                      ),
                    ],
                  ),
                  kH20sizedBox,
                  PayoutsEarningReport(
                    titleText: ksEarningReport.tr,
                    subTitleText: "From last 12 Months",
                    amount: "\$365",
                  ),
                  kH16sizedBox,
                  PayoutsEarningReport(
                    titleText: ksWithdrawReport.tr,
                    subTitleText: "From last 12 Months",
                    amount: "\$170",
                    barChartColor: cOrangeColor,
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

class DashboardCommonContainer extends StatelessWidget {
  const DashboardCommonContainer(
      {super.key, this.width, this.height, required this.titleText, required this.totalValue, this.percentValue, this.percentTextColor});
  final double? width, height;
  final String titleText, totalValue;
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
          mainAxisAlignment: MainAxisAlignment.center,
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
          ],
        ),
      ),
    );
  }
}

class PayoutsEarningReport extends StatelessWidget {
  const PayoutsEarningReport({super.key, required this.titleText, required this.amount, required this.subTitleText, this.barChartColor});
  final String titleText, amount, subTitleText;
  final Color? barChartColor;

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
                  titleText,
                  style: semiBold16TextStyle(cBlackColor),
                ),
                Text(
                  amount,
                  style: regular12TextStyle(cBlackColor),
                ),
              ],
            ),
            Text(
              subTitleText,
              style: regular10TextStyle(cSmallBodyTextColor),
            ),
            kH20sizedBox,
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
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  gridData: const FlGridData(
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
          color: barChartColor ?? cPrimaryTint1Color,
          width: 16,
          borderRadius: BorderRadius.circular(k20BorderRadius),
        ),
      ],
    );
  }
}
