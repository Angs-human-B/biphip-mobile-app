import 'package:bip_hip/controllers/menu/pendent_badges_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:flutter_svg/svg.dart';

class PendentPage extends StatelessWidget {
  PendentPage({super.key});
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kH16sizedBox,
                  Text(
                    ksCurrentPendent.tr,
                    style: semiBold16TextStyle(cBlackColor),
                  ),
                  kH8sizedBox,
                  if (pendentBadgesController.currentPendent.value == "")
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
                  Container(
                    width: width - 40,
                    height: 108,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(k8BorderRadius),
                      border: Border.all(
                        color: cLineColor,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: k16Padding, top: k16Padding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Your current pendent is Crown",
                                style: regular14TextStyle(cBlackColor),
                              ),
                              kH4sizedBox,
                              Text(
                                "Purchased on: 14 Sep 2023",
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
                                      onPressed: () {}),
                                  kW12sizedBox,
                                  CustomElevatedButton(
                                      buttonWidth: 70,
                                      buttonHeight: h24,
                                      borderColor: cPrimaryColor,
                                      buttonColor: cWhiteColor,
                                      label: ksHistory.tr,
                                      textStyle: semiBold12TextStyle(cPrimaryColor),
                                      onPressed: () {}),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: k16Padding),
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  kiPendentSvgImageUrl,
                                  width: h44,
                                  height: h44,
                                ),
                                kH8sizedBox,
                                Text(
                                  "CROWN",
                                  style: semiBold14TextStyle(cBlackColor),
                                ),
                              ],
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
                      itemCount: pendentBadgesController.pendentPackages.length,
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
                            pendentBadgesController.selectedPendentIndex.value = index;
                          },
                          child: PendentGridViewContainer(
                            index: index,
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
                        Get.find<GlobalController>().commonBottomSheet(
                          context: context,
                          bottomSheetHeight: height * 0.6,
                          content: PurchasePendentBottomSheetContent(),
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

class PurchasePendentBottomSheetContent extends StatelessWidget {
  const PurchasePendentBottomSheetContent({super.key});

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
          leading: SvgPicture.asset(
            kiPendentSvgImageUrl,
            width: 20,
            height: 20,
          ),
          title: "CROWN",
          titleTextStyle: semiBold14TextStyle(cBlackColor),
          borderColor: cPrimaryColor,
          itemColor: cPrimaryTint2Color,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // if (postReactionController.balance < int.parse(postReactionController.selectedPackage.value!['amount']) ||
              //     (postReactionController.totalStars.value != '' && postReactionController.balance < int.parse(postReactionController.totalStars.value)))
              Text(
                "\$20.00",
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
          "Pendent that you purchase here are kept in your balance. You can send stars from your balance at any time. Pendent that you purchase here are kept in your balance. You can send stars from your balance at any time.",
          style: regular12TextStyle(cBlackColor),
        ),
        kH20sizedBox,
        Row(
          children: [
            // Text("."),
            Text("Pendent that you purchase here are kept in your balance."),
          ],
        ),
        kH4sizedBox,
        Text("You can send stars from your balance at any time."),
        kH4sizedBox,
        Text("Pendent that you purchase here are kept in your balance."),
        kH16sizedBox,
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "${ksYouCanSendStarsFromYourBalanceAtAnyTime.tr}",
                style: regular12TextStyle(cBlackColor),
              ),
              TextSpan(
                text: ksLearnMoreAboutStars.tr,
                style: regular12TextStyle(cPrimaryColor),
              ),
            ],
          ),
        ),
        Obx(() => Row(
              children: [
                Checkbox(
                  value: Get.find<PendentBadgesController>().pendentCheckBox.value,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onChanged: (v) {
                    Get.find<PendentBadgesController>().pendentCheckBox.value = !Get.find<PendentBadgesController>().pendentCheckBox.value;
                  },
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: InkWell(
                          onTap: () {
                            Get.find<PendentBadgesController>().pendentCheckBox.value = !Get.find<PendentBadgesController>().pendentCheckBox.value;
                          },
                          child: Text(
                            ksIAgreeWithThe.tr,
                            style: regular12TextStyle(cBlackColor),
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
              ],
            )),
        kH16sizedBox,
        const CustomDivider(),
        kH16sizedBox,
        CustomElevatedButton(
            label: ksBuyPendent.tr,
            onPressed: () {
              Get.find<GlobalController>().commonBottomSheet(
                  context: context,
                  bottomSheetHeight: isDeviceScreenLarge() ? height * 0.6 : height * 0.7,
                  isScrollControlled: true,
                  content: PendentPurchasePaymentContent(),
                  onPressCloseButton: () {
                    Get.back();
                  },
                  onPressRightButton: () {},
                  rightText: '',
                  rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                  title: ksPayNow.tr,
                  isRightButtonShow: false);
            }),
      ],
    );
  }
}

class PendentGridViewContainer extends StatelessWidget {
  PendentGridViewContainer({
    super.key,
    required this.index,
  });

  final int index;
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
                  pendentBadgesController.pendentPackages[index]['pendent'],
                  fit: BoxFit.fill,
                ),
              ),
              kH4sizedBox,
              Expanded(
                child: Text(
                  pendentBadgesController.pendentPackages[index]['packageName'],
                  style: semiBold14TextStyle(cBlackColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              kH4sizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const Icon(
                  //   BipHip.d,
                  //   color: cSecondaryColor,
                  //   size: kIconSize12,
                  // ),
                  kW4sizedBox,
                  Text(
                    pendentBadgesController.pendentPackages[index]['cost'],
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
  PendentPurchasePaymentContent({super.key});
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
                  '\$105.00',
                  style: semiBold18TextStyle(cBlackColor),
                ),
                kH4sizedBox,
                Text(
                  '1000 stars',
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
              offset: const Offset(-20, 0.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                        child: InkWell(
                            onTap: () {
                              pendentBadgesController.paymentCheckBox.value = !pendentBadgesController.paymentCheckBox.value;
                            },
                            child: Text('${ksIAgreeWith.tr} ', style: regular12TextStyle(cBlackColor)))),
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
            onPressed: pendentBadgesController.paymentCheckBox.value
                ? () {
                    Get.offAllNamed(krHome);
                  }
                : null)),
      ],
    );
  }
}
