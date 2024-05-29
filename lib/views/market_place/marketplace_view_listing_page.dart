import 'package:bip_hip/utils/constants/imports.dart';

class MarketPlaceViewListingPage extends StatelessWidget {
  const MarketPlaceViewListingPage({super.key});

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
              title: ksViewListing.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
        ),
      ),
    );
  }
}
