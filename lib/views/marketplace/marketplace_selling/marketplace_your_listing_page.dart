import 'dart:math';

import 'package:bip_hip/controllers/marketplace/marketplace_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/marketplace/marketplace_view_listing_page.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';

class MarketPlaceYourListingPage extends StatelessWidget {
  MarketPlaceYourListingPage({super.key});
  final MarketPlaceController marketPlaceController = Get.find<MarketPlaceController>();
  final GlobalController globalController = Get.find<GlobalController>();

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
              action: [
                Padding(
                  padding: const EdgeInsets.only(right: k20Padding, top: 10, bottom: 10),
                  child: ClipOval(
                    child: Image.network(
                      Get.find<GlobalController>().userImage.value ?? "",
                      width: h24,
                      height: h24,
                      fit: BoxFit.cover,
                      loadingBuilder: smallImageLoadingBuilder,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          kiProfileDefaultImageUrl,
                          width: h24,
                          height: h24,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kH16sizedBox,
                    SizedBox(
                      width: width,
                      height: 50,
                      child: ListView.builder(
                        itemCount: marketPlaceController.yourListingFilterList.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(0),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: k4Padding),
                            child: Obx(() => CustomChoiceChips(
                                  label: marketPlaceController.yourListingFilterList[index],
                                  isSelected: (marketPlaceController.selectedListingFilterIndex.value == index),
                                  onSelected: (value) async {
                                    marketPlaceController.selectedListingFilterIndex.value = index;
                                    marketPlaceController.selectedListingFilterValue.value = marketPlaceController.yourListingFilterList[index];
                                  },
                                )),
                          );
                        },
                      ),
                    ),
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
                    if (marketPlaceController.selectedListingFilterIndex.value == 0)
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ksAllListing.tr,
                                style: semiBold18TextStyle(cBlackColor),
                              ),
                              kH16sizedBox,
                              ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context, index) => kH16sizedBox,
                                  itemCount: marketPlaceController.allProductList.length,
                                  itemBuilder: (context, index) {
                                    return YourListingItemContent(
                                        productImage: marketPlaceController.allProductList[index]["productImage"],
                                        price: marketPlaceController.allProductList[index]["price"],
                                        status: marketPlaceController.allProductList[index]["status"],
                                        details: marketPlaceController.allProductList[index]["details"],
                                        firstButtonText: marketPlaceController.allProductList[index]["status"].toString().toLowerCase() == "active listing"
                                            ? ksMarkAsSold.tr
                                            : ksMarkAsAvailable.tr,
                                        secondButtonText: ksShare,
                                        secondButtonTextStyle: marketPlaceController.allProductList[index]["status"].toString().toLowerCase() == "sold"
                                            ? regular14TextStyle(cPlaceHolderColor)
                                            : regular14TextStyle(cBlackColor),
                                        onPressed: () {},
                                        firstButtonOnPressed: () {
                                          if (marketPlaceController.allProductList[index]["status"].toString().toLowerCase() == "active listing") {
                                            marketPlaceController.resetMarketPlaceData();
                                            Get.toNamed(krMarketPlaceMarkSoldPage);
                                          }
                                        },
                                        secondButtonOnPressed: marketPlaceController.allProductList[index]["status"].toString().toLowerCase() == "sold"
                                            ? null
                                            : () {
                                                globalController.blankBottomSheet(
                                                    context: context,
                                                    bottomSheetHeight: isDeviceScreenLarge() ? height * 0.25 : height * 0.35,
                                                    content: const ShareBottomSheetContent());
                                              },
                                        threeDotOnPressed: () {
                                          Get.find<GlobalController>().blankBottomSheet(
                                            context: context,
                                            bottomSheetHeight: marketPlaceController.allProductList[index]["isSelfPost"]
                                                ? isDeviceScreenLarge()
                                                    ? height * 0.3
                                                    : height * 0.4
                                                : isDeviceScreenLarge()
                                                    ? height * 0.15
                                                    : height * 0.25,
                                            content: marketPlaceController.allProductList[index]["isSelfPost"]
                                                ? SelfPostBottomSheetContent(
                                                    viewListingOnPressed: () {
                                                      Get.back();
                                                      Get.to(
                                                        () => MarketPlaceViewListingPage(
                                                          productImage: marketPlaceController.allProductList[index]["productImage"],
                                                          price: marketPlaceController.allProductList[index]["price"],
                                                          location: marketPlaceController.allProductList[index]["location"],
                                                          details: marketPlaceController.allProductList[index]["details"],
                                                          isBiddingPost: marketPlaceController.allProductList[index]["isBiddingPost"],
                                                          isSelfPost: marketPlaceController.allProductList[index]["isSelfPost"],
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : MoreBottomSheetContent(),
                                          );
                                        });
                                  }),
                            ],
                          ),
                        ),
                      ),
                    if (marketPlaceController.selectedListingFilterIndex.value == 1)
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ksAllListing.tr,
                                style: semiBold18TextStyle(cBlackColor),
                              ),
                              kH16sizedBox,
                              ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context, index) => kH16sizedBox,
                                  itemCount: marketPlaceController.activeProductList.length,
                                  itemBuilder: (context, index) {
                                    return YourListingItemContent(
                                        productImage: marketPlaceController.activeProductList[index]["productImage"],
                                        price: marketPlaceController.activeProductList[index]["price"],
                                        status: marketPlaceController.activeProductList[index]["status"],
                                        details: marketPlaceController.activeProductList[index]["details"],
                                        firstButtonText: ksMarkAsAvailable.tr,
                                        secondButtonText: ksShare,
                                        onPressed: () {},
                                        firstButtonOnPressed: () {
                                          if (marketPlaceController.allProductList[index]["status"].toString().toLowerCase() == "active listing") {
                                            Get.toNamed(krMarketPlaceMarkSoldPage);
                                          }
                                        },
                                        secondButtonOnPressed: () {
                                          globalController.blankBottomSheet(
                                              context: context,
                                              bottomSheetHeight: isDeviceScreenLarge() ? height * 0.25 : height * 0.35,
                                              content: const ShareBottomSheetContent());
                                        },
                                        threeDotOnPressed: () {
                                          Get.find<GlobalController>().blankBottomSheet(
                                            context: context,
                                            bottomSheetHeight: marketPlaceController.activeProductList[index]["isSelfPost"]
                                                ? isDeviceScreenLarge()
                                                    ? height * 0.3
                                                    : height * 0.4
                                                : isDeviceScreenLarge()
                                                    ? height * 0.15
                                                    : height * 0.25,
                                            content: marketPlaceController.activeProductList[index]["isSelfPost"]
                                                ? SelfPostBottomSheetContent(
                                                    viewListingOnPressed: () {
                                                      Get.back();
                                                      Get.to(
                                                        () => MarketPlaceViewListingPage(
                                                          productImage: marketPlaceController.activeProductList[index]["productImage"],
                                                          price: marketPlaceController.activeProductList[index]["price"],
                                                          location: marketPlaceController.activeProductList[index]["location"],
                                                          details: marketPlaceController.activeProductList[index]["details"],
                                                          isBiddingPost: marketPlaceController.activeProductList[index]["isBiddingPost"],
                                                          isSelfPost: marketPlaceController.activeProductList[index]["isSelfPost"],
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : MoreBottomSheetContent(),
                                          );
                                        });
                                  }),
                            ],
                          ),
                        ),
                      ),
                    if (marketPlaceController.selectedListingFilterIndex.value == 2)
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ksAllListing.tr,
                                style: semiBold18TextStyle(cBlackColor),
                              ),
                              kH16sizedBox,
                              ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context, index) => kH16sizedBox,
                                  itemCount: marketPlaceController.soldProductList.length,
                                  itemBuilder: (context, index) {
                                    return YourListingItemContent(
                                        productImage: marketPlaceController.soldProductList[index]["productImage"],
                                        price: marketPlaceController.soldProductList[index]["price"],
                                        status: marketPlaceController.soldProductList[index]["status"],
                                        details: marketPlaceController.soldProductList[index]["details"],
                                        firstButtonText: marketPlaceController.soldProductList[index]["status"].toString().toLowerCase() == "active listing"
                                            ? ksMarkAsSold.tr
                                            : ksMarkAsAvailable.tr,
                                        secondButtonText: ksShare,
                                        secondButtonTextStyle: regular14TextStyle(cPlaceHolderColor),
                                        onPressed: () {},
                                        firstButtonOnPressed: () {
                                          if (marketPlaceController.allProductList[index]["status"].toString().toLowerCase() == "active listing") {
                                            marketPlaceController.resetMarketPlaceData();
                                            Get.toNamed(krMarketPlaceMarkSoldPage);
                                          }
                                        },
                                        secondButtonOnPressed: null,
                                        threeDotOnPressed: () {
                                          Get.find<GlobalController>().blankBottomSheet(
                                            context: context,
                                            bottomSheetHeight: marketPlaceController.soldProductList[index]["isSelfPost"]
                                                ? isDeviceScreenLarge()
                                                    ? height * 0.3
                                                    : height * 0.4
                                                : isDeviceScreenLarge()
                                                    ? height * 0.15
                                                    : height * 0.25,
                                            content: marketPlaceController.soldProductList[index]["isSelfPost"]
                                                ? SelfPostBottomSheetContent(
                                                    viewListingOnPressed: () {
                                                      Get.back();
                                                      Get.to(
                                                        () => MarketPlaceViewListingPage(
                                                          productImage: marketPlaceController.soldProductList[index]["productImage"],
                                                          price: marketPlaceController.soldProductList[index]["price"],
                                                          location: marketPlaceController.soldProductList[index]["location"],
                                                          details: marketPlaceController.soldProductList[index]["details"],
                                                          isBiddingPost: marketPlaceController.soldProductList[index]["isBiddingPost"],
                                                          isSelfPost: marketPlaceController.soldProductList[index]["isSelfPost"],
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : MoreBottomSheetContent(),
                                          );
                                        });
                                  }),
                            ],
                          ),
                        ),
                      ),
                    kH16sizedBox,
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

class YourListingItemContent extends StatelessWidget {
  const YourListingItemContent(
      {super.key,
      this.productImage,
      this.details,
      this.price,
      this.status,
      this.onPressed,
      this.threeDotOnPressed,
      this.firstButtonText,
      this.secondButtonText,
      this.firstButtonOnPressed,
      this.secondButtonOnPressed,
      this.secondButtonTextStyle});
  final String? productImage, details, price, status, firstButtonText, secondButtonText;
  final VoidCallback? onPressed, threeDotOnPressed, firstButtonOnPressed, secondButtonOnPressed;
  final TextStyle? secondButtonTextStyle;

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
                  borderRadius: BorderRadius.circular(k8BorderRadius),
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
                          kW4sizedBox,
                          Container(
                            width: 2,
                            height: 2,
                            decoration: const BoxDecoration(shape: BoxShape.circle, color: cBlackColor),
                          ),
                          kW4sizedBox,
                          Text(
                            status ?? ksNA.tr,
                            style: status == "sold" ? regular12TextStyle(cRedColor) : regular12TextStyle(cPrimaryColor),
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
            Row(
              children: [
                CustomElevatedButton(
                  label: firstButtonText ?? "",
                  onPressed: firstButtonOnPressed,
                  buttonWidth: (width - 78) / 2,
                  buttonHeight: h32,
                  buttonColor: cPrimaryTint2Color,
                  textStyle: regular14TextStyle(cPrimaryColor),
                ),
                kW12sizedBox,
                CustomElevatedButton(
                  label: secondButtonText ?? "",
                  onPressed: secondButtonOnPressed,
                  buttonWidth: (width - 78) / 2,
                  buttonHeight: h32,
                  buttonColor: cNeutralColor,
                  disableColor: cNeutralColor,
                  textStyle: secondButtonTextStyle ?? regular14TextStyle(cBlackColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ShareBottomSheetContent extends StatelessWidget {
  const ShareBottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomListTile(
          leading: const CircularContainer(icon: BipHip.world),
          title: ksShareToFeed.tr,
        ),
        CustomListTile(
          leading: const CircularContainer(icon: BipHip.chatFill),
          title: ksSendInMessenger.tr,
        ),
        CustomListTile(
          leading: const CircularContainer(icon: BipHip.copy),
          title: ksCopyLink.tr,
        ),
      ],
    );
  }
}

class SelfPostBottomSheetContent extends StatelessWidget {
  const SelfPostBottomSheetContent({super.key, this.viewListingOnPressed});
  final VoidCallback? viewListingOnPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomListTile(
          leading: const CircularContainer(icon: BipHip.openedEye),
          title: ksViewListing.tr,
          onPressed: viewListingOnPressed,
        ),
        CustomListTile(
          leading: const CircularContainer(icon: BipHip.deleteNew),
          title: ksDeleteListing.tr,
        ),
        CustomListTile(
          leading: const CircularContainer(icon: BipHip.edit),
          title: ksEditListing.tr,
        ),
        CustomListTile(
          leading: const CircularContainer(icon: BipHip.checkboxNew),
          title: ksMarkAsSold.tr,
        ),
      ],
    );
  }
}
