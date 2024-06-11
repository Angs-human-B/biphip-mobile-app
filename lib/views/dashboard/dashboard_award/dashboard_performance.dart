import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/dashboard/dashboard_award/dashboard_award.dart';

class DashboardPerformance extends StatelessWidget {
  DashboardPerformance({super.key});
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
              title: ksPerformance.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Column(
              children: [
                kH16sizedBox,
                InkWell(
                  onTap: () {
                    Get.find<GlobalController>().blankBottomSheet(
                      context: context,
                      bottomSheetHeight: height * 0.5,
                      content: QuizTimeFilterBottomSheetContent(),
                    );
                  },
                  child: Row(
                    children: [
                      Container(
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
                    ],
                  ),
                ),
                kH20sizedBox,
                const LineChartWidget(
                  titleText: "Win",
                  filterDateTimeText: "From this month",
                  totalValue: "5",
                  percentText: "+2%",
                  progressColor: cGreenColor,
                  progressBottomColor: cGreenTintColor,
                  percentTextColor: cGreenColor,
                ),
                kH16sizedBox,
                const LineChartWidget(
                  titleText: "Winning Ratio",
                  filterDateTimeText: "From this month",
                  totalValue: "2",
                  percentText: "-16%",
                  progressColor: cPrimaryColor,
                  progressBottomColor: cPrimaryTint2Color,
                  percentTextColor: cRedColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
