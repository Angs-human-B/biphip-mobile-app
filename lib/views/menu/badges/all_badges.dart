import 'package:bip_hip/controllers/menu/pendent_badges_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/badges/badges_star_page.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';

class AllBadges extends StatelessWidget {
  AllBadges({super.key});
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kH16sizedBox,
                Text(
                  ksAllBadges.tr,
                  style: semiBold16TextStyle(cBlackColor),
                ),
                kH16sizedBox,
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: giftPackages.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: isDeviceScreenLarge() ? 0.95 : 1,
                            crossAxisCount: 3,
                            crossAxisSpacing: k16Padding,
                            mainAxisSpacing: k16Padding,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                pendentBadgesController.selectedPackage.value = giftPackages[index];
                                pendentBadgesController.isPackageSelected.value = true;
                                pendentBadgesController.selectedBadgeIndex.value = index;
                                pendentBadgesController.selectedBadgeIndex.value = -1;
                                pendentBadgesController.badgesCheckBox.value = false;
                                pendentBadgesController.badgesPaymentCheckBox.value = false;
                                Get.toNamed(krPurchaseStar);
                              },
                              child: BadgesGridViewContainer(
                                index: index,
                                recommendedOrAllBadgesList: giftPackages,
                              ),
                            );
                          },
                        ),
                      ],
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

class PurchaseCustomStarContent extends StatelessWidget {
  PurchaseCustomStarContent({super.key});
  final PendentBadgesController pendentBadgesController = Get.find<PendentBadgesController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  BipHip.giftNew,
                  color: cSecondaryColor,
                  size: kIconSize50,
                ),
                kW12sizedBox,
                kH8sizedBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$${pendentBadgesController.temporarytotalStarBuyAmount.value.toStringAsFixed(2)}',
                      style: semiBold18TextStyle(cBlackColor),
                    ),
                    kH4sizedBox,
                    Text(
                      pendentBadgesController.starAmountTextEditingController.text.toString().trim() == ''
                          ? '0 ${ksStarNew.tr}'
                          : '${pendentBadgesController.starAmountTextEditingController.text} ${ksStars.tr}',
                      style: semiBold14TextStyle(cPlaceHolderColor),
                    ),
                  ],
                ),
              ],
            ),
            kH16sizedBox,
            const CustomDivider(),
            kH16sizedBox,
            CustomModifiedTextField(
              controller: pendentBadgesController.starAmountTextEditingController,
              hint: ksAmountOfStar.tr,
              onChanged: (text) {
                if (pendentBadgesController.starAmountTextEditingController.text.toString().trim() != '' &&
                    pendentBadgesController.starAmountTextEditingController.text.toString().trim() != '0') {
                  pendentBadgesController.isStarAmountConfirmButtonEnabled.value = true;
                  pendentBadgesController.temporarytotalStarBuyAmount.value =
                      (double.parse(pendentBadgesController.starAmountTextEditingController.text.toString()) * pendentBadgesController.perStarAmount.value);
                  pendentBadgesController.temporaryTotalStars.value = pendentBadgesController.starAmountTextEditingController.text.toString().trim();
                } else {
                  pendentBadgesController.isStarAmountConfirmButtonEnabled.value = false;
                  pendentBadgesController.temporarytotalStarBuyAmount.value = 0;
                }
              },
              onSubmit: (text) {},
              inputAction: TextInputAction.done,
              inputType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 10,
              fillColor: cWhiteColor,
              border: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: cLineColor2,
                  width: 1.0,
                ),
              ),
            ),
            RichText(
              textAlign: TextAlign.left,
              overflow: TextOverflow.clip,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: ksYouWillPay.tr,
                    style: regular10TextStyle(cIconColor),
                  ),
                  TextSpan(
                    text: ' ${pendentBadgesController.perStarAmount.value}\$ ',
                    style: regular10TextStyle(cGreenColor),
                  ),
                  TextSpan(
                    text: ksForEveryStar.tr,
                    style: regular10TextStyle(cIconColor),
                  ),
                ],
              ),
            ),
            kH16sizedBox,
            const CustomDivider(),
            kH16sizedBox,
            Obx(() => CustomElevatedButton(
                  buttonWidth: width - 40,
                  label: ksConfirm.tr,
                  onPressed: pendentBadgesController.isStarAmountConfirmButtonEnabled.value
                      ? () {
                          pendentBadgesController.totalStarBuyAmount.value = pendentBadgesController.temporarytotalStarBuyAmount.value;
                          pendentBadgesController.totalStars.value = pendentBadgesController.temporaryTotalStars.value;
                          pendentBadgesController.selectedBadgeIndex.value = -1;
                          pendentBadgesController.selectedPackage.value = null;
                          pendentBadgesController.isPackageSelected.value = false;
                          Get.back();
                        }
                      : null,
                  textStyle: semiBold14TextStyle(cWhiteColor),
                )),
          ],
        ));
  }
}
