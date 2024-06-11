import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/marketplace/marketplace_selling/marketplace_selling_page.dart';

class MarketPlaceBuyingPage extends StatelessWidget {
  const MarketPlaceBuyingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cWhiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kAppBarSize),
        //* info:: appBar
        child: CustomAppBar(
          title: ksBuying.tr,
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
            Text(
              ksOverview.tr,
              style: semiBold18TextStyle(cBlackColor),
            ),
            kH16sizedBox,
            Row(
              children: [
                SellingTopContainerWidget(
                  count: "10",
                  name: ksBidding.tr,
                  icon: BipHip.bidding,
                  onPressed: () {
                    Get.toNamed(krMarketPlaceBiddingPage);
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
          ],
        ),
      ),
    );
  }
}
