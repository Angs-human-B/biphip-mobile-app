import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_tapable_container.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardDonation extends StatelessWidget {
  DashboardDonation({super.key});
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
              title: ksDonation.tr,
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
                children: [
                  TapAbleButtonContainer(
                    buttonText: dashboardController.donationTapButtonText,
                    buttonState: dashboardController.donationTapButtonState,
                    buttonPress: RxList([
                      () {
                        unFocus(context);
                        dashboardController.dashboardIDonatedTapableButtonOnPressed();
                      },
                      () {
                        unFocus(context);
                        dashboardController.dashboardMyDonationTapableButtonOnPressed();
                      },
                    ]),
                  ),
                  kH16sizedBox,
                  if (dashboardController.donationTapButtonState[0] && dashboardController.dashboardDonationPost.isEmpty)
                    Container(
                        width: width - 40,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: cLineColor2),
                          borderRadius: BorderRadius.circular(k8BorderRadius),
                        ),
                        child: EmptyView(title: ksYouHaveNothingInDonation.tr)),
                  if (dashboardController.donationTapButtonState[0] && dashboardController.dashboardDonationPost.isNotEmpty)
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            DonationStatics(
                              topTitleText: ksDonationStatics.tr,
                              topSubtitleText: "The statics of how much you have donated",
                            ),
                            kH16sizedBox,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ksDonationPosts.tr,
                                  style: semiBold18TextStyle(cBlackColor),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(krDashboardDonatedPost);
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
                              itemCount: dashboardController.dashboardDonationPost.length > 3 ? 3 : dashboardController.dashboardDonationPost.length,
                              separatorBuilder: (context, index) => kH16sizedBox,
                              itemBuilder: (context, index) {
                                return DashboardDonationContent(
                                  width: width - 40,
                                  height: 146,
                                  productImage: dashboardController.dashboardDonationPost[index]["productImage"],
                                  productTitle: dashboardController.dashboardDonationPost[index]["productTitle"],
                                  postDate: dashboardController.dashboardDonationPost[index]["postDate"],
                                  postCount: dashboardController.dashboardDonationPost[index]["postCount"],
                                  engagementCount: dashboardController.dashboardDonationPost[index]["engagementCount"],
                                  giftCount: dashboardController.dashboardDonationPost[index]["giftCount"],
                                  donateAmount: dashboardController.dashboardDonationPost[index]["amount"],
                                  donateText: ksDonate.tr,
                                );
                              },
                            ),
                            kH16sizedBox,
                          ],
                        ),
                      ),
                    ),
                  if (dashboardController.donationTapButtonState[1] && dashboardController.dashboardDonationPost.isEmpty)
                    Container(
                        width: width - 40,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: cLineColor2),
                          borderRadius: BorderRadius.circular(k8BorderRadius),
                        ),
                        child: EmptyView(title: ksYouHaveNothingIAApplication.tr)),
                  if (dashboardController.donationTapButtonState[1] && dashboardController.dashboardDonationPost.isNotEmpty)
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            DonationStatics(
                              topTitleText: ksDonationStatics.tr,
                              topSubtitleText: "The statics of how much you have application",
                            ),
                            kH16sizedBox,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ksDonationPosts.tr,
                                  style: semiBold18TextStyle(cBlackColor),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(krDashboardDonatedPost);
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
                              itemCount: dashboardController.dashboardDonationPost.length > 3 ? 3 : dashboardController.dashboardDonationPost.length,
                              separatorBuilder: (context, index) => kH16sizedBox,
                              itemBuilder: (context, index) {
                                return DashboardDonationContent(
                                  width: width - 40,
                                  height: 146,
                                  productImage: dashboardController.dashboardDonationPost[index]["productImage"],
                                  productTitle: dashboardController.dashboardDonationPost[index]["productTitle"],
                                  postDate: dashboardController.dashboardDonationPost[index]["postDate"],
                                  postCount: dashboardController.dashboardDonationPost[index]["postCount"],
                                  engagementCount: dashboardController.dashboardDonationPost[index]["engagementCount"],
                                  giftCount: dashboardController.dashboardDonationPost[index]["giftCount"],
                                  donateAmount: dashboardController.dashboardDonationPost[index]["amount"],
                                  donateText: ksDonate.tr,
                                );
                              },
                            ),
                            kH16sizedBox,
                          ],
                        ),
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

class DashboardDonationContent extends StatelessWidget {
  const DashboardDonationContent(
      {super.key,
      this.width,
      this.height,
      this.productImage,
      this.productTitle,
      this.postDate,
      this.postCount,
      this.engagementCount,
      this.giftCount,
      this.donateText,
      this.donateAmount});
  final double? width, height;
  final String? productImage, productTitle, postDate, postCount, engagementCount, giftCount, donateText, donateAmount;

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
            offset: Offset(0, 1),
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
                Column(
                  children: [
                    Text(
                      donateAmount ?? "0",
                      style: semiBold16TextStyle(cBlackColor),
                    ),
                    kH4sizedBox,
                    Text(
                      donateText ?? ksDonation.tr,
                      style: regular12TextStyle(cBlackColor),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DonationStatics extends StatelessWidget {
  const DonationStatics({super.key, required this.topTitleText, required this.topSubtitleText});
  final String topTitleText, topSubtitleText;

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
                  topTitleText,
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
              topSubtitleText,
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
          color: cPrimaryTint1Color,
          width: 16,
          borderRadius: BorderRadius.circular(k20BorderRadius),
        ),
      ],
    );
  }
}
