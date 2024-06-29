import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/dashboard/dashboard_overview/dashboard_overview.dart';
import 'package:bip_hip/views/dashboard/dashboard_star/dashboard_star.dart';
import 'package:intl/intl.dart';

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
                        titleText: ksMyGiftBalance.tr,
                        totalValue: dashboardController.dashboardGiftInsightData.value!.myGiftBalance.toString(),
                        filterText: dashboardController.selectedQuizTimeRangeValue.value,
                        percentTextColor: cGreenColor,
                      ),
                      kW8sizedBox,
                      DashboardCommonContainer(
                        width: (width - 48) / 2,
                        titleText: ksGrowthStatics.tr,
                        totalValue: dashboardController.dashboardGiftInsightData.value!.growthStatics!.amount.toString(),
                        percentValue: dashboardController.dashboardGiftInsightData.value!.growthStatics!.incdec.toString(),
                        filterText: dashboardController.selectedQuizTimeRangeValue.value,
                        percentTextColor: cGreenColor,
                      ),
                    ],
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
                            ),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(k12Padding),
                        child: StarGiftReport(
                          title: ksGiftEarningReport.tr,
                          apiData: dashboardController.dashboardGiftInsightData.value!.giftEarningReport!,
                        ),
                      )),
                  kH20sizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ksGiftEarnedPost,
                        style: semiBold18TextStyle(cBlackColor),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(krDashboardGiftEarned);
                        },
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
                    itemCount: dashboardController.dashboardGiftEarnedPostList.length > 2 ? 2 : dashboardController.dashboardGiftEarnedPostList.length,
                    separatorBuilder: (context, index) => kH16sizedBox,
                    itemBuilder: (context, index) {
                      return DashboardGiftContentContainer(
                        width: width - 40,
                        // productImage: dashboardController.dashboardGiftEarnedPostList[index].,
                        productTitle: dashboardController.dashboardGiftEarnedPostList[index].content,
                        postDate: DateFormat("dMMM, yyyy").format(dashboardController.dashboardGiftEarnedPostList[index].dateTime!),
                        postCount: dashboardController.dashboardGiftEarnedPostList[index].countComment.toString(), //!post count data not available from api
                        engagementCount: dashboardController.dashboardGiftEarnedPostList[index].engagements.toString(),
                        giftCount: dashboardController.dashboardGiftEarnedPostList[index].countStar.toString(), //!Gift data needed
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
                if (productImage != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(k4BorderRadius),
                    child: Image.network(
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
                  ),
                kW12sizedBox,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productTitle ?? "",
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
