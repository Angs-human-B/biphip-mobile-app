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
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: cWhiteColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              appBarColor: cWhiteColor,
              title: ksOverview.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: Column(
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
                        onTap: () {},
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
                        onTap: () {},
                        child: Text(
                          ksSeeAll.tr,
                          style: regular16TextStyle(cPrimaryColor),
                        )),
                  ],
                ),
              ),
            ],
          ),
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
