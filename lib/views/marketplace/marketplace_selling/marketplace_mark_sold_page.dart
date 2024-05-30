import 'package:bip_hip/utils/constants/imports.dart';

class MarketPlaceMarkSoldPage extends StatelessWidget {
  const MarketPlaceMarkSoldPage({super.key});

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
              title: ksYourListing.tr,
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
                  "${ksDidYouSellThisItem.tr}?",
                  style: semiBold18TextStyle(cBlackColor),
                ),
                kH4sizedBox,
                Text(
                  ksYourResponseWontBeSharedWithAnyoneOnBipHip.tr,
                  style: regular14TextStyle(cSmallBodyTextColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
