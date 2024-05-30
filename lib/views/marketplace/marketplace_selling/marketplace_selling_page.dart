import 'package:bip_hip/utils/constants/imports.dart';

class MarketPlaceSellingPage extends StatelessWidget {
  const MarketPlaceSellingPage({super.key});

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
              title: ksSelling.tr,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kH16sizedBox,
                CustomElevatedButton(
                  prefixIcon: BipHip.selling,
                  label: ksCreateNewSellPost.tr,
                  onPressed: () {},
                  buttonHeight: h32,
                  buttonWidth: width - 40,
                  buttonColor: cPrimaryColor,
                ),
                kH20sizedBox,
                Text(
                  ksOverview.tr,
                  style: semiBold18TextStyle(cBlackColor),
                ),
                kH16sizedBox,
                Row(
                  children: [
                    SellingTopContainerWidget(
                      count: "10",
                      name: ksYourListing.tr,
                      icon: BipHip.report,
                      onPressed: () {
                        Get.toNamed(krMarketPlaceYourListingPage);
                      },
                    ),
                    kW16sizedBox,
                    SellingTopContainerWidget(
                      count: "10",
                      name: ksInbox.tr,
                      icon: BipHip.chatFill,
                      onPressed: () {},
                    ),
                  ],
                ),
                kH16sizedBox,
                Row(
                  children: [
                    SellingTopContainerWidget(
                      count: "10",
                      name: ksBidding.tr,
                      icon: BipHip.bidding,
                      onPressed: () {},
                    ),
                    kW16sizedBox,
                    SellingTopContainerWidget(
                      count: "10",
                      name: ksStore.tr,
                      icon: BipHip.shopFill,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SellingTopContainerWidget extends StatelessWidget {
  const SellingTopContainerWidget({super.key, required this.count, required this.name, required this.icon, this.onPressed});
  final String count, name;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: (width - 56) / 2,
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: cLineColor),
          borderRadius: BorderRadius.circular(k8BorderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: k12Padding, vertical: k12Padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    count,
                    style: semiBold24TextStyle(cBlackColor),
                  ),
                  Icon(
                    icon,
                    size: kIconSize20,
                    color: cBlackColor,
                  ),
                ],
              ),
              kH4sizedBox,
              Text(
                name,
                style: regular14TextStyle(cBlackColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
