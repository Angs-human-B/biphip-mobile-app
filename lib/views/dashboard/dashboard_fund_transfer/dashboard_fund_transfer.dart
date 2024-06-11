import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class DashboardFundTransfer extends StatelessWidget {
  DashboardFundTransfer({super.key});
  final DashboardController dashboardController = Get.find<DashboardController>();
  final FriendController friendController = Get.find<FriendController>();

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
            child: Column(
              children: [
                kH16sizedBox,
                Row(
                  children: [
                    FundTransferTopContainer(
                      titleText: ksAvailableStars.tr,
                      icon: BipHip.giftNew,
                      amountText: "468",
                      buttonText: ksTransferStar,
                      buttonOnPressed: () async {
                        Get.toNamed(krDashboardSelectPeople);
                        await Get.find<FriendController>().getFriendList();
                      },
                    ),
                    kW8sizedBox,
                    FundTransferTopContainer(
                      titleText: ksAvailableAmount.tr,
                      amountText: "\$365",
                      buttonText: ksTransferBalance.tr,
                      buttonOnPressed: () async {
                        Get.toNamed(krDashboardSelectPeople);
                        await Get.find<FriendController>().getFriendList();
                      },
                    ),
                  ],
                ),
                kH20sizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ksFundTransferHistory.tr,
                      style: semiBold18TextStyle(cBlackColor),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(krDashboardFundTransferDetails);
                      },
                      child: Text(
                        ksSeeAll.tr,
                        style: regular16TextStyle(cPrimaryColor),
                      ),
                    ),
                  ],
                ),
                kH16sizedBox,
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
                                      // loadingBuilder: smallImageLoadingBuilder,
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
          ),
        ),
      ),
    );
  }
}

class FundTransferTopContainer extends StatelessWidget {
  const FundTransferTopContainer({super.key, required this.titleText, required this.amountText, required this.buttonText, this.icon, this.buttonOnPressed});
  final String titleText, amountText, buttonText;
  final IconData? icon;
  final VoidCallback? buttonOnPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (width - 48) / 2,
      height: 120,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              titleText,
              style: regular14TextStyle(cBlackColor),
            ),
            kH8sizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null)
                  const Icon(
                    BipHip.giftNew,
                    size: kIconSize20,
                    color: cAmberAccentColor,
                  ),
                if (icon != null) kW4sizedBox,
                Text(
                  amountText,
                  style: semiBold18TextStyle(cBlackColor),
                ),
              ],
            ),
            kH12sizedBox,
            CustomElevatedButton(
              label: buttonText,
              buttonWidth: (width - 48) / 3,
              buttonHeight: h32,
              onPressed: buttonOnPressed,
              buttonColor: cPrimaryColor,
              textStyle: regular14TextStyle(cWhiteColor),
            ),
          ],
        ),
      ),
    );
  }
}
