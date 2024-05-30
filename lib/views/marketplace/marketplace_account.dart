import 'package:bip_hip/controllers/marketplace/marketplace_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class MarketPlaceAccount extends StatelessWidget {
  MarketPlaceAccount({super.key});
  final MarketPlaceController marketPlaceController = Get.find<MarketPlaceController>();

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
              title: ksAccount.tr,
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
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                kH16sizedBox,
                Row(
                  children: [
                    AccountTopWidget(
                      icon: BipHip.chatFill,
                      title: ksInbox.tr,
                      messageCount: 3,
                      onPressed: () {},
                    ),
                    kW16sizedBox,
                    AccountTopWidget(
                      icon: BipHip.bidding,
                      title: ksBidding.tr,
                      onPressed: () {
                        Get.toNamed(krMarketPlaceBiddingPage);
                      },
                    ),
                  ],
                ),
                kH8sizedBox,
                AccountTopWidget(
                  icon: BipHip.circlePlus,
                  title: ksRecentActivity.tr,
                  onPressed: () {
                    Get.toNamed(krMarketPlaceRecentActivity);
                  },
                ),
                kH16sizedBox,
                Text(
                  ksSelling.tr,
                  style: semiBold18TextStyle(cBlackColor),
                ),
                kH16sizedBox,
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: marketPlaceController.sellingActionList.length,
                    separatorBuilder: (context, index) => kH8sizedBox,
                    itemBuilder: (context, index) {
                      return MarketPlaceAccountList(
                        icon: marketPlaceController.sellingActionList[index]["icon"],
                        title: marketPlaceController.sellingActionList[index]["title"],
                        onPressed: () {
                          ll(marketPlaceController.sellingActionList[index]["title"]);
                        },
                      );
                    }),
                kH16sizedBox,
                Text(
                  ksBuying.tr,
                  style: semiBold18TextStyle(cBlackColor),
                ),
                kH16sizedBox,
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: marketPlaceController.buyingActionList.length,
                    separatorBuilder: (context, index) => kH8sizedBox,
                    itemBuilder: (context, index) {
                      return MarketPlaceAccountList(
                        icon: marketPlaceController.buyingActionList[index]["icon"],
                        title: marketPlaceController.buyingActionList[index]["title"],
                        onPressed: () {
                          ll(marketPlaceController.buyingActionList[index]["title"]);
                        },
                      );
                    }),
                kH16sizedBox,
                Text(
                  ksMore.tr,
                  style: semiBold18TextStyle(cBlackColor),
                ),
                kH16sizedBox,
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: marketPlaceController.moreActionList.length,
                    separatorBuilder: (context, index) => kH8sizedBox,
                    itemBuilder: (context, index) {
                      return MarketPlaceAccountList(
                        icon: marketPlaceController.moreActionList[index]["icon"],
                        title: marketPlaceController.moreActionList[index]["title"],
                        onPressed: () {
                          // ll(marketPlaceController.moreActionList[index]["title"]);
                          if (index == 1) {
                            Get.toNamed(krMarketPlaceNotification);
                          }
                        },
                      );
                    }),
                kH16sizedBox,
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class AccountTopWidget extends StatelessWidget {
  const AccountTopWidget({super.key, required this.icon, required this.title, this.messageCount, this.onPressed});
  final IconData icon;
  final String? title;
  final int? messageCount;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: (width - 56) / 2,
        height: 80,
        decoration: BoxDecoration(border: Border.all(color: cLineColor), borderRadius: BorderRadius.circular(k8BorderRadius)),
        child: Padding(
          padding: const EdgeInsets.only(left: k12Padding, right: k12Padding, top: k16Padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: cBlackColor,
                size: kIconSize20,
              ),
              kH8sizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title ?? ksNA.tr,
                    style: regular14TextStyle(cBlackColor),
                  ),
                  if (messageCount != null)
                    Text(
                      messageCount.toString(),
                      style: regular14TextStyle(cBlackColor),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MarketPlaceAccountList extends StatelessWidget {
  const MarketPlaceAccountList({super.key, required this.icon, required this.title, required this.onPressed});
  final IconData icon;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width - 40,
        height: h40,
        decoration: BoxDecoration(
          color: cGreyBoxColor,
          borderRadius: BorderRadius.circular(k8BorderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: k12Padding, vertical: k12Padding),
          child: Row(
            children: [
              Icon(
                icon,
                size: kIconSize16,
                color: cBlackColor,
              ),
              kW12sizedBox,
              Text(
                title,
                style: regular14TextStyle(cBlackColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
