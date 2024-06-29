import 'dart:io';

import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/dashboard/dashboard_payouts/payout_settings/payout_manual_link_bank_account.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:flutter_svg/svg.dart';

class PayoutTaxInfo extends StatelessWidget {
  PayoutTaxInfo({super.key});
  final DashboardController dashboardController = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cWhiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kAppBarSize),
        //* info:: appBar
        child: CustomAppBar(
          title: ksPayouts.tr,
          hasBackButton: true,
          isCenterTitle: true,
          onBack: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: height - (kAppBarSize + MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kH16sizedBox,
                  Text(
                    ksEnterTaxInfo.tr,
                    style: semiBold18TextStyle(cBlackColor),
                  ),
                  kH4sizedBox,
                  Text(
                    ksElevateBusinessImageAndDocument.tr,
                    style: regular14TextStyle(cSmallBodyTextColor),
                  ),
                  kH16sizedBox,
                  const CustomDivider(),
                  kH16sizedBox,
                  InkWell(
                    onTap: () {
                      dashboardController.temporarySelectedCountry.value = dashboardController.selectedCountry.value;
                      if (dashboardController.temporarySelectedCountry.value == "") {
                        dashboardController.dashboardPayoutCountryRightButtonState.value = false;
                      } else {
                        dashboardController.dashboardPayoutCountryRightButtonState.value = true;
                      }
                      Get.find<GlobalController>().commonBottomSheet(
                          context: context,
                          content: CountryBottomSheetContent(),
                          onPressCloseButton: () {
                            Get.back();
                          },
                          onPressRightButton: () {
                            dashboardController.selectedCountry.value = dashboardController.temporarySelectedCountry.value;
                            Get.back();
                          },
                          rightText: ksDone.tr,
                          rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                          title: ksCountry.tr,
                          isRightButtonShow: true,
                          isBottomSheetRightButtonActive: dashboardController.dashboardPayoutCountryRightButtonState);
                    },
                    child: Container(
                      width: width - 40,
                      height: h50,
                      decoration: BoxDecoration(
                        color: cWhiteColor,
                        borderRadius: BorderRadius.circular(k4BorderRadius),
                        border: Border.all(color: cLineColor2, width: 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(k12Padding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              dashboardController.selectedCountry.value == "" ? ksCountry.tr : dashboardController.selectedCountry.value,
                              style: regular14TextStyle(cBlackColor),
                            ),
                            const Icon(
                              BipHip.downArrow,
                              color: cIconColor,
                              size: kIconSize20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  kH16sizedBox,
                  CustomModifiedTextField(
                    hint: kaName.tr,
                    fillColor: cWhiteColor,
                    controller: dashboardController.nameTextEditingController,
                    contentPadding: const EdgeInsets.all(k12Padding),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(k4BorderRadius),
                      borderSide: const BorderSide(width: 1, style: BorderStyle.solid, color: cLineColor2),
                    ),
                  ),
                  kH8sizedBox,
                  CustomModifiedTextField(
                    hint: ksTaxId.tr,
                    fillColor: cWhiteColor,
                    controller: dashboardController.taxIdTextEditingController,
                    inputType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    contentPadding: const EdgeInsets.all(k12Padding),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(k4BorderRadius),
                      borderSide: const BorderSide(width: 1, style: BorderStyle.solid, color: cLineColor2),
                    ),
                  ),
                  kH16sizedBox,
                  Text(
                    ksUploadTinCertificate.tr,
                    style: semiBold16TextStyle(cBlackColor),
                  ),
                  kH8sizedBox,
                  Text(
                    "${ksUploadTinCertificateImage.tr}.",
                    style: regular14TextStyle(cSmallBodyTextColor),
                  ),
                  kH8sizedBox,
                  InkWell(
                    onTap: () {
                      unFocus(context);
                      Get.find<GlobalController>().commonBottomSheet(
                        context: context,
                        onPressCloseButton: () {
                          Get.back();
                        },
                        onPressRightButton: () {},
                        rightText: '',
                        rightTextStyle: regular14TextStyle(cBiddingColor),
                        title: ksUploadPhoto.tr,
                        isRightButtonShow: false,
                        isScrollControlled: false,
                        bottomSheetHeight: 180,
                        content: TinCertificatePictureUploadContent(),
                      );
                    },
                    child: dashboardController.isTinImageChanged.value
                        ? Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(k8BorderRadius),
                                child: Container(
                                  width: width - 40,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(dashboardController.tinImageFile.value),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Container(
                                    width: h20,
                                    height: h20,
                                    decoration: const BoxDecoration(
                                      color: cRedColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                        child: CustomIconButton(
                                      onPress: () {
                                        dashboardController.isTinImageChanged.value = false;
                                        dashboardController.tinImageLink.value = '';
                                        dashboardController.tinImageFile.value = File('');
                                      },
                                      icon: BipHip.cross,
                                      iconColor: cWhiteColor,
                                      size: kIconSize14,
                                    )),
                                  )),
                            ],
                          )
                        : Container(
                            width: width - 40,
                            height: 140,
                            decoration: BoxDecoration(
                              color: cInputFieldColor,
                              borderRadius: BorderRadius.circular(k8BorderRadius),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  kiUploadImage,
                                  height: 40,
                                ),
                                kH8sizedBox,
                                Text(
                                  ksUploadImage,
                                  style: semiBold16TextStyle(cPrimaryColor),
                                ),
                              ],
                            ),
                          ),
                  ),
                  const Expanded(child: SizedBox()),
                  CustomElevatedButton(
                    buttonWidth: width - 40,
                    buttonHeight: h32,
                    label: ksAdd.tr,
                    onPressed: () {
                      unFocus(context);
                    },
                    textStyle: semiBold16TextStyle(cWhiteColor),
                  ),
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

class TinCertificatePictureUploadContent extends StatelessWidget {
  TinCertificatePictureUploadContent({super.key});
  final DashboardController dashboardController = Get.find<DashboardController>();
  final GlobalController globalController = Get.find<GlobalController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomElevatedButton(
          label: ksAddPhoto.tr,
          prefixIcon: BipHip.camera,
          prefixIconColor: cIconColor,
          suffixIconColor: cIconColor,
          onPressed: () async {
            await globalController.selectImageSource(
                dashboardController.isTinImageChanged, dashboardController.tinImageLink, dashboardController.tinImageFile, 'camera', true);
          },
          buttonHeight: h32,
          buttonWidth: width - 40,
          buttonColor: cWhiteColor,
          borderColor: cLineColor,
          textStyle: semiBold14TextStyle(cBlackColor),
        ),
        kH16sizedBox,
        CustomElevatedButton(
          label: ksChooseFromGallery.tr,
          prefixIcon: BipHip.photo,
          prefixIconColor: cIconColor,
          suffixIconColor: cIconColor,
          onPressed: () async {
            await globalController.selectImageSource(
                dashboardController.isTinImageChanged, dashboardController.tinImageLink, dashboardController.tinImageFile, 'gallery', true);
          },
          buttonHeight: h32,
          buttonWidth: width - 40,
          buttonColor: cWhiteColor,
          borderColor: cLineColor,
          textStyle: semiBold14TextStyle(cBlackColor),
        ),
      ],
    );
  }
}
