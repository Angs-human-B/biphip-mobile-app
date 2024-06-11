import 'package:bip_hip/controllers/marketplace/marketplace_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/marketplace/marketplace_page.dart';
import 'package:bip_hip/views/marketplace/marketplace_view_listing_page.dart';

class MarketPlaceRecentActivity extends StatelessWidget {
  MarketPlaceRecentActivity({super.key});
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
              title: ksRecentActivity.tr,
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
                Text(
                  ksRecentActivity.tr,
                  style: semiBold18TextStyle(cBlackColor),
                ),
                kH16sizedBox,
                Expanded(
                  child: SingleChildScrollView(
                    child: SizedBox(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: marketPlaceController.marketplaceProductList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: isDeviceScreenLarge() ? 0.9 : 1,
                          crossAxisCount: 2,
                          crossAxisSpacing: k16Padding,
                          mainAxisSpacing: k16Padding,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          // return MarketplaceItemContainer(
                          //     productImage: marketPlaceController.marketplaceProductList[index]["productImage"],
                          //     price: marketPlaceController.marketplaceProductList[index]["price"],
                          //     location: marketPlaceController.marketplaceProductList[index]["location"],
                          //     details: marketPlaceController.marketplaceProductList[index]["details"]);
                          return InkWell(
                            onTap: () {
                              Get.to(
                                () => MarketPlaceViewListingPage(
                                    productImage: marketPlaceController.marketplaceProductList[index]["productImage"],
                                    price: marketPlaceController.marketplaceProductList[index]["price"],
                                    location: marketPlaceController.marketplaceProductList[index]["location"],
                                    details: marketPlaceController.marketplaceProductList[index]["details"],
                                    isBiddingPost: marketPlaceController.marketplaceProductList[index]["isBiddingPost"]),
                              );
                            },
                            child: MarketplaceItemContainer(
                                productImage: marketPlaceController.marketplaceProductList[index]["productImage"],
                                price: marketPlaceController.marketplaceProductList[index]["price"],
                                location: marketPlaceController.marketplaceProductList[index]["location"],
                                details: marketPlaceController.marketplaceProductList[index]["details"]),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
