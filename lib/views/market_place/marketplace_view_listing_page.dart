import 'package:bip_hip/controllers/marketplace/marketplace_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';

class MarketPlaceViewListingPage extends StatelessWidget {
  MarketPlaceViewListingPage({super.key, this.productImage, this.price, this.location, this.details, this.isBiddingPost});
  final String? productImage, price, location, details;
  final bool? isBiddingPost;
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
              title: ksViewListing.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Image.network(
                  productImage ?? "",
                  width: width,
                  height: 175,
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
                kH16sizedBox,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        details ?? ksNA.tr,
                        style: semiBold16TextStyle(cBlackColor),
                      ),
                      kH4sizedBox,
                      Row(
                        children: [
                          Text(
                            price ?? ksNA.tr,
                            style: regular16TextStyle(cBlackColor),
                          ),
                          kW4sizedBox,
                          Container(
                            width: 2,
                            height: 2,
                            decoration: const BoxDecoration(shape: BoxShape.circle, color: cBlackColor),
                          ),
                          kW4sizedBox,
                          Text(
                            location ?? ksNA.tr,
                            style: regular16TextStyle(cSmallBodyTextColor),
                          ),
                        ],
                      ),
                      kH20sizedBox,
                      Container(
                        width: width - 40,
                        height: 90,
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
                                  const Icon(
                                    BipHip.chatFill,
                                    color: cPrimaryColor,
                                    size: kIconSize16,
                                  ),
                                  kW8sizedBox,
                                  Text(
                                    ksSendSellerAMessage.tr,
                                    style: regular14TextStyle(cBlackColor),
                                  ),
                                ],
                              ),
                              kH8sizedBox,
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: h40,
                                      child: CustomModifiedTextField(
                                        hint: ksIsThisStillAvailable.tr,
                                        controller: marketPlaceController.sellertMessageTextEditingController,
                                        contentPadding: const EdgeInsets.only(left: k8Padding, top: k8Padding),
                                      ),
                                    ),
                                  ),
                                  kW8sizedBox,
                                  CustomElevatedButton(
                                    label: ksSend,
                                    onPressed: () {},
                                    buttonColor: cPrimaryColor,
                                    buttonWidth: 80,
                                    buttonHeight: h32,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      kH20sizedBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if (isBiddingPost == true)
                            ContainerWithIcon(
                              icon: BipHip.bidding,
                              title: ksBid.tr,
                              onPressed: () {},
                            ),
                          if (isBiddingPost == false)
                            ContainerWithIcon(
                              icon: BipHip.chatOutline,
                              title: ksViewMessage.tr,
                              onPressed: () {},
                            ),
                          ContainerWithIcon(
                            icon: BipHip.shopFill,
                            title: ksVisitShop.tr,
                            onPressed: () {},
                          ),
                          ContainerWithIcon(
                            icon: BipHip.share,
                            title: ksShare.tr,
                            onPressed: () {
                              Get.find<GlobalController>().blankBottomSheet(
                                context: context,
                                bottomSheetHeight: isDeviceScreenLarge() ? height * 0.3 : height * 0.40,
                                content: ShareBottomSheetContent(),
                              );
                            },
                          ),
                          ContainerWithIcon(
                              icon: BipHip.system,
                              title: ksMore.tr,
                              onPressed: () {
                                Get.find<GlobalController>().blankBottomSheet(
                                  context: context,
                                  bottomSheetHeight: isDeviceScreenLarge() ? height * 0.15 : height * 0.25,
                                  content: MoreBottomSheetContent(),
                                );
                              }),
                        ],
                      ),
                      kH16sizedBox,
                      const CustomDivider(),
                      kH16sizedBox,
                      Text(
                        ksDescription,
                        style: semiBold16TextStyle(cBlackColor),
                      ),
                      kH8sizedBox,
                      Text(
                        marketPlaceController.descriptionText,
                        style: regular12TextStyle(cBlackColor),
                      ),
                      if (marketPlaceController.descriptionText.length > 50)
                        Text(
                          "$ksSeeMore...",
                          style: regular12TextStyle(cSmallBodyTextColor),
                        ),
                      kH16sizedBox,
                      const CustomDivider(),
                      kH16sizedBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ksSellerInformation.tr,
                            style: semiBold16TextStyle(cBlackColor),
                          ),
                          Text(
                            ksSellerDetails.tr,
                            style: regular14TextStyle(cPrimaryColor),
                          ),
                        ],
                      ),
                      kH16sizedBox,
                      Row(
                        children: [
                          ClipOval(
                            child: Image.network(
                              "https://whyy.org/wp-content/uploads/2024/02/AP23342825758469-768x511.jpg",
                              width: h42,
                              height: h42,
                              fit: BoxFit.cover,
                              loadingBuilder: imageLoadingBuilder,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  BipHip.user,
                                  size: kIconSize40,
                                  color: cBlackColor,
                                );
                              },
                            ),
                          ),
                          kW12sizedBox,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Lionel Messi",
                                style: semiBold16TextStyle(cBlackColor),
                              ),
                              kH4sizedBox,
                              Text(
                                "Join BipHip in 2023",
                                style: regular10TextStyle(cBlackColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                      kH16sizedBox,
                      const CustomDivider(),
                      kH16sizedBox,
                      Text(
                        ksDetails.tr,
                        style: semiBold16TextStyle(cBlackColor),
                      ),
                      kH8sizedBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ksCondition.tr,
                            style: regular12TextStyle(cBlackColor),
                          ),
                          Text(
                            "Used, like new",
                            style: regular12TextStyle(cBlackColor),
                          ),
                        ],
                      ),
                      kH16sizedBox,
                      const CustomDivider(),
                      kH16sizedBox,
                      Text(
                        ksMeetupPreferences.tr,
                        style: semiBold16TextStyle(cBlackColor),
                      ),
                      kH16sizedBox,
                      Image.network(
                        "https://www.google.com/maps/about/images/mymaps/mymaps-desktop-16x9.png",
                        width: width - 40,
                        height: h44,
                        fit: BoxFit.cover,
                        loadingBuilder: imageLoadingBuilder,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            BipHip.imageFile,
                            size: kIconSize40,
                            color: cIconColor,
                          );
                        },
                      ),
                      kH8sizedBox,
                      Text(
                        "Dhaka",
                        style: regular12TextStyle(cBlackColor),
                      ),
                      kH4sizedBox,
                      Text(
                        "Location is approximate",
                        style: regular10TextStyle(cSmallBodyTextColor),
                      ),
                      kH16sizedBox,
                    ],
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

class ContainerWithIcon extends StatelessWidget {
  const ContainerWithIcon({super.key, required this.icon, required this.onPressed, required this.title});
  final IconData icon;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            width: h42,
            height: h42,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: cNeutralColor,
            ),
            child: Icon(
              icon,
              size: kIconSize20,
              color: cBlackColor,
            ),
          ),
          kH4sizedBox,
          Text(
            title,
            style: regular12TextStyle(cBlackColor),
          ),
        ],
      ),
    );
  }
}

class CircularContainer extends StatelessWidget {
  const CircularContainer({super.key, required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 30,
        height: 30,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: cNeutralColor,
        ),
        child: Icon(
          icon,
          color: cBlackColor,
          size: kIconSize16,
        ));
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
          leading: const CircularContainer(icon: BipHip.shopFill),
          title: ksSharetoYourStoreProfile.tr,
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

class MoreBottomSheetContent extends StatelessWidget {
  const MoreBottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomListTile(
          leading: const CircularContainer(icon: BipHip.passwordHide),
          title: ksHidePost.tr,
        ),
        CustomListTile(
          leading: const CircularContainer(icon: BipHip.report),
          title: ksReportPost.tr,
        ),
      ],
    );
  }
}
