import 'package:bip_hip/controllers/menu/pendent_badges_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter_svg/svg.dart';

class BadgesStarPage extends StatelessWidget {
  BadgesStarPage({super.key});
  final PendentBadgesController pendentBadgesController = Get.find<PendentBadgesController>();

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
                      Get.toNamed(krAddKidSocialLinks);
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                      child: pendentBadgesController.currentStar.value == 0
                          ? Text(
                              ksNoActiveStar.tr,
                              style: semiBold14TextStyle(cSmallBodyTextColor),
                            )
                          : Row(
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
                                    '${pendentBadgesController.currentStar.value}',
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
                      itemCount: pendentBadgesController.recommendedGiftPackages.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: isDeviceScreenLarge() ? 0.95 : 1,
                        crossAxisCount: 3,
                        crossAxisSpacing: k16Padding,
                        mainAxisSpacing: k16Padding,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            // postReactionController.selectedPackage.value = giftPackages[index];
                            // postReactionController.selectedGiftIndex.value = index;
                            // postReactionController.isPackageSelected.value = true;
                            pendentBadgesController.selectedBadgeIndex.value = index;
                          },
                          child: BadgesGridViewContainer(
                            index: index,
                            recommendedOrAllBadgesList: pendentBadgesController.recommendedGiftPackages,
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
                        // pendentBadgesController.selectedPendentIndex.value = -1;
                        // pendentBadgesController.pendentCheckBox.value = false;
                        // pendentBadgesController.paymentCheckBox.value = false;
                        // Get.toNamed(krAllPendent);
                      }),
                  kH20sizedBox,
                ],
              ),
            ),
          ),
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
  });

  final int index;
  final List recommendedOrAllBadgesList;
  final PendentBadgesController pendentBadgesController = Get.find<PendentBadgesController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
            borderRadius: k8CircularBorderRadius,
            color: (pendentBadgesController.selectedPendentIndex.value == index) ? cPrimaryTint3Color : cWhiteColor,
            border: Border.all(color: (pendentBadgesController.selectedPendentIndex.value == index) ? cPrimaryColor : cLineColor)),
        child: Padding(
          padding: const EdgeInsets.all(k8Padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: k8CircularBorderRadius,
                child: SvgPicture.asset(
                  recommendedOrAllBadgesList[index]['badge'],
                  fit: BoxFit.fill,
                ),
              ),
              kH4sizedBox,
              Expanded(
                child: Text(
                  recommendedOrAllBadgesList[index]['packageName'],
                  style: semiBold14TextStyle(cBlackColor),
                  overflow: TextOverflow.ellipsis,
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
                    recommendedOrAllBadgesList[index]['amount'],
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
