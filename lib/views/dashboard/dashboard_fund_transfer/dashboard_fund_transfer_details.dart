import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/dashboard/dashboard_quiz.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';

class DashboardFundTransferDetails extends StatelessWidget {
  DashboardFundTransferDetails({super.key});
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
              title: ksFundTransfer.tr,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 50,
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) => kW8sizedBox,
                          itemCount: dashboardController.fundTransferFilterList.length,
                          itemBuilder: (context, index) {
                            return Obx(() => CustomChoiceChips(
                                  label: dashboardController.fundTransferFilterList[index],
                                  isSelected: (dashboardController.selectedFundTransferFilterIndex.value == index),
                                  onSelected: (value) async {
                                    dashboardController.selectedFundTransferFilterIndex.value = index;
                                    dashboardController.selectedFundTransferFilterValue.value = dashboardController.fundTransferFilterList[index];
                                  },
                                ));
                          },
                        ),
                      ),
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
                    ],
                  ),
                  if (dashboardController.selectedFundTransferFilterIndex.value == 0)
                    Column(
                      children: [
                        kH12sizedBox,
                        Table(
                          border: TableBorder.all(width: 0, color: cTransparentColor),
                          children: [
                            TableRow(
                              children: [
                                Text(ksDate.tr, style: semiBold14TextStyle(cBlackColor)),
                                Text(ksTransferOf.tr, style: semiBold14TextStyle(cBlackColor)),
                                Text(ksReceiver.tr, style: semiBold14TextStyle(cBlackColor)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(ksAmount.tr, style: semiBold14TextStyle(cBlackColor)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        kH16sizedBox,
                        ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: dashboardController.fundTransferHistoryList.length,
                            separatorBuilder: (context, index) => kH16sizedBox,
                            itemBuilder: (context, index) {
                              return Table(
                                border: TableBorder.all(width: 0, color: cTransparentColor),
                                children: [
                                  TableRow(
                                    children: [
                                      Text(dashboardController.fundTransferHistoryList[index]["date"], style: regular12TextStyle(cBlackColor)),
                                      Text(dashboardController.fundTransferHistoryList[index]["transferOf"], style: regular12TextStyle(cBlackColor)),
                                      Row(
                                        children: [
                                          ClipOval(
                                            child: Image.network(
                                              dashboardController.fundTransferHistoryList[index]["userImage"],
                                              width: h12,
                                              height: h12,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error, stackTrace) {
                                                return Image.asset(
                                                  kiProfileDefaultImageUrl,
                                                  width: h12,
                                                  height: h12,
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                            ),
                                          ),
                                          kW4sizedBox,
                                          Expanded(
                                            child: Text(
                                              dashboardController.fundTransferHistoryList[index]["userName"],
                                              style: regular12TextStyle(cBlackColor),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          if (dashboardController.fundTransferHistoryList[index]["icon"] != null)
                                            Icon(
                                              dashboardController.fundTransferHistoryList[index]["icon"],
                                              size: kIconSize12,
                                              color: cAmberAccentColor,
                                            ),
                                          if (dashboardController.fundTransferHistoryList[index]["icon"] != null)
                                            const SizedBox(
                                              width: 2,
                                            ),
                                          Padding(
                                            padding: const EdgeInsets.only(right: k8Padding),
                                            child: Text(dashboardController.fundTransferHistoryList[index]["amount"], style: regular12TextStyle(cBlackColor)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }),
                      ],
                    ),
                  if (dashboardController.selectedFundTransferFilterIndex.value == 1)
                    Column(
                      children: [
                        kH12sizedBox,
                        Table(
                          border: TableBorder.all(width: 0, color: cTransparentColor),
                          children: [
                            TableRow(
                              children: [
                                Text(ksDate.tr, style: semiBold14TextStyle(cBlackColor)),
                                Text(ksTransferOf.tr, style: semiBold14TextStyle(cBlackColor)),
                                Text(ksReceiver.tr, style: semiBold14TextStyle(cBlackColor)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(ksAmount.tr, style: semiBold14TextStyle(cBlackColor)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        kH16sizedBox,
                        ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: dashboardController.fundTransferAmountHistoryList.length,
                            separatorBuilder: (context, index) => kH16sizedBox,
                            itemBuilder: (context, index) {
                              return Table(
                                border: TableBorder.all(width: 0, color: cTransparentColor),
                                children: [
                                  TableRow(
                                    children: [
                                      Text(dashboardController.fundTransferAmountHistoryList[index]["date"], style: regular12TextStyle(cBlackColor)),
                                      Text(dashboardController.fundTransferAmountHistoryList[index]["transferOf"], style: regular12TextStyle(cBlackColor)),
                                      Row(
                                        children: [
                                          ClipOval(
                                            child: Image.network(
                                              dashboardController.fundTransferAmountHistoryList[index]["userImage"],
                                              width: h12,
                                              height: h12,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error, stackTrace) {
                                                return Image.asset(
                                                  kiProfileDefaultImageUrl,
                                                  width: h12,
                                                  height: h12,
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                            ),
                                          ),
                                          kW4sizedBox,
                                          Expanded(
                                            child: Text(
                                              dashboardController.fundTransferAmountHistoryList[index]["userName"],
                                              style: regular12TextStyle(cBlackColor),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right: k8Padding),
                                            child: Text(dashboardController.fundTransferAmountHistoryList[index]["amount"],
                                                style: regular12TextStyle(cBlackColor)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }),
                      ],
                    ),
                  if (dashboardController.selectedFundTransferFilterIndex.value == 2)
                    Column(
                      children: [
                        kH12sizedBox,
                        Table(
                          border: TableBorder.all(width: 0, color: cTransparentColor),
                          children: [
                            TableRow(
                              children: [
                                Text(ksDate.tr, style: semiBold14TextStyle(cBlackColor)),
                                Text(ksTransferOf.tr, style: semiBold14TextStyle(cBlackColor)),
                                Text(ksReceiver.tr, style: semiBold14TextStyle(cBlackColor)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(ksAmount.tr, style: semiBold14TextStyle(cBlackColor)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        kH16sizedBox,
                        ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: dashboardController.fundTransferStarHistoryList.length,
                            separatorBuilder: (context, index) => kH16sizedBox,
                            itemBuilder: (context, index) {
                              return Table(
                                border: TableBorder.all(width: 0, color: cTransparentColor),
                                children: [
                                  TableRow(
                                    children: [
                                      Text(dashboardController.fundTransferStarHistoryList[index]["date"], style: regular12TextStyle(cBlackColor)),
                                      Text(dashboardController.fundTransferStarHistoryList[index]["transferOf"], style: regular12TextStyle(cBlackColor)),
                                      Row(
                                        children: [
                                          ClipOval(
                                            child: Image.network(
                                              dashboardController.fundTransferStarHistoryList[index]["userImage"],
                                              width: h12,
                                              height: h12,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error, stackTrace) {
                                                return Image.asset(
                                                  kiProfileDefaultImageUrl,
                                                  width: h12,
                                                  height: h12,
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                            ),
                                          ),
                                          kW4sizedBox,
                                          Expanded(
                                            child: Text(
                                              dashboardController.fundTransferStarHistoryList[index]["userName"],
                                              style: regular12TextStyle(cBlackColor),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            dashboardController.fundTransferStarHistoryList[index]["icon"],
                                            size: kIconSize12,
                                            color: cAmberAccentColor,
                                          ),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right: k8Padding),
                                            child:
                                                Text(dashboardController.fundTransferStarHistoryList[index]["amount"], style: regular12TextStyle(cBlackColor)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }),
                      ],
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