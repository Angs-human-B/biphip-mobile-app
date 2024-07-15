import 'package:bip_hip/controllers/marketplace/marketplace_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/marketplace/marketplace_view_listing_page.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';

class MarketplacePage extends StatelessWidget {
  MarketplacePage({super.key});
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
              titleSpacing: 0,
              title: CustomModifiedTextField(
                controller: marketPlaceController.marketPlaceTextEditingController,
                hint: ksSearchItem.tr,
                contentPadding: const EdgeInsets.only(top: k12Padding, left: k8Padding),
                prefixIcon: BipHip.search,
              ),
              hasBackButton: true,
              isCenterTitle: false,
              onBack: () {
                Get.back();
              },
              action: [
                Padding(
                  padding: const EdgeInsets.only(right: k20Padding, left: k8Padding, bottom: k8Padding),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(krMarketPlaceAccount);
                    },
                    child: const Icon(
                      BipHip.user,
                      color: cBlackColor,
                      size: kIconSize20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Column(
              children: [
                kH16sizedBox,
                Row(
                  children: [
                    Text(
                      ksMarketPlace,
                      style: semiBold24TextStyle(cBlackColor),
                    ),
                    kW20sizedBox,
                    TopWidgetButton(
                      width: (width - 108) / 3,
                      height: h36,
                      icon: BipHip.add,
                      text: ksSelling.tr,
                      onPressed: () {
                        Get.toNamed(krMarketPlaceSellingPage);
                      },
                    ),
                    kW8sizedBox,
                    TopWidgetButton(
                      onPressed: () {
                        Get.toNamed(krMarketPlaceCategoriesPage);
                      },
                      width: (width - 108) / 3,
                      height: h36,
                      icon: BipHip.menuFill,
                      text: ksCategories.tr,
                    ),
                  ],
                ),
                kH12sizedBox,
                const CustomDivider(),
                kH16sizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ksTodayPicks.tr,
                      style: semiBold18TextStyle(cBlackColor),
                    ),
                    InkWell(
                      onTap: () {
                        Get.find<GlobalController>().commonBottomSheet(
                            context: context,
                            bottomSheetHeight: isDeviceScreenLarge() ? height * 0.4 : height * 0.5,
                            content: ShortByBottomSheetContent(),
                            onPressCloseButton: () {
                              Get.back();
                            },
                            onPressRightButton: () {},
                            rightText: ksReset.tr,
                            rightTextStyle: semiBold14TextStyle(cSmallBodyTextColor),
                            title: ksShortBy.tr,
                            isBottomSheetRightButtonActive: marketPlaceController.shortByBottomSheetState,
                            isRightButtonShow: true);
                      },
                      child: Text(
                        ksFilters.tr,
                        style: semiBold16TextStyle(cPrimaryColor),
                      ),
                    ),
                  ],
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

class TopWidgetButton extends StatelessWidget {
  const TopWidgetButton({super.key, required this.width, required this.icon, required this.text, required this.height, this.onPressed});
  final double width, height;
  final IconData icon;
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(k8BorderRadius),
          color: cNeutralColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: kIconSize12,
              color: cBlackColor,
            ),
            kW4sizedBox,
            Text(
              text,
              style: regular12TextStyle(cBlackColor),
            ),
          ],
        ),
      ),
    );
  }
}

class MarketplaceItemContainer extends StatelessWidget {
  const MarketplaceItemContainer({super.key, required this.productImage, required this.price, required this.location, required this.details});
  final String? productImage, price, location, details;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(k8BorderRadius),
        border: Border.all(width: 1, color: cLineColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(k8BorderRadius), topRight: Radius.circular(k8BorderRadius)),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(k8BorderRadius), topRight: Radius.circular(k8BorderRadius)),
              child: Image.network(
                productImage ?? "",
                width: width,
                fit: BoxFit.cover,
                loadingBuilder: imageLoadingBuilder,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    BipHip.imageFile,
                    size: kIconSize100,
                    color: cIconColor,
                  );
                },
              ),
            ),
          ),
          kH8sizedBox,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: k8Padding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  price ?? ksNA.tr,
                  style: semiBold16TextStyle(cBlackColor),
                ),
                Row(
                  children: [
                    const Icon(
                      BipHip.location,
                      color: cIconColor,
                      size: kIconSize12,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: k2Padding),
                      child: Text(
                        location ?? ksNA.tr,
                        style: regular12TextStyle(cSmallBodyTextColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          kH4sizedBox,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: k8Padding),
            child: Text(
              details ?? ksNA.tr,
              style: regular12TextStyle(cBlackColor),
            ),
          ),
        ],
      ),
    );
  }
}

class ShortByBottomSheetContent extends StatelessWidget {
  ShortByBottomSheetContent({super.key});
  final MarketPlaceController marketPlaceController = Get.find<MarketPlaceController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: k8Padding, top: k16Padding),
              child: Row(
                children: [
                  Container(
                    width: h24,
                    height: h24,
                    decoration: const BoxDecoration(
                      color: cNeutralColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      BipHip.location,
                      size: kIconSize12,
                      color: cBlackColor,
                    ),
                  ),
                  kW8sizedBox,
                  Text(
                    "Dhaka, Bangladesh",
                    style: semiBold14TextStyle(cPrimaryColor),
                  ),
                ],
              ),
            ),
            kH8sizedBox,
            CustomListTile(
              leading: Container(
                width: h24,
                height: h24,
                decoration: const BoxDecoration(
                  color: cNeutralColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  BipHip.calendarFill,
                  size: kIconSize12,
                  color: cBlackColor,
                ),
              ),
              title: Text(
                ksPriceRange.tr,
                style: semiBold14TextStyle(cBlackColor),
              ),
              subtitle: Text(
                ksAnyPrice.tr,
                style: regular12TextStyle(cSmallBodyTextColor),
              ),
            ),
            kH8sizedBox,
            CustomListTile(
              onPressed: () {
                marketPlaceController.temporarySelectedDatePosted.value = marketPlaceController.selectedDatePosted.value;
                Get.find<GlobalController>().commonBottomSheet(
                    context: context,
                    content: DatePostedContent(),
                    onPressCloseButton: () {
                      Get.back();
                    },
                    onPressRightButton: () {
                      marketPlaceController.selectedDatePosted.value = marketPlaceController.temporarySelectedDatePosted.value;
                      Get.back();
                    },
                    rightText: ksDone.tr,
                    rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                    title: ksDateListed.tr,
                    isRightButtonShow: true,
                    isBottomSheetRightButtonActive: marketPlaceController.isDatePostedBottomSheetState);
              },
              leading: Container(
                width: h24,
                height: h24,
                decoration: const BoxDecoration(
                  color: cNeutralColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  BipHip.calendarFill,
                  size: kIconSize12,
                  color: cBlackColor,
                ),
              ),
              title: Text(
                ksDateListed.tr,
                style: semiBold14TextStyle(cBlackColor),
              ),
              subtitle: Text(
                marketPlaceController.selectedDatePosted.value,
                style: regular12TextStyle(cSmallBodyTextColor),
              ),
            ),
            CustomListTile(
              onPressed: () {
                marketPlaceController.temporarySelectedProductCondition.value = marketPlaceController.selectedProductCondition.value;
                Get.find<GlobalController>().commonBottomSheet(
                    context: context,
                    content: ProductConditionContent(),
                    onPressCloseButton: () {
                      Get.back();
                    },
                    onPressRightButton: () {
                      marketPlaceController.selectedProductCondition.value = marketPlaceController.temporarySelectedProductCondition.value;
                      Get.back();
                    },
                    rightText: ksDone.tr,
                    rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                    title: ksDateListed.tr,
                    isRightButtonShow: true,
                    isBottomSheetRightButtonActive: marketPlaceController.isProductConditionBottomSheetState);
              },
              leading: Container(
                width: h24,
                height: h24,
                decoration: const BoxDecoration(
                  color: cNeutralColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  BipHip.gift,
                  size: kIconSize12,
                  color: cBlackColor,
                ),
              ),
              title: Text(
                ksCondition.tr,
                style: semiBold14TextStyle(cBlackColor),
              ),
              subtitle: Text(
                marketPlaceController.selectedProductCondition.value,
                style: regular12TextStyle(cSmallBodyTextColor),
              ),
            ),
          ],
        ));
  }
}

class DatePostedContent extends StatelessWidget {
  DatePostedContent({super.key});
  final MarketPlaceController marketPlaceController = Get.find<MarketPlaceController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: marketPlaceController.datePostedList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: k10Padding),
              child: Obx(
                () => CustomListTile(
                  itemColor: marketPlaceController.temporarySelectedDatePosted.value == marketPlaceController.datePostedList[index].toString()
                      ? cPrimaryTint3Color
                      : cWhiteColor,
                  onPressed: () {
                    marketPlaceController.temporarySelectedDatePosted.value = marketPlaceController.datePostedList[index].toString();
                    if (marketPlaceController.temporarySelectedDatePosted.value == "") {
                      marketPlaceController.isDatePostedBottomSheetState.value = false;
                    } else {
                      marketPlaceController.isDatePostedBottomSheetState.value = true;
                    }
                    ll(marketPlaceController.temporarySelectedDatePosted.value);
                  },
                  title: marketPlaceController.datePostedList[index].toString(),
                  borderColor: marketPlaceController.temporarySelectedDatePosted.value == marketPlaceController.datePostedList[index].toString()
                      ? cPrimaryColor
                      : cLineColor,
                  trailing: CustomRadioButton(
                    onChanged: () {
                      marketPlaceController.temporarySelectedDatePosted.value = marketPlaceController.datePostedList[index].toString();
                      if (marketPlaceController.temporarySelectedDatePosted.value == "") {
                        marketPlaceController.isDatePostedBottomSheetState.value = false;
                      } else {
                        marketPlaceController.isDatePostedBottomSheetState.value = true;
                      }
                    },
                    isSelected: marketPlaceController.temporarySelectedDatePosted.value == marketPlaceController.datePostedList[index].toString(),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class ProductConditionContent extends StatelessWidget {
  ProductConditionContent({super.key});
  final MarketPlaceController marketPlaceController = Get.find<MarketPlaceController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: marketPlaceController.productConditionList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: k10Padding),
              child: Obx(
                () => CustomListTile(
                  itemColor: marketPlaceController.temporarySelectedProductCondition.value == marketPlaceController.productConditionList[index]
                      ? cPrimaryTint3Color
                      : cWhiteColor,
                  onPressed: () {
                    marketPlaceController.temporarySelectedProductCondition.value = marketPlaceController.productConditionList[index];
                    if (marketPlaceController.temporarySelectedProductCondition.value == '') {
                      marketPlaceController.isProductConditionBottomSheetState.value = false;
                    } else {
                      marketPlaceController.isProductConditionBottomSheetState.value = true;
                    }
                  },
                  title: marketPlaceController.productConditionList[index],
                  borderColor: marketPlaceController.temporarySelectedProductCondition.value == marketPlaceController.productConditionList[index]
                      ? cPrimaryColor
                      : cLineColor,
                  trailing: CustomRadioButton(
                    onChanged: () {
                      marketPlaceController.temporarySelectedProductCondition.value = marketPlaceController.productConditionList[index];
                      if (marketPlaceController.temporarySelectedProductCondition.value == '') {
                        marketPlaceController.isProductConditionBottomSheetState.value = false;
                      } else {
                        marketPlaceController.isProductConditionBottomSheetState.value = true;
                      }
                    },
                    isSelected: marketPlaceController.temporarySelectedProductCondition.value == marketPlaceController.productConditionList[index],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
