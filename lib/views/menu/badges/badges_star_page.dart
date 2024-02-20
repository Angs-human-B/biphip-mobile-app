import 'package:bip_hip/controllers/menu/pendent_badges_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/badges/all_badges.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
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
                      itemCount: pendentBadgesController.recommendedBadgesPackages.length,
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
                            recommendedOrAllBadgesList: pendentBadgesController.recommendedBadgesPackages,
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
                        Get.toNamed(krAllBadges);
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
            color: (pendentBadgesController.selectedBadgeIndex.value == index) ? cPrimaryTint3Color : cWhiteColor,
            border: Border.all(color: (pendentBadgesController.selectedBadgeIndex.value == index) ? cPrimaryColor : cLineColor)),
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

class PurchaseStarContent extends StatelessWidget {
  PurchaseStarContent({super.key});

  final PendentBadgesController pendentBadgesController = Get.find<PendentBadgesController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                ksYourCurrentStar.tr,
                style: regular12TextStyle(cIconColor),
              ),
              Text(
                " (${pendentBadgesController.currentStar.value} of 200)",
                style: regular12TextStyle(cIconColor),
              )
            ],
          ),
          kH4sizedBox,
          Container(
            height: 44,
            width: width,
            decoration: BoxDecoration(borderRadius: k8CircularBorderRadius, color: cGreyBoxColor),
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
                    '${pendentBadgesController.currentStar.value}',
                    style: semiBold20TextStyle(cWhiteColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: k8Padding, left: 1),
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
          kH24sizedBox,
          const CustomDivider(),
          kH16sizedBox,
          Text(
            ksYourSelectedPackage.tr,
            style: regular12TextStyle(cIconColor),
          ),
          kH8sizedBox,
          Obx(() => CustomListTile(
                leading: SvgPicture.asset(
                  kiBadgeSvgImageUrl,
                  width: 20,
                  height: 20,
                ),
                title: pendentBadgesController.totalStars.value != ''
                    ? '${pendentBadgesController.totalStars.value} stars'
                    : '${pendentBadgesController.selectedPackage.value!['amount']} stars',
                borderColor: cPrimaryColor,
                itemColor: cPrimaryTint2Color,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // if (postReactionController.balance < int.parse(postReactionController.selectedPackage.value!['amount']) ||
                    //     (postReactionController.totalStars.value != '' && postReactionController.balance < int.parse(postReactionController.totalStars.value)))
                      Text(
                        pendentBadgesController.totalStars.value != ''
                            ? "\$${pendentBadgesController.totalStarBuyAmount.value.toStringAsFixed(2)}"
                            : "\$${pendentBadgesController.selectedPackage.value!['cost']}",
                        style: semiBold16TextStyle(cBlackColor),
                      ),
                  ],
                ),
              )),
          kH16sizedBox,
          const CustomDivider(),
          kH16sizedBox,
          Text(
            ksAllStars.tr,
            style: regular12TextStyle(cIconColor),
          ),
          kH8sizedBox,
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: ksStarsThatYouPurchase.tr,
                  style: regular12TextStyle(cBlackColor),
                ),
                TextSpan(
                  text: ksLearnMoreAboutStars.tr,
                  style: regular12TextStyle(cPrimaryColor),
                ),
              ],
            ),
          ),
          // if (postReactionController.balance < int.parse(postReactionController.selectedPackage.value!['amount']) ||
          //     (postReactionController.totalStars.value != '' && postReactionController.balance < int.parse(postReactionController.totalStars.value)))
            InkWell(
              onTap: () {
                pendentBadgesController.temporarytotalStarBuyAmount.value = pendentBadgesController.totalStarBuyAmount.value;
                pendentBadgesController.temporaryTotalStars.value = pendentBadgesController.totalStars.value;
                pendentBadgesController.starAmountTextEditingController.text = pendentBadgesController.totalStars.value;
                if (pendentBadgesController.starAmountTextEditingController.text.toString().trim() == '') {
                  pendentBadgesController.isStarAmountConfirmButtonEnabled.value = false;
                }
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
              child: Padding(
                padding: const EdgeInsets.only(top: k16Padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      BipHip.plus,
                      color: cPrimaryColor,
                    ),
                    kW4sizedBox,
                    Text(
                      ksPurchaseCustomStar.tr,
                      style: semiBold14TextStyle(cPrimaryColor),
                    )
                  ],
                ),
              ),
            ),
          kH16sizedBox,
          const CustomDivider(),
          kH16sizedBox,
          Text(
            ksPopularPackage.tr,
            style: regular10TextStyle(cIconColor),
          ),
          kH16sizedBox,
          SizedBox(
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: packages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: k8Padding),
                    child: CustomListTile(
                      onPressed: () {
                        // pendentBadgesController.selectedPackage.value = packages[index];
                        pendentBadgesController.resetPurchaseCustomStar();
                      },
                      leading: SvgPicture.asset(kiBadgeSvgImageUrl, width: 20, height: 20),
                      title: '${packages[index]['amount']} stars',
                      // borderColor: postReactionController.selectedPackage.value == packages[index] ? cPrimaryColor : cLineColor,
                      // itemColor: postReactionController.selectedPackage.value == packages[index] ? cPrimaryTint3Color : cWhiteColor,
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // if (pendentBadgesController.currentStar < int.parse(packages[index]['amount']))
                            Text(
                              '\$${packages[index]['cost']}',
                              style: semiBold16TextStyle(cBlackColor),
                            ),
                          kW8sizedBox,
                          // Radio(
                          //   value: packages[index],
                          //   // groupValue: postReactionController.selectedPackage.value,
                          //   // onChanged: (v) {
                          //   //   postReactionController.selectedPackage.value = v;
                          //   // },
                          //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          //   visualDensity: const VisualDensity(
                          //     horizontal: VisualDensity.minimumDensity,
                          //     vertical: VisualDensity.minimumDensity,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() => Transform.translate(
                    offset: const Offset(-10.0, 0.0),
                    child: Checkbox(
                      value: pendentBadgesController.badgesCheckBox.value,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onChanged: (v) {
                        pendentBadgesController.badgesCheckBox.value = ! pendentBadgesController.badgesCheckBox.value;
                      },
                    ),
                  )),
              kW12sizedBox,
              Transform.translate(
                offset: const Offset(-20, 0.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                          child: InkWell(
                              onTap: () {
                                pendentBadgesController.badgesCheckBox.value = !pendentBadgesController.badgesCheckBox.value;
                              },
                              child: Text('${ksIAgreeWith.tr} ', style: regular12TextStyle(cBlackColor)))),
                      TextSpan(text: ksTermsCondition.tr, style: regular12TextStyle(cPrimaryColor))
                    ],
                  ),
                ),
              ),
            ],
          ),
          kH8sizedBox,
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Image.asset(kiProfilePicImageUrl),
                ),
              ),
              kW8sizedBox,
              // Expanded(
              //   child: CustomModifiedTextField(
              //       hint: ksAddAommentWithYourGift.tr,
              //       textHintStyle: regular12TextStyle(cSmallBodyTextColor),
              //       inputAction: TextInputAction.done,
              //       contentPadding: const EdgeInsets.symmetric(vertical: k10Padding, horizontal: k8Padding),
              //       borderRadius: 8,
              //       controller: postReactionController.giftAddCommentTextEditingController),
              // ),
            ],
          ),
          kH12sizedBox,
          // CustomElevatedButton(
          //     label: postReactionController.balance < int.parse(postReactionController.selectedPackage.value!['amount'])
          //         ? ksNext.tr
          //         : postReactionController.totalStars.value != ''
          //             ? (postReactionController.balance < int.parse(postReactionController.totalStars.value))
          //                 ? ksNext.tr
          //                 : "${ksSend.tr} ${postReactionController.totalStars.value} ${ksStars.tr}"
          //             : "${ksSend.tr} ${postReactionController.selectedPackage.value!['amount']} ${ksStars.tr}",
          //     buttonHeight: 42,
          //     buttonWidth: width - 40,
          //     onPressed: postReactionController.giftCheckBox.value
          //         ? () {
          //             Get.find<GlobalController>().commonBottomSheet(
          //                 context: context,
          //                 bottomSheetHeight: isDeviceScreenLarge() ? height * 0.6 : height * 0.7,
          //                 isScrollControlled: true,
          //                 content: GiftPurchasePaymentContent(),
          //                 onPressCloseButton: () {
          //                   Get.back();
          //                 },
          //                 onPressRightButton: () {},
          //                 rightText: '',
          //                 rightTextStyle: semiBold16TextStyle(cPrimaryColor),
          //                 title: ksPayNow.tr,
          //                 isRightButtonShow: false);
          //           }
          //         : null),
      
        ],
      ),
    );
  }
}
