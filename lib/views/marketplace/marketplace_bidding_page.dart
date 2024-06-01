import 'dart:core';
import 'dart:math';

import 'package:bip_hip/controllers/marketplace/marketplace_controller.dart';
import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/widgets/common_post_widget.dart';
import 'package:bip_hip/views/marketplace/marketplace_view_listing_page.dart';

class MarketPlaceBiddingPage extends StatelessWidget {
  MarketPlaceBiddingPage({super.key});
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
              title: ksBidding.tr,
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
                  Text(
                    ksAllBidding.tr,
                    style: semiBold18TextStyle(cBlackColor),
                  ),
                  kH16sizedBox,
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => kH16sizedBox,
                      itemCount: marketPlaceController.marketplaceProductList.length,
                      itemBuilder: (context, index) {
                        return BiddingItemContent(
                            productImage: marketPlaceController.marketplaceProductList[index]["productImage"],
                            price: marketPlaceController.marketplaceProductList[index]["price"],
                            location: marketPlaceController.marketplaceProductList[index]["location"],
                            details: marketPlaceController.marketplaceProductList[index]["details"],
                            onPressed: () {
                              Get.find<GlobalController>().commonBottomSheet(
                                bottomSheetHeight: isDeviceScreenLarge() ? height * 0.4 : null,
                                context: context,
                                content: BidAmount(
                                  highestAmount: '350',
                                  totalBid: '56',
                                  desireAmount: '400',
                                  yourBid: Get.find<PostReactionController>().yourBid.value.toString(),
                                ),
                                onPressCloseButton: () {
                                  Get.back();
                                },
                                onPressRightButton: () {
                                  Get.back();
                                  Get.find<GlobalController>().commonBottomSheet(
                                    bottomSheetHeight: isDeviceScreenLarge() ? height * 0.3 : null,
                                    context: context,
                                    content: UpdateBidding(
                                      yourBid: marketPlaceController.yourBid.value.toString(),
                                    ),
                                    onPressCloseButton: () {
                                      Get.back();
                                    },
                                    onPressRightButton: () {
                                      Get.back();
                                    },
                                    rightText: ksUpdate.tr,
                                    rightTextStyle: medium14TextStyle(cPrimaryColor),
                                    title: ksUpdateBiddingAmount.tr,
                                    isRightButtonShow: true,
                                    isScrollControlled: true,
                                    isBottomSheetRightButtonActive: true.obs,
                                  );
                                },
                                rightText: ksEdit.tr,
                                rightTextStyle: medium14TextStyle(cPrimaryColor),
                                title: ksYourBidAmount.tr,
                                isRightButtonShow: true,
                                isScrollControlled: true,
                                isBottomSheetRightButtonActive: true.obs,
                              );
                            },
                            threeDotOnPressed: () {
                              Get.find<GlobalController>().blankBottomSheet(
                                context: context,
                                bottomSheetHeight: isDeviceScreenLarge() ? height * 0.15 : height * 0.25,
                                content: MoreBottomSheetContent(),
                              );
                            });
                      }),
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

class BiddingItemContent extends StatelessWidget {
  const BiddingItemContent({super.key, this.productImage, this.details, this.price, this.location, this.onPressed, this.threeDotOnPressed});
  final String? productImage, details, price, location;
  final VoidCallback? onPressed, threeDotOnPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width - 40,
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(k8BorderRadius),
        border: Border.all(width: 1, color: cLineColor),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: k12Padding, vertical: k12Padding),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(k4BorderRadius),
                  child: Image.network(
                    productImage ?? "",
                    width: 80,
                    height: h60,
                    fit: BoxFit.cover,
                    loadingBuilder: imageLoadingBuilder,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        BipHip.imageFile,
                        size: kIconSize60,
                        color: cIconColor,
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
                        details ?? ksNA.tr,
                        style: regular14TextStyle(cBlackColor),
                        overflow: TextOverflow.clip,
                      ),
                      kH4sizedBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            price ?? ksNA.tr,
                            style: regular12TextStyle(cBlackColor),
                          ),
                          kW8sizedBox,
                          const Icon(
                            BipHip.location,
                            size: kIconSize12,
                            color: cIconColor,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            location ?? ksNA.tr,
                            style: regular12TextStyle(cBlackColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Transform.rotate(
                    angle: pi / 2,
                    child: CustomIconButton(
                      onPress: threeDotOnPressed,
                      icon: BipHip.system,
                      size: kIconSize20,
                      iconColor: cBlackColor,
                    )),
              ],
            ),
            kH8sizedBox,
            CustomElevatedButton(
              label: ksSeeBidding.tr,
              onPressed: onPressed,
              buttonWidth: width - 66,
              buttonColor: cPrimaryColor,
              buttonHeight: h32,
            )
          ],
        ),
      ),
    );
  }
}
