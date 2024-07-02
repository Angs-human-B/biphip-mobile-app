import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/dashboard/dashboard_overview/dashboard_overview.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardOverviewAudience extends StatelessWidget {
  const DashboardOverviewAudience({super.key});

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
              title: ksAudience.tr,
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
                  DashboardOverviewCommonRowTextIcon(
                    titleText: ksAgeAndGender.tr,
                    icon: BipHip.info,
                    iconOnPressed: null,
                  ),
                  kH16sizedBox,
                  const SizedBox(width: 100, height: 100, child: AgeGenderPieChart()),
                  kH16sizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: h8,
                        height: h8,
                        decoration: const BoxDecoration(
                          color: cPrimaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      kW4sizedBox,
                      Text(
                        "87.5%Men",
                        style: regular12TextStyle(cBlackColor),
                      ),
                      kW24sizedBox,
                      Container(
                        width: h8,
                        height: h8,
                        decoration: const BoxDecoration(
                          color: cOrangeColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      kW4sizedBox,
                      Text(
                        "12.5%Women",
                        style: regular12TextStyle(cBlackColor),
                      ),
                    ],
                  ),
                  kH40sizedBox,
                  //* barchart
                  SizedBox(width: width - 40, height: 200, child: const AgeGenderBarChart()),
                  kH40sizedBox,
                  DashboardOverviewCommonRowTextIcon(
                    titleText: ksTopCountries.tr,
                    icon: BipHip.info,
                    iconOnPressed: null,
                  ),
                  Container(
                      width: width - 40,
                      decoration: const BoxDecoration(
                        color: cWhiteColor,
                      ),
                      child: const DashboardTopCountriesChart(
                        percentColor: cPrimaryColor,
                        percentWidth: 70,
                      )),
                  kH40sizedBox,
                  DashboardOverviewCommonRowTextIcon(
                    titleText: ksTopCities.tr,
                    icon: BipHip.info,
                    iconOnPressed: null,
                  ),
                  Container(
                      width: width - 40,
                      decoration: const BoxDecoration(
                        color: cWhiteColor,
                      ),
                      child: const DashboardTopCitiesChart(
                        percentColor: cPrimaryColor,
                        percentWidth: 70,
                      )),
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

class DashboardOverviewCommonRowTextIcon extends StatelessWidget {
  const DashboardOverviewCommonRowTextIcon({super.key, required this.titleText, required this.icon, this.iconOnPressed});
  final String titleText;
  final IconData icon;
  final VoidCallback? iconOnPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          titleText,
          style: semiBold16TextStyle(cBlackColor),
        ),
        kW8sizedBox,
        InkWell(
          onTap: iconOnPressed,
          child: Icon(
            icon,
            color: cIconColor,
            size: kIconSize14,
          ),
        )
      ],
    );
  }
}

class AgeGenderPieChart extends StatelessWidget {
  const AgeGenderPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PieChart(
          PieChartData(
            sections: [
              PieChartSectionData(value: 85.7, color: cPrimaryColor, radius: 15, showTitle: false),
              PieChartSectionData(
                value: 14.3,
                color: cOrangeColor,
                radius: 15,
                showTitle: false,
              ),
            ],
            sectionsSpace: 0,
            centerSpaceRadius: 40,
          ),
        ),
      ),
    );
  }
}

class AgeGenderBarChart extends StatelessWidget {
  const AgeGenderBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 50,
        barTouchData: BarTouchData(
          enabled: false,
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text('${value.toInt()}%', style: regular10TextStyle(cBlackColor));
              },
              reservedSize: 28,
              interval: 10,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                switch (value.toInt()) {
                  case 0:
                    return Padding(
                      padding: const EdgeInsets.only(top: k8Padding),
                      child: Text(
                        '18-24',
                        style: regular10TextStyle(cBlackColor),
                      ),
                    );
                  case 1:
                    return Padding(
                      padding: const EdgeInsets.only(top: k8Padding),
                      child: Text(
                        '25-34',
                        style: regular10TextStyle(cBlackColor),
                      ),
                    );
                  case 2:
                    return Padding(
                      padding: const EdgeInsets.only(top: k8Padding),
                      child: Text(
                        '35-44',
                        style: regular10TextStyle(cBlackColor),
                      ),
                    );
                  case 3:
                    return Padding(
                      padding: const EdgeInsets.only(top: k8Padding),
                      child: Text(
                        '45-60',
                        style: regular10TextStyle(cBlackColor),
                      ),
                    );
                  case 4:
                    return Padding(
                      padding: const EdgeInsets.only(top: k8Padding),
                      child: Text(
                        '60+',
                        style: regular10TextStyle(cBlackColor),
                      ),
                    );
                  default:
                    return Container();
                }
              },
            ),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) {
            return const FlLine(
              color: cLineColor,
              strokeWidth: 1,
              dashArray: [5, 5],
            );
          },
        ),
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                toY: 30,
                color: cPrimaryColor,
                width: 16,
              ),
              BarChartRodData(
                toY: 10,
                color: cOrangeColor,
                width: 16,
              ),
            ],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                toY: 50,
                color: cPrimaryColor,
                width: 16,
              ),
              BarChartRodData(
                toY: 15,
                color: cOrangeGradientColor,
                width: 16,
              ),
            ],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [
              BarChartRodData(
                toY: 35,
                color: cPrimaryColor,
                width: 16,
              ),
              BarChartRodData(
                toY: 10,
                color: cOrangeColor,
                width: 16,
              ),
            ],
          ),
          BarChartGroupData(
            x: 3,
            barRods: [
              BarChartRodData(
                toY: 35,
                color: cPrimaryColor,
                width: 16,
              ),
              BarChartRodData(
                toY: 10,
                color: cOrangeColor,
                width: 16,
              ),
            ],
          ),
          BarChartGroupData(
            x: 4,
            barRods: [
              BarChartRodData(
                toY: 30,
                color: cPrimaryColor,
                width: 16,
              ),
              BarChartRodData(
                toY: 10,
                color: cOrangeColor,
                width: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
