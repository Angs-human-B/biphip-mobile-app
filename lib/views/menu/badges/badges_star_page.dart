import 'package:bip_hip/controllers/menu/pendent_badges_controller.dart';
import 'package:bip_hip/shimmers/menu/badges/badge_page_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/badges/all_badges.dart';

class BadgesStarPage extends StatelessWidget {
  BadgesStarPage({super.key});
  final PendentBadgesController pendentBadgesController = Get.find<PendentBadgesController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Obx(
        () => Stack(
          children: [
            SafeArea(
              top: false,
              child: Scaffold(
                backgroundColor: cWhiteColor,
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(kAppBarSize),
                  //* info:: appBar
                  child: CustomAppBar(
                    title: ksBadges.tr,
                    hasBackButton: true,
                    isCenterTitle: true,
                    onBack: () {
                      Get.back();
                    },
                    action: [
                      Padding(
                        padding: const EdgeInsets.only(right: h20),
                        child: TextButton(
                          style: kTextButtonStyle,
                          onPressed: () {
                            unFocus(context);
                            Get.find<GlobalController>().commonBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                bottomSheetHeight: isDeviceScreenLarge() ? height * 0.4 : height * 0.5,
                                content: PurchaseCustomStarContent(),
                                onPressCloseButton: () {
                                  Get.back();
                                },
                                onPressRightButton: null,
                                rightText: '',
                                rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                                title: ksBuyCustomStar.tr,
                                isRightButtonShow: false);
                          },
                          child: Text(
                            ksCustomStars.tr,
                            style: semiBold14TextStyle(cPrimaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                  child: SingleChildScrollView(
                    child: pendentBadgesController.isUserBadgeLoading.value || pendentBadgesController.isgetStarPriceLoading.value
                        ? const BadgePageShimmer()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              kH16sizedBox,
                              Text(
                                ksCurrentStar.tr,
                                style: semiBold16TextStyle(cBlackColor),
                              ),
                              kH16sizedBox,
                              Container(
                                width: width - 40,
                                height: 64,
                                decoration: BoxDecoration(
                                  color: cWhiteColor,
                                  border: Border.all(color: cLineColor, width: 1),
                                  borderRadius: BorderRadius.circular(k8BorderRadius),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        BipHip.giftNew,
                                        color: cSecondaryColor,
                                        size: kIconSize16,
                                      ),
                                      kW4sizedBox,
                                      ShaderMask(
                                        shaderCallback: (Rect bounds) {
                                          return const LinearGradient(
                                            colors: [cBlueLinearColor1, cBlueLinearColor2],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ).createShader(bounds);
                                        },
                                        child: Text(
                                          '${pendentBadgesController.userBadgesData.value?.starBalance}',
                                          style: semiBold20TextStyle(cWhiteColor),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: k16Padding, left: 1),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            ksStars,
                                            style: regular12TextStyle(cSmallBodyTextColor),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              kH16sizedBox,
                              Text(
                                ksRecommended,
                                style: semiBold18TextStyle(cBlackColor),
                              ),
                              kH16sizedBox,
                              SizedBox(
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: pendentBadgesController.recommendedBadgesList.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: isDeviceScreenLarge() ? 0.85 : 1,
                                    crossAxisCount: 3,
                                    crossAxisSpacing: k16Padding,
                                    mainAxisSpacing: k16Padding,
                                  ),
                                  itemBuilder: (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        pendentBadgesController.isPackageSelected.value = true;
                                        pendentBadgesController.selectedBadgeIndex.value = index;
                                        pendentBadgesController.selectedBadgeIndex.value = -1;
                                        pendentBadgesController.badgesCheckBox.value = false;
                                        pendentBadgesController.badgesPaymentCheckBox.value = false;
                                        pendentBadgesController.temporarytotalStarBuyAmount.value = 0;
                                        pendentBadgesController.totalStarBuyAmount.value = 0;
                                        pendentBadgesController.temporaryTotalStars.value = '';
                                        pendentBadgesController.totalStars.value = '';
                                        pendentBadgesController.isStarAmountConfirmButtonEnabled.value = false;
                                        pendentBadgesController.starAmountTextEditingController.clear();
                                        pendentBadgesController.selectedBadgeIcon.value = pendentBadgesController.recommendedBadgesList[index].icon!;
                                        pendentBadgesController.selectedBadgeStar.value = pendentBadgesController.recommendedBadgesList[index].star.toString();
                                        pendentBadgesController.selectedBadgePrice.value =
                                            pendentBadgesController.recommendedBadgesList[index].price.toString();
                                        pendentBadgesController.selectedBadgeDescription.value =
                                            pendentBadgesController.recommendedBadgesList[index].description!;
                                        pendentBadgesController.badgeId.value = pendentBadgesController.recommendedBadgesList[index].id!;
                                        Get.toNamed(krPurchaseStar);
                                      },
                                      child: BadgesGridViewContainer(
                                        index: index,
                                        recommendedOrAllBadgesList: pendentBadgesController.recommendedBadgesList,
                                        badgeIcon: pendentBadgesController.recommendedBadgesList[index].icon,
                                        badgeName: pendentBadgesController.recommendedBadgesList[index].name,
                                        badgeStar: pendentBadgesController.recommendedBadgesList[index].star.toString(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              kH20sizedBox,
                              CustomElevatedButton(
                                  buttonHeight: h32,
                                  label: ksSeeAllBadges.tr,
                                  onPressed: () {
                                    pendentBadgesController.selectedBadgeIndex.value = -1;
                                    pendentBadgesController.badgesCheckBox.value = false;
                                    pendentBadgesController.badgesPaymentCheckBox.value = false;
                                    Get.toNamed(krAllBadges);
                                  }),
                              kH20sizedBox,
                            ],
                          ),
                  ),
                ),
              ),
            ),
            if (pendentBadgesController.isBuyBadgeLoading.value)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (pendentBadgesController.isgetStarPriceLoading.value) {
                      return false;
                    }
                    return true;
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class BadgesGridViewContainer extends StatelessWidget {
  BadgesGridViewContainer({
    super.key,
    required this.index,
    required this.recommendedOrAllBadgesList,
    this.badgeIcon,
    this.badgeName,
    this.badgeStar,
  });

  final int index;
  final List recommendedOrAllBadgesList;
  final String? badgeIcon;
  final String? badgeName;
  final String? badgeStar;
  final PendentBadgesController pendentBadgesController = Get.find<PendentBadgesController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
            borderRadius: k8CircularBorderRadius,
            color: (pendentBadgesController.selectedBadgeIndex.value == index) ? cPrimaryTint3Color : cWhiteColor,
            border: Border.all(color: (pendentBadgesController.selectedBadgeIndex.value == index) ? cPrimaryColor : cLineColor)),
        child: Padding(
          padding: const EdgeInsets.all(k8Padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                badgeIcon!,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    kiProfileDefaultImageUrl,
                    height: h40,
                    width: h40,
                  );
                },
                loadingBuilder: imageLoadingBuilder,
              ),
              kH4sizedBox,
              Expanded(
                child: Text(
                  badgeName ?? ksNA,
                  style: semiBold14TextStyle(cBlackColor).copyWith(letterSpacing: -0.6),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                ),
              ),
              kH4sizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    BipHip.giftNew,
                    color: cSecondaryColor,
                    size: kIconSize12,
                  ),
                  kW4sizedBox,
                  Text(
                    badgeStar ?? ksNA,
                    style: regular10TextStyle(cBlackColor),
                  ),
                  kH12sizedBox,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
