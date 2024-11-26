import 'dart:io';

import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/dashboard/dashboard_payouts/payout_settings/payout_manual_link_bank_account.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:flutter_svg/svg.dart';

class PayoutPassportVerification extends StatelessWidget {
  PayoutPassportVerification({super.key});
  final DashboardController dashboardController = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: cWhiteColor,
        child: Obx(
    () => Stack(
      children: [SafeArea(
        top: false,
        child: Scaffold(
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
                        ksPassportVerification.tr,
                        style: semiBold18TextStyle(cBlackColor),
                      ),
                      kH4sizedBox,
                      Text(
                        "${ksAddYourPassportInformation.tr}.",
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
                      Row(
                        children: [
                          Expanded(
                            child: CustomModifiedTextField(
                              hint: ksFirstName.tr,
                              fillColor: cWhiteColor,
                              controller: dashboardController.firstNameTextEditingController,
                              contentPadding: const EdgeInsets.all(k12Padding),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(k4BorderRadius),
                                borderSide: const BorderSide(width: 1, style: BorderStyle.solid, color: cLineColor2),
                              ),
                            ),
                          ),
                          kW16sizedBox,
                          Expanded(
                            child: CustomModifiedTextField(
                              hint: ksLastName.tr,
                              fillColor: cWhiteColor,
                              controller: dashboardController.lastNameTextEditingController,
                              contentPadding: const EdgeInsets.all(k12Padding),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(k4BorderRadius),
                                borderSide: const BorderSide(width: 1, style: BorderStyle.solid, color: cLineColor2),
                              ),
                            ),
                          ),
                        ],
                      ),
                      kH8sizedBox,
                      CustomModifiedTextField(
                        hint: ksPassportNumber.tr,
                        fillColor: cWhiteColor,
                        controller: dashboardController.passportNumberTextEditingController,
                        contentPadding: const EdgeInsets.all(k12Padding),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(k4BorderRadius),
                          borderSide: const BorderSide(width: 1, style: BorderStyle.solid, color: cLineColor2),
                        ),
                      ),
                      kH8sizedBox,
                      Row(
                        children: [
                          Expanded(
                            child: CustomModifiedTextField(
                              hint: ksIssueDate.tr,
                              fillColor: cWhiteColor,
                              controller: dashboardController.passportIssueDateTextEditingController,
                              errorText: dashboardController.passportIssueDateError.value,
                              contentPadding: const EdgeInsets.all(k12Padding),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(k4BorderRadius),
                                borderSide: const BorderSide(width: 1, style: BorderStyle.solid, color: cLineColor2),
                              ),
                              onChanged: (text){
                                dashboardController.passportIssueDateFormatValidation();
                              },
                            ),
                          ),
                          kW16sizedBox,
                          Expanded(
                            child: CustomModifiedTextField(
                              hint: ksEndDate.tr,
                              fillColor: cWhiteColor,
                              controller: dashboardController.passportEndDateTextEditingController,
                              errorText: dashboardController.passportEndDateError.value,
                              contentPadding: const EdgeInsets.all(k12Padding),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(k4BorderRadius),
                                borderSide: const BorderSide(width: 1, style: BorderStyle.solid, color: cLineColor2),
                              ),
                              onChanged: (text){
                                dashboardController.passportEndDateFormatValidation();
                              },
                            ),
                          ),
                        ],
                      ),
                      kH8sizedBox,
                      Text(
                        ksUploadPassportFirstInfoPage,
                        style: semiBold16TextStyle(cBlackColor),
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
                            content: PassportPictureUploadContent(
                              isImageUploaded: dashboardController.isPassportImageChanged,
                              imageLink: dashboardController.passportImageLink,
                              imageFile: dashboardController.passportImageFile,
                            ),
                          );
                        },
                        child: dashboardController.isPassportImageChanged.value
                            ? Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(k8BorderRadius),
                                    child: Container(
                                      width: width - 40,
                                      height: 140,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: FileImage(dashboardController.passportImageFile.value),
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
                                            dashboardController.isPassportImageChanged.value = false;
                                            dashboardController.passportImageLink.value = '';
                                            dashboardController.passportImageFile.value = File('');
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
                                    Text(
                                      ksFileSize10MBLimit,
                                      style: regular12TextStyle(cSmallBodyTextColor),
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
                        onPressed: dashboardController.passportImageFile.value.path.isNotEmpty
                            ? () async {
                          unFocus(context);
                          await dashboardController.uploadPassport();
                          // Get.back();
                        }
                            : null,
                        textStyle: semiBold16TextStyle(cWhiteColor),
                      ),
                      kH20sizedBox,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
        if (dashboardController.isPassportUploadLoading.value == true)
          Positioned(
            child: CommonLoadingAnimation(
              onWillPop: () async {
                if (dashboardController.isPassportUploadLoading.value) {
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

class PassportPictureUploadContent extends StatelessWidget {
  PassportPictureUploadContent({super.key, required this.isImageUploaded, this.imageLink, this.imageFile});
  final GlobalController globalController = Get.find<GlobalController>();
  final RxBool isImageUploaded;
  final dynamic imageLink, imageFile;
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
            await globalController.selectImageSource(isImageUploaded, imageLink, imageFile, 'camera', true);
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
            await globalController.selectImageSource(isImageUploaded, imageLink, imageFile, 'gallery', true);
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
