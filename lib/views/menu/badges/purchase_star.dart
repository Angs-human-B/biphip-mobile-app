import 'package:bip_hip/controllers/menu/pendent_badges_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/badges/all_badges.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:flutter_svg/svg.dart';

class PurchaseStar extends StatelessWidget {
  PurchaseStar({
    super.key,
  });
  final PendentBadgesController pendentBadgesController = Get.find<PendentBadgesController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              title: ksPurchaseStar.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: Obx(
            () => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kH16sizedBox,
                    Row(
                      children: [
                        Text(
                          ksYourCurrentStar.tr,
                          style: regular12TextStyle(cIconColor),
                        ),
                        Text(
                          " (${pendentBadgesController.userBadgesData.value?.starBalance} of 200)",
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
                              '${pendentBadgesController.userBadgesData.value?.starBalance}',
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
                      style: regular12TextStyle(cSmallBodyTextColor),
                    ),
                    kH8sizedBox,
                    Obx(() => CustomListTile(
                          leading: Image.network(
                            pendentBadgesController.selectedBadgeIcon.value,
                            width: h20,
                            height: h20,
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
                          title: pendentBadgesController.totalStars.value != ''
                              ? '${pendentBadgesController.totalStars.value} stars'
                              : '${pendentBadgesController.selectedBadgeStar.value} stars',
                          borderColor: cPrimaryColor,
                          itemColor: cPrimaryTint2Color,
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                pendentBadgesController.totalStars.value != ''
                                    ? '\$${pendentBadgesController.totalStarBuyAmount.value.toStringAsFixed(2)}'
                                    : '\$${pendentBadgesController.selectedBadgePrice.value}',
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
                    Text(
                      pendentBadgesController.selectedBadgeDescription.value,
                      style: regular14TextStyle(cBlackColor),
                    ),
                    //*Not need now.
                    // kH16sizedBox,
                    // for (int i = 0; i < pendentBadgesController.benefitsList.length; i++)
                    //   Padding(
                    //     padding: const EdgeInsets.only(top: k4Padding),
                    //     child: Row(
                    //       children: [
                    //         Container(
                    //           width: 4,
                    //           height: 4,
                    //           decoration: const BoxDecoration(
                    //             shape: BoxShape.circle,
                    //             color: cBlackColor,
                    //           ),
                    //         ),
                    //         kW8sizedBox,
                    //         Text(
                    //           pendentBadgesController.benefitsList[i],
                    //           style: regular12TextStyle(cBlackColor),
                    //           overflow: TextOverflow.clip,
                    //         ),
                    //       ],
                    //     ),
                    //   ),

                    kH16sizedBox,
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "${ksYouCanSendStars.tr}.",
                            style: regular12TextStyle(cBlackColor),
                          ),
                          TextSpan(
                            text: " ${ksLearnMoreAboutStars.tr}",
                            style: regular12TextStyle(cPrimaryColor),
                          ),
                        ],
                      ),
                    ),
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
                          itemCount: pendentBadgesController.popularBadgesList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: k8Padding),
                              child: Obx(() => CustomListTile(
                                    onPressed: () {
                                      // pendentBadgesController.selectedPackage.value = packages[index];
                                      pendentBadgesController.selectedBadgeIndex.value = index;
                                      pendentBadgesController.selectedBadgeIcon.value = pendentBadgesController.popularBadgesList[index].icon!;
                                      pendentBadgesController.selectedBadgeStar.value = pendentBadgesController.popularBadgesList[index].star.toString();
                                      pendentBadgesController.selectedBadgePrice.value = pendentBadgesController.popularBadgesList[index].price.toString();
                                      pendentBadgesController.selectedBadgeDescription.value = pendentBadgesController.popularBadgesList[index].description!;
                                      pendentBadgesController.badgeId.value = pendentBadgesController.popularBadgesList[index].id!;
                                      pendentBadgesController.resetPurchaseCustomStar();
                                    },
                                    leading: Image.network(
                                      pendentBadgesController.popularBadgesList[index].icon!,
                                      width: h20,
                                      height: h20,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Image.asset(
                                          kiProfileDefaultImageUrl,
                                          height: h20,
                                          width: h20,
                                        );
                                      },
                                      loadingBuilder: imageLoadingBuilder,
                                    ),
                                    title: '${pendentBadgesController.popularBadgesList[index].star} stars',
                                    borderColor: pendentBadgesController.selectedBadgeIndex.value == index ? cPrimaryColor : cLineColor,
                                    itemColor: pendentBadgesController.selectedBadgeIndex.value == index ? cPrimaryTint3Color : cWhiteColor,
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          '\$${pendentBadgesController.popularBadgesList[index].price}',
                                          style: semiBold16TextStyle(cBlackColor),
                                        ),
                                        kW8sizedBox,
                                        Radio(
                                          value: index,
                                          groupValue: pendentBadgesController.selectedBadgeIndex.value,
                                          onChanged: (v) {
                                            pendentBadgesController.selectedBadgeIndex.value = int.parse(v.toString());
                                            pendentBadgesController.selectedBadgeIndex.value = index;
                                            pendentBadgesController.selectedBadgeIcon.value = pendentBadgesController.popularBadgesList[index].icon!;
                                            pendentBadgesController.selectedBadgeStar.value = pendentBadgesController.popularBadgesList[index].star.toString();
                                            pendentBadgesController.selectedBadgePrice.value =
                                                pendentBadgesController.popularBadgesList[index].price.toString();
                                            pendentBadgesController.selectedBadgeDescription.value =
                                                pendentBadgesController.popularBadgesList[index].description!;
                                            pendentBadgesController.badgeId.value = pendentBadgesController.popularBadgesList[index].id!;
                                            pendentBadgesController.resetPurchaseCustomStar();
                                          },
                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          visualDensity: const VisualDensity(
                                            horizontal: VisualDensity.minimumDensity,
                                            vertical: VisualDensity.minimumDensity,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
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
                                  pendentBadgesController.badgesCheckBox.value = !pendentBadgesController.badgesCheckBox.value;
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
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 0.8),
                                          child: Text('${ksIAgreeWith.tr} ', style: regular12TextStyle(cBlackColor)),
                                        ))),
                                TextSpan(text: ksTermsCondition.tr, style: regular12TextStyle(cPrimaryColor))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    kH24sizedBox,
                    CustomElevatedButton(
                        label: ksNext,
                        buttonWidth: width - 40,
                        onPressed: pendentBadgesController.badgesCheckBox.value
                            ? () async {
                                Get.find<GlobalController>().commonBottomSheet(
                                    context: context,
                                    bottomSheetHeight: isDeviceScreenLarge() ? height * 0.6 : height * 0.7,
                                    isScrollControlled: true,
                                    content: GiftPurchasePaymentContent(),
                                    onPressCloseButton: () {
                                      Get.back();
                                    },
                                    onPressRightButton: () {},
                                    rightText: '',
                                    rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                                    title: ksPayNow.tr,
                                    isRightButtonShow: false);
                              }
                            : null),
                    kH20sizedBox,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GiftPurchasePaymentContent extends StatelessWidget {
  GiftPurchasePaymentContent({super.key});
  final PendentBadgesController pendentBadgesController = Get.find<PendentBadgesController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: SvgPicture.asset(
                kiPayment,
                width: h40,
                height: h40,
              ),
            ),
            kW12sizedBox,
            kH8sizedBox,
            Column(
              children: [
                Text(
                  '\$${pendentBadgesController.totalStars.value != '' ? '\$${pendentBadgesController.totalStarBuyAmount.value.toStringAsFixed(2)}' : '\$${pendentBadgesController.selectedBadgePrice.value}'}',
                  style: semiBold18TextStyle(cBlackColor),
                ),
                kH4sizedBox,
                Text(
                  pendentBadgesController.totalStars.value != ''
                      ? '${pendentBadgesController.totalStars.value} stars'
                      : '${pendentBadgesController.selectedBadgeStar.value} stars',
                  style: semiBold14TextStyle(cPlaceHolderColor),
                ),
              ],
            ),
          ],
        ),
        kH20sizedBox,
        const CustomDivider(),
        kH20sizedBox,
        CustomModifiedTextField(
          controller: pendentBadgesController.badgesCardNumberTextEditingController,
          hint: ksCardNumber.tr,
          inputType: TextInputType.number,
          inputAction: TextInputAction.next,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          maxLength: 16,
          textHintStyle: regular14TextStyle(cPlaceHolderColor),
          prefixIcon: BipHip.calendarFill,
          fillColor: cWhiteColor,
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: cLineColor2,
              width: 1.0,
            ),
          ),
        ),
        kH20sizedBox,
        Row(
          children: [
            Expanded(
              child: CustomModifiedTextField(
                controller: pendentBadgesController.badgesMMYYTextEditingController,
                hint: 'MM/YY',
                textHintStyle: regular14TextStyle(cPlaceHolderColor),
                inputType: TextInputType.number,
                inputAction: TextInputAction.next,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (String value) {},
                maxLength: 6,
                fillColor: cWhiteColor,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: cLineColor2,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            kW20sizedBox,
            Expanded(
              child: CustomModifiedTextField(
                controller: pendentBadgesController.badgesCvvTextEditingController,
                hint: ksCVV.tr,
                inputType: TextInputType.number,
                inputAction: TextInputAction.done,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 3,
                textHintStyle: regular14TextStyle(cPlaceHolderColor),
                fillColor: cWhiteColor,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: cLineColor2,
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => Transform.translate(
                  offset: const Offset(-10.0, 0.0),
                  child: Checkbox(
                    value: pendentBadgesController.badgesPaymentCheckBox.value,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onChanged: (v) {
                      pendentBadgesController.badgesPaymentCheckBox.value = !pendentBadgesController.badgesPaymentCheckBox.value;
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
                              pendentBadgesController.badgesPaymentCheckBox.value = !pendentBadgesController.badgesPaymentCheckBox.value;
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 0.8),
                              child: Text('${ksIAgreeWith.tr} ', style: regular12TextStyle(cBlackColor)),
                            ))),
                    TextSpan(text: ksTermsCondition.tr, style: regular12TextStyle(cPrimaryColor))
                  ],
                ),
              ),
            ),
          ],
        ),
        kH16sizedBox,
        const CustomDivider(),
        kH16sizedBox,
        Obx(() => CustomElevatedButton(
            label: ksPayNow.tr,
            buttonHeight: 42,
            buttonWidth: width - 40,
            onPressed: pendentBadgesController.badgesPaymentCheckBox.value
                ? () async {
                    Get.offNamedUntil(krBadgesStarPage, ModalRoute.withName(krMenu));
                    pendentBadgesController.resetBadgesData();
                    await pendentBadgesController.buyBadge();
                  }
                : null)),
      ],
    );
  }
}
