import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/dashboard/dashboard_star/dashboard_star.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';

class DashboardStarHistory extends StatelessWidget {
  DashboardStarHistory({super.key});
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
              title: ksHistory.tr,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kH16sizedBox,
                  Container(
                    color: cWhiteColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width,
                          height: 50,
                          child: ListView.separated(
                            itemCount: dashboardController.dashboardStarHistoryList.length,
                            shrinkWrap: true,
                            separatorBuilder: (context, index) => kW4sizedBox,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, index) {
                              return Obx(() => CustomChoiceChips(
                                    label: dashboardController.dashboardStarHistoryList[index],
                                    isSelected: (dashboardController.selectedDashboardStarHistoryIndex.value == index),
                                    onSelected: (value) async {
                                      dashboardController.selectedDashboardStarHistoryIndex.value = index;
                                    },
                                  ));
                            },
                          ),
                        ),
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
                                    Text(
                                      dashboardController.selectedQuizTimeRangeValue.value,
                                      style: regular12TextStyle(cBlackColor),
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
                        if (dashboardController.selectedDashboardStarHistoryIndex.value == 0)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ksStarPurchaseHistory.tr,
                                style: semiBold18TextStyle(cBlackColor),
                              ),
                              kH16sizedBox,
                              // Row(
                              //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //       ksDate.tr,
                              //       style: semiBold14TextStyle(cBlackColor),
                              //     ),
                              //     const SizedBox(
                              //       width: 100,
                              //     ),
                              //     Text(
                              //       ksPackage.tr,
                              //       style: semiBold14TextStyle(cBlackColor),
                              //     ),
                              //     const SizedBox(
                              //       width: 48,
                              //     ),
                              //     Text(
                              //       ksStarAmount.tr,
                              //       style: semiBold14TextStyle(cBlackColor),
                              //     ),
                              //     kW8sizedBox,
                              //     Text(
                              //       ksPrice.tr,
                              //       style: semiBold14TextStyle(cBlackColor),
                              //     ),
                              //   ],
                              // ),

                              Table(
                                border: TableBorder.all(width: 0, color: cTransparentColor),
                                columnWidths: const {
                                  0: FlexColumnWidth(2.5),
                                  1: FlexColumnWidth(2.5),
                                  2: FlexColumnWidth(2.5),
                                  3: FlexColumnWidth(1),
                                },
                                children: [
                                  TableRow(
                                    children: [
                                      Text(ksDate.tr, style: semiBold14TextStyle(cBlackColor)),
                                      Text(ksPackage.tr, style: semiBold14TextStyle(cBlackColor)),
                                      Text(ksStarAmount.tr, style: semiBold14TextStyle(cBlackColor)),
                                      Text(ksPrice.tr, style: semiBold14TextStyle(cBlackColor)),
                                    ],
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
                                  return Table(
                                    border: TableBorder.all(width: 0, color: cTransparentColor),
                                    columnWidths: const {
                                      0: FlexColumnWidth(2.5),
                                      1: FlexColumnWidth(2.5),
                                      2: FlexColumnWidth(2.5),
                                      3: FlexColumnWidth(1),
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          Text(dashboardController.starPurchaseHistoryList[index]["date"], style: regular12TextStyle(cBlackColor)),
                                          Row(
                                            children: [
                                              Icon(
                                                dashboardController.starPurchaseHistoryList[index]["packageIcon"],
                                                size: kIconSize12,
                                                color: cAmberColor,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  dashboardController.starPurchaseHistoryList[index]["packageName"],
                                                  style: regular12TextStyle(cBlackColor),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            dashboardController.starPurchaseHistoryList[index]["starAmount"].toString(),
                                            style: regular12TextStyle(cBlackColor),
                                          ),
                                          Text(
                                            dashboardController.starPurchaseHistoryList[index]["price"].toString(),
                                            style: regular12TextStyle(cBlackColor),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        if (dashboardController.selectedDashboardStarHistoryIndex.value == 1)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ksStarGiftHistory.tr,
                                style: semiBold18TextStyle(cBlackColor),
                              ),
                              kH16sizedBox,
                              Table(
                                border: TableBorder.all(width: 0, color: cTransparentColor),
                                columnWidths: const {
                                  0: FlexColumnWidth(2.5),
                                  1: FlexColumnWidth(2.5),
                                  2: FlexColumnWidth(2),
                                  3: FlexColumnWidth(1.5),
                                  4: FlexColumnWidth(1),
                                },
                                children: [
                                  TableRow(
                                    children: [
                                      Text(ksDate.tr, style: semiBold14TextStyle(cBlackColor)),
                                      Text(ksPackage.tr, style: semiBold14TextStyle(cBlackColor)),
                                      Text(ksGift.tr, style: semiBold14TextStyle(cBlackColor)),
                                      Text(ksPrice.tr, style: semiBold14TextStyle(cBlackColor)),
                                      Text(ksPost.tr, style: semiBold14TextStyle(cBlackColor)),
                                    ],
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
                                  return Table(
                                    border: TableBorder.all(width: 0, color: cTransparentColor),
                                    columnWidths: const {
                                      0: FlexColumnWidth(2.5),
                                      1: FlexColumnWidth(2.5),
                                      2: FlexColumnWidth(2),
                                      3: FlexColumnWidth(1.5),
                                      4: FlexColumnWidth(1),
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          Text(dashboardController.starGiftHistoryList[index]["date"], style: regular12TextStyle(cBlackColor)),
                                          Row(
                                            children: [
                                              Icon(
                                                dashboardController.starGiftHistoryList[index]["packageIcon"],
                                                size: kIconSize12,
                                                color: cAmberColor,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  dashboardController.starGiftHistoryList[index]["packageName"],
                                                  style: regular12TextStyle(cBlackColor),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            dashboardController.starGiftHistoryList[index]["starAmount"].toString(),
                                            style: regular12TextStyle(cBlackColor),
                                          ),
                                          Text(
                                            dashboardController.starGiftHistoryList[index]["price"].toString(),
                                            style: regular12TextStyle(cBlackColor),
                                          ),
                                          Text(
                                            ksView.tr,
                                            style: regular12TextStyle(cPrimaryColor),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
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
    );
  }
}

class StarPurchaseAndGiftDetailsContent extends StatelessWidget {
  const StarPurchaseAndGiftDetailsContent(
      {super.key,
      required this.date,
      required this.packageName,
      required this.packageAmount,
      required this.price,
      required this.packageIcon,
      required this.view});
  final String date, packageName, packageAmount, price, view;
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
        Text(
          view,
          style: regular12TextStyle(cPrimaryColor),
        ),
      ],
    );
  }
}
