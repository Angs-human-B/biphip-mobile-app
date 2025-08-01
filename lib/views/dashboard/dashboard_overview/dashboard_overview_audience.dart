import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/dashboard/dashboard_overview/dashboard_overview.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardOverviewAudience extends StatelessWidget {
  DashboardOverviewAudience({super.key});
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
                  SizedBox(
                      width: 100,
                      height: 100,
                      child: AgeGenderPieChart(
                        men: double.parse(dashboardController.dashboardOverviewData.value!.audience!.men.toString()),
                        women: double.parse(dashboardController.dashboardOverviewData.value!.audience!.women.toString()),
                      )),
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
                        "${dashboardController.dashboardOverviewData.value?.audience?.men.toString()}%Men",
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
                        "${dashboardController.dashboardOverviewData.value?.audience?.women.toString()}%Women",
                        style: regular12TextStyle(cBlackColor),
                      ),
                    ],
                  ),
                  kH40sizedBox,
                  //* barchart
                  SizedBox(width: width - 40, height: 200, child: AgeGenderBarChart()),
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
                      child: const DashboardTopCountriesChart()),
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
  const AgeGenderPieChart({super.key, required this.men, required this.women});
  final double men, women;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PieChart(
          PieChartData(
            sections: [
              PieChartSectionData(value: men, color: cPrimaryColor, radius: 15, showTitle: false),
              PieChartSectionData(
                value: women,
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
  AgeGenderBarChart({
    super.key,
  });
  final audience = Get.find<DashboardController>().dashboardOverviewData.value!.audience;
  List<BarChartGroupData> _generateBarGroups() {
    final ageGroups = audience!.ageGroup!.entries.toList();

    return ageGroups.asMap().entries.map((entry) {
      int index = entry.key;
      // String ageGroup = entry.value.key;

      int menCount = entry.value.value.men ?? 0;
      int womenCount = entry.value.value.women ?? 0;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: menCount.toDouble(),
            color: cPrimaryColor,
            width: 16,
          ),
          BarChartRodData(
            toY: womenCount.toDouble(),
            color: cOrangeColor,
            width: 16,
          ),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 100,
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
                int index = value.toInt();
                if (index < audience!.ageGroup!.length) {
                  final ageGroupKeys = audience!.ageGroup!.keys.toList();
                  String label = ageGroupKeys[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: k8Padding),
                    child: Text(
                      label,
                      style: regular10TextStyle(cBlackColor),
                    ),
                  );
                } else {
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
        barGroups: _generateBarGroups(),
      ),
    );
  }
}
