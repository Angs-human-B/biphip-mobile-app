import 'package:bip_hip/controllers/menu/pendent_badges_controller.dart';
import 'package:bip_hip/shimmers/menu/pendent/pendent_page_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class PendentPage extends StatelessWidget {
  PendentPage({super.key});
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
                    title: ksPendent.tr,
                    hasBackButton: true,
                    isCenterTitle: true,
                    onBack: () {
                      Get.back();
                    },
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                  child: SingleChildScrollView(
                    child: Obx(
                      () => pendentBadgesController.isUserPendentLoading.value
                          ? const PendentPageShimmer()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                kH16sizedBox,
                                Text(
                                  ksCurrentPendent.tr,
                                  style: semiBold16TextStyle(cBlackColor),
                                ),
                                kH8sizedBox,
                                if (pendentBadgesController.userPendentList.isEmpty)
                                  Container(
                                    width: width - 40,
                                    height: 64,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(k8BorderRadius),
                                      border: Border.all(
                                        color: cLineColor,
                                        width: 1,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        ksNoActivePendent.tr,
                                        style: semiBold14TextStyle(cSmallBodyTextColor),
                                      ),
                                    ),
                                  ),
                                if (pendentBadgesController.userPendentList.isNotEmpty)
                                  Container(
                                    width: width - 40,
                                    height: 124,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(k8BorderRadius),
                                      border: Border.all(
                                        color: cLineColor,
                                        width: 1,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: k16Padding, top: k16Padding),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Your current pendent is ${pendentBadgesController.userPendentList[0].pendent!.name}",
                                                    style: regular14TextStyle(cBlackColor),
                                                  ),
                                                  kH4sizedBox,
                                                  Text(
                                                    ksYouCantDownYourCurrentPendent.tr,
                                                    style: semiBold12TextStyle(cPrimaryColor),
                                                  ),
                                                  kH4sizedBox,
                                                  Text(
                                                    "Purchased on: ${DateFormat('dd MMM, yyyy').format(pendentBadgesController.userPendentList[0].startDate ?? DateTime.now())}",
                                                    style: regular12TextStyle(cSmallBodyTextColor),
                                                  ),
                                                  kH12sizedBox,
                                                  Row(
                                                    children: [
                                                      CustomElevatedButton(
                                                        buttonWidth: 70,
                                                        buttonHeight: h24,
                                                        buttonColor: cPrimaryColor,
                                                        label: ksUpdate.tr,
                                                        textStyle: semiBold12TextStyle(cWhiteColor),
                                                        onPressed: null,
                                                      ),
                                                      kW12sizedBox,
                                                      CustomElevatedButton(
                                                        buttonWidth: 70,
                                                        buttonHeight: h24,
                                                        // borderColor: cPrimaryColor,
                                                        // buttonColor: cWhiteColor,
                                                        buttonColor: cPrimaryColor,
                                                        label: ksHistory.tr,
                                                        textStyle: semiBold12TextStyle(cWhiteColor),
                                                        onPressed: null,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(right: k16Padding),
                                                child: Column(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: k8CircularBorderRadius,
                                                      child: Image.network(
                                                        "${pendentBadgesController.userPendentList[0].pendent?.icon}",
                                                        fit: BoxFit.fill,
                                                        height: 48,
                                                        width: 48,
                                                        loadingBuilder: imageLoadingBuilder,
                                                        errorBuilder: (context, error, stackTrace) {
                                                          return Image.asset(
                                                            kiProfileDefaultImageUrl,
                                                            height: h40,
                                                            width: h40,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    kH8sizedBox,
                                                    Text(
                                                      "${pendentBadgesController.userPendentList[0].pendent!.name}",
                                                      style: semiBold14TextStyle(cBlackColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
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
                                    itemCount: pendentBadgesController.recommendedPendentList.length,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: isDeviceScreenLarge() ? 0.9 : 1,
                                      crossAxisCount: 3,
                                      crossAxisSpacing: k16Padding,
                                      mainAxisSpacing: k16Padding,
                                    ),
                                    itemBuilder: (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          pendentBadgesController.pendentCheckBox.value = false;
                                          pendentBadgesController.paymentCheckBox.value = false;
                                          pendentBadgesController.selectedPendentIndex.value = index;
                                          pendentBadgesController.pendentId.value = pendentBadgesController.recommendedPendentList[index].id!;

                                          if (pendentBadgesController.userPendentList.isEmpty ||
                                              (pendentBadgesController.userPendentList[0].pendent!.price! <
                                                  pendentBadgesController.recommendedPendentList[index].price!)) {
                                            Get.find<GlobalController>().commonBottomSheet(
                                              context: context,
                                              content: PurchasePendentBottomSheetContent(
                                                index: index,
                                                recommendedOrAllPendentList: pendentBadgesController.recommendedPendentList,
                                                pendentIcon: pendentBadgesController.recommendedPendentList[index].icon,
                                                pendentName: pendentBadgesController.recommendedPendentList[index].name,
                                                pendentPrice: pendentBadgesController.recommendedPendentList[index].price.toString(),
                                                pendentDescription: pendentBadgesController.recommendedPendentList[index].description,
                                              ),
                                              onPressCloseButton: () {
                                                Get.back();
                                              },
                                              onPressRightButton: () {
                                                Get.back();
                                              },
                                              rightText: "",
                                              rightTextStyle: medium14TextStyle(cPrimaryColor),
                                              title: ksPurchasePendent.tr,
                                              isRightButtonShow: false,
                                              isScrollControlled: true,
                                            );
                                          }
                                        },
                                        child: PendentGridViewContainer(
                                          index: index,
                                          recommendedOrAllPendentList: pendentBadgesController.recommendedPendentList,
                                          pendentIcon: pendentBadgesController.recommendedPendentList[index].icon,
                                          pendentName: pendentBadgesController.recommendedPendentList[index].name,
                                          pendentPrice: pendentBadgesController.recommendedPendentList[index].price.toString(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                kH20sizedBox,
                                CustomElevatedButton(
                                    buttonHeight: h32,
                                    label: ksSeeAllPendent.tr,
                                    onPressed: () {
                                      pendentBadgesController.resetPendentData();
                                      Get.toNamed(krAllPendent);
                                    }),
                                kH20sizedBox,
                              ],
                            ),
                    ),
                  ),
                ),
              ),
            ),
            if (pendentBadgesController.isBuyPendentLoading.value)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (pendentBadgesController.isBuyPendentLoading.value) {
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

class PurchasePendentBottomSheetContent extends StatelessWidget {
  PurchasePendentBottomSheetContent(
      {super.key,
      required this.index,
      required this.recommendedOrAllPendentList,
      this.pendentName,
      this.pendentPrice,
      this.pendentIcon,
      this.pendentDescription});
  final int index;
  final List recommendedOrAllPendentList;
  final String? pendentName;
  final String? pendentPrice;
  final String? pendentIcon;
  final String? pendentDescription;
  final PendentBadgesController pendentBadgesController = Get.find<PendentBadgesController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ksYourSelectedPackage.tr,
          style: regular12TextStyle(cSmallBodyTextColor),
        ),
        kH8sizedBox,
        CustomListTile(
          leading: ClipRRect(
            borderRadius: k8CircularBorderRadius,
            child: Image.network(
              pendentIcon!,
              fit: BoxFit.fill,
              height: h20,
              width: h20,
              loadingBuilder: imageLoadingBuilder,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  kiProfileDefaultImageUrl,
                  height: h40,
                  width: h40,
                );
              },
            ),
          ),
          title: pendentName ?? ksNA,
          titleTextStyle: semiBold14TextStyle(cBlackColor),
          borderColor: cPrimaryColor,
          itemColor: cPrimaryTint2Color,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "\$$pendentPrice",
                style: semiBold14TextStyle(cBlackColor),
              ),
            ],
          ),
        ),
        kH16sizedBox,
        Text(
          ksBenifits.tr,
          style: regular12TextStyle(cSmallBodyTextColor),
        ),
        kH8sizedBox,
        Text(
          pendentDescription ?? ksNA,
          style: regular12TextStyle(cBlackColor),
        ),
        //* Not needed now
        // kH20sizedBox,
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
                text: ksYouCanSendStarsFromYourBalanceAtAnyTime.tr,
                style: regular12TextStyle(cBlackColor),
              ),
              TextSpan(
                text: " ${ksLearnMoreAboutStars.tr}",
                style: regular12TextStyle(cPrimaryColor),
              ),
            ],
          ),
        ),
        kH12sizedBox,
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.translate(
                  offset: const Offset(-10.0, 0.0),
                  child: Checkbox(
                    value: Get.find<PendentBadgesController>().pendentCheckBox.value,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onChanged: (v) {
                      Get.find<PendentBadgesController>().pendentCheckBox.value = !Get.find<PendentBadgesController>().pendentCheckBox.value;
                    },
                  ),
                ),
                Transform.translate(
                  offset: const Offset(-8.0, 0.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: InkWell(
                            onTap: () {
                              Get.find<PendentBadgesController>().pendentCheckBox.value = !Get.find<PendentBadgesController>().pendentCheckBox.value;
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 0.8),
                              child: Text(
                                '${ksIAgreeWithThe.tr} ',
                                style: regular12TextStyle(cBlackColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        TextSpan(
                          text: ksTermsCondition.tr,
                          style: regular12TextStyle(cPrimaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
        kH16sizedBox,
        const CustomDivider(),
        kH16sizedBox,
        Obx(() => CustomElevatedButton(
            buttonHeight: h32,
            buttonWidth: width - 40,
            label: ksBuyPendent.tr,
            onPressed: Get.find<PendentBadgesController>().pendentCheckBox.value
                ? () {
                    Get.find<GlobalController>().commonBottomSheet(
                        context: context,
                        bottomSheetHeight: isDeviceScreenLarge() ? height * 0.55 : height * 0.65,
                        isScrollControlled: true,
                        content: PendentPurchasePaymentContent(
                          pendentName: pendentName,
                          pendentPrice: pendentPrice,
                        ),
                        onPressCloseButton: () {
                          Get.back();
                        },
                        onPressRightButton: () {},
                        rightText: '',
                        rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                        title: ksPayNow.tr,
                        isRightButtonShow: false);
                  }
                : null)),
      ],
    );
  }
}

class PendentGridViewContainer extends StatelessWidget {
  PendentGridViewContainer({
    super.key,
    required this.index,
    required this.recommendedOrAllPendentList,
    this.pendentIcon,
    this.pendentName,
    this.pendentPrice,
  });

  final int index;
  final List recommendedOrAllPendentList;
  final PendentBadgesController pendentBadgesController = Get.find<PendentBadgesController>();
  final String? pendentIcon;
  final String? pendentName;
  final String? pendentPrice;

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
                child: Image.network(
                  pendentIcon!,
                  fit: BoxFit.fill,
                  height: 48,
                  width: 48,
                  loadingBuilder: imageLoadingBuilder,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      kiProfileDefaultImageUrl,
                      height: h40,
                      width: h40,
                    );
                  },
                ),
              ),
              kH4sizedBox,
              Expanded(
                child: Text(
                  pendentName ?? ksNA,
                  style: semiBold14TextStyle(cBlackColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              kH4sizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    kiDollarSvgImageUrl, //! Here dollar icon import
                    width: h8,
                    height: h12,
                  ),
                  kW4sizedBox,
                  Text(
                    pendentPrice ?? ksNA,
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

class PendentPurchasePaymentContent extends StatelessWidget {
  PendentPurchasePaymentContent({super.key, this.pendentName, this.pendentPrice});
  final String? pendentName;
  final String? pendentPrice;
  final PendentBadgesController pendentBadgesController = Get.find<PendentBadgesController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Obx(() => Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 48,
                        height: 48,
                        child: SvgPicture.asset(
                          kiPayment,
                          width: h40,
                          height: h40,
                        ),
                      ),
                      kW12sizedBox,
                      kH8sizedBox,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pendentPrice ?? ksNA,
                            style: semiBold18TextStyle(cBlackColor),
                          ),
                          kH8sizedBox,
                          Text(
                            pendentName ?? ksNA,
                            style: regular14TextStyle(cPlaceHolderColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  kH16sizedBox,
                  const CustomDivider(),
                  kH16sizedBox,
                  CustomModifiedTextField(
                    controller: pendentBadgesController.cardNumberTextEditingController,
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
                          controller: pendentBadgesController.mmYYTextEditingController,
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
                          controller: pendentBadgesController.cvvTextEditingController,
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
                              value: pendentBadgesController.paymentCheckBox.value,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              onChanged: (v) {
                                pendentBadgesController.paymentCheckBox.value = !pendentBadgesController.paymentCheckBox.value;
                              },
                            ),
                          )),
                      kW12sizedBox,
                      Transform.translate(
                        offset: const Offset(-20.0, 0.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                  child: InkWell(
                                      onTap: () {
                                        pendentBadgesController.paymentCheckBox.value = !pendentBadgesController.paymentCheckBox.value;
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 0.8),
                                        child: Text('${ksIAgreeWithThe.tr} ', style: regular12TextStyle(cBlackColor)),
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
                      buttonHeight: h32,
                      buttonWidth: width - 40,
                      onPressed: pendentBadgesController.paymentCheckBox.value
                          ? () async {
                              Get.offNamedUntil(krPendentPage, ModalRoute.withName(krMenu));
                              pendentBadgesController.resetPendentData();
                              await pendentBadgesController.buyPendent();
                            }
                          : null)),
                ],
              ),
              if (pendentBadgesController.isBuyPendentLoading.value)
                Positioned(
                  child: CommonLoadingAnimation(
                    onWillPop: () async {
                      if (pendentBadgesController.isBuyPendentLoading.value) {
                        return false;
                      }
                      return true;
                    },
                  ),
                ),
            ],
          )),
    );
  }
}
