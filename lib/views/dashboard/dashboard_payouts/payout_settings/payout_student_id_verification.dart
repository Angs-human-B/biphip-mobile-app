import 'dart:io';

import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/dashboard/dashboard_payouts/payout_settings/payout_manual_link_bank_account.dart';
import 'package:bip_hip/views/dashboard/dashboard_payouts/payout_settings/payout_passport_verification.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:flutter_svg/svg.dart';

class PayoutStudentIdVerification extends StatelessWidget {
  PayoutStudentIdVerification({super.key});
  final DashboardController dashboardController =
      Get.find<DashboardController>();
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
                    height: height -
                        (kAppBarSize +
                            MediaQuery.of(context).padding.top +
                            MediaQuery.of(context).padding.bottom),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kHorizontalPadding),
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            kH16sizedBox,
                            Text(
                              ksStudentIdVerification.tr,
                              style: semiBold18TextStyle(cBlackColor),
                            ),
                            kH4sizedBox,
                            Text(
                              "${ksAddYourStudentIdInformation.tr}.",
                              style: regular14TextStyle(cSmallBodyTextColor),
                            ),
                            kH16sizedBox,
                            const CustomDivider(),
                            kH16sizedBox,
                            InkWell(
                              onTap: () {
                                dashboardController
                                        .temporarySelectedCountry.value =
                                    dashboardController.selectedCountry.value;
                                if (dashboardController
                                        .temporarySelectedCountry.value ==
                                    "") {
                                  dashboardController
                                      .dashboardPayoutCountryRightButtonState
                                      .value = false;
                                } else {
                                  dashboardController
                                      .dashboardPayoutCountryRightButtonState
                                      .value = true;
                                }
                                Get.find<GlobalController>().commonBottomSheet(
                                    context: context,
                                    content: CountryBottomSheetContent(),
                                    onPressCloseButton: () {
                                      Get.back();
                                    },
                                    onPressRightButton: () {
                                      dashboardController
                                              .selectedCountry.value =
                                          dashboardController
                                              .temporarySelectedCountry.value;
                                      Get.back();
                                    },
                                    rightText: ksDone.tr,
                                    rightTextStyle:
                                        semiBold16TextStyle(cPrimaryColor),
                                    title: ksCountry.tr,
                                    isRightButtonShow: true,
                                    isBottomSheetRightButtonActive:
                                        dashboardController
                                            .dashboardPayoutCountryRightButtonState);
                              },
                              child: Container(
                                width: width - 40,
                                height: h50,
                                decoration: BoxDecoration(
                                  color: cWhiteColor,
                                  borderRadius:
                                      BorderRadius.circular(k4BorderRadius),
                                  border:
                                      Border.all(color: cLineColor2, width: 1),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(k12Padding),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        dashboardController
                                                    .selectedCountry.value ==
                                                ""
                                            ? ksCountry.tr
                                            : dashboardController
                                                .selectedCountry.value,
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
                            InkWell(
                              onTap: () {
                                dashboardController
                                        .temporarySelectedSchool.value =
                                    dashboardController.selectedSchool.value;
                                if (dashboardController
                                        .temporarySelectedSchool.value ==
                                    "") {
                                  dashboardController
                                      .payoutStudentSchoolRightButtonState
                                      .value = false;
                                } else {
                                  dashboardController
                                      .payoutStudentSchoolRightButtonState
                                      .value = true;
                                }
                                Get.find<GlobalController>().commonBottomSheet(
                                    context: context,
                                    content: SchoolBottomSheetContent(),
                                    onPressCloseButton: () {
                                      Get.back();
                                    },
                                    onPressRightButton: () {
                                      dashboardController.selectedSchool.value =
                                          dashboardController
                                              .temporarySelectedSchool.value;
                                      Get.back();
                                    },
                                    rightText: ksDone.tr,
                                    rightTextStyle:
                                        semiBold16TextStyle(cPrimaryColor),
                                    title: ksCountry.tr,
                                    isRightButtonShow: true,
                                    isBottomSheetRightButtonActive:
                                        dashboardController
                                            .payoutStudentSchoolRightButtonState);
                              },
                              child: Container(
                                width: width - 40,
                                height: h50,
                                decoration: BoxDecoration(
                                  color: cWhiteColor,
                                  borderRadius:
                                      BorderRadius.circular(k4BorderRadius),
                                  border:
                                      Border.all(color: cLineColor2, width: 1),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(k12Padding),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        dashboardController
                                                    .selectedSchool.value ==
                                                ""
                                            ? ksSchool.tr
                                            : dashboardController
                                                .selectedSchool.value,
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
                                    controller: dashboardController
                                        .firstNameTextEditingController,
                                    contentPadding:
                                        const EdgeInsets.all(k12Padding),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(k4BorderRadius),
                                      borderSide: const BorderSide(
                                          width: 1,
                                          style: BorderStyle.solid,
                                          color: cLineColor2),
                                    ),
                                  ),
                                ),
                                kW16sizedBox,
                                Expanded(
                                  child: CustomModifiedTextField(
                                    hint: ksLastName.tr,
                                    fillColor: cWhiteColor,
                                    controller: dashboardController
                                        .lastNameTextEditingController,
                                    contentPadding:
                                        const EdgeInsets.all(k12Padding),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(k4BorderRadius),
                                      borderSide: const BorderSide(
                                          width: 1,
                                          style: BorderStyle.solid,
                                          color: cLineColor2),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            kH8sizedBox,
                            CustomModifiedTextField(
                              hint: ksStudentId.tr,
                              fillColor: cWhiteColor,
                              controller: dashboardController
                                  .studentIdTextEditingController,
                              contentPadding: const EdgeInsets.all(k12Padding),
                              inputType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(k4BorderRadius),
                                borderSide: const BorderSide(
                                    width: 1,
                                    style: BorderStyle.solid,
                                    color: cLineColor2),
                              ),
                            ),
                            kH8sizedBox,
                            Text(
                              ksUploadStudentIdFrontAndBackImage.tr,
                              style: semiBold16TextStyle(cBlackColor),
                            ),
                            kH8sizedBox,
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    unFocus(context);
                                    Get.find<GlobalController>()
                                        .commonBottomSheet(
                                      context: context,
                                      onPressCloseButton: () {
                                        Get.back();
                                      },
                                      onPressRightButton: () {},
                                      rightText: '',
                                      rightTextStyle:
                                          regular14TextStyle(cBiddingColor),
                                      title: ksUploadPhoto.tr,
                                      isRightButtonShow: false,
                                      isScrollControlled: false,
                                      bottomSheetHeight: 180,
                                      content: PassportPictureUploadContent(
                                        isImageUploaded: dashboardController
                                            .isStudentIdFrontImageChanged,
                                        imageLink: dashboardController
                                            .studentIdFrontImageLink,
                                        imageFile: dashboardController
                                            .studentIdFrontImageFile,
                                      ),
                                    );
                                  },
                                  child: dashboardController
                                          .isStudentIdFrontImageChanged.value
                                      ? Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      k8BorderRadius),
                                              child: Container(
                                                width: (width - 56) / 2,
                                                height: 140,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: FileImage(
                                                        dashboardController
                                                            .studentIdFrontImageFile
                                                            .value),
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
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: cRedColor,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Center(
                                                      child: CustomIconButton(
                                                    onPress: () {
                                                      dashboardController
                                                          .isStudentIdFrontImageChanged
                                                          .value = false;
                                                      dashboardController
                                                          .studentIdFrontImageLink
                                                          .value = '';
                                                      dashboardController
                                                          .studentIdFrontImageFile
                                                          .value = File('');
                                                    },
                                                    icon: BipHip.cross,
                                                    iconColor: cWhiteColor,
                                                    size: kIconSize14,
                                                  )),
                                                )),
                                          ],
                                        )
                                      : Container(
                                          width: (width - 56) / 2,
                                          height: 140,
                                          decoration: BoxDecoration(
                                            color: cInputFieldColor,
                                            borderRadius: BorderRadius.circular(
                                                k8BorderRadius),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                kiUploadImage,
                                                height: 40,
                                              ),
                                              kH8sizedBox,
                                              Text(
                                                ksStudentIdFrontPage.tr,
                                                style: semiBold16TextStyle(
                                                    cPrimaryColor),
                                              ),
                                              Text(
                                                ksFileSize10MBLimit,
                                                style: regular12TextStyle(
                                                    cSmallBodyTextColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                ),
                                kW16sizedBox,
                                InkWell(
                                  onTap: () {
                                    unFocus(context);
                                    Get.find<GlobalController>()
                                        .commonBottomSheet(
                                      context: context,
                                      onPressCloseButton: () {
                                        Get.back();
                                      },
                                      onPressRightButton: () {},
                                      rightText: '',
                                      rightTextStyle:
                                          regular14TextStyle(cBiddingColor),
                                      title: ksUploadPhoto.tr,
                                      isRightButtonShow: false,
                                      isScrollControlled: false,
                                      bottomSheetHeight: 180,
                                      content: PassportPictureUploadContent(
                                        isImageUploaded: dashboardController
                                            .isStudentIdBackImageChanged,
                                        imageLink: dashboardController
                                            .studentIdBackImageLink,
                                        imageFile: dashboardController
                                            .studentIdBackImageFile,
                                      ),
                                    );
                                  },
                                  child: dashboardController
                                          .isStudentIdBackImageChanged.value
                                      ? Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      k8BorderRadius),
                                              child: Container(
                                                width: (width - 56) / 2,
                                                height: 140,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: FileImage(
                                                        dashboardController
                                                            .studentIdBackImageFile
                                                            .value),
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
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: cRedColor,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Center(
                                                      child: CustomIconButton(
                                                    onPress: () {
                                                      dashboardController
                                                          .isStudentIdBackImageChanged
                                                          .value = false;
                                                      dashboardController
                                                          .studentIdBackImageLink
                                                          .value = '';
                                                      dashboardController
                                                          .studentIdBackImageFile
                                                          .value = File('');
                                                    },
                                                    icon: BipHip.cross,
                                                    iconColor: cWhiteColor,
                                                    size: kIconSize14,
                                                  )),
                                                )),
                                          ],
                                        )
                                      : Container(
                                          width: (width - 56) / 2,
                                          height: 140,
                                          decoration: BoxDecoration(
                                            color: cInputFieldColor,
                                            borderRadius: BorderRadius.circular(
                                                k8BorderRadius),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                kiUploadImage,
                                                height: 40,
                                              ),
                                              kH8sizedBox,
                                              Text(
                                                ksStudentIdBackPage.tr,
                                                style: semiBold16TextStyle(
                                                    cPrimaryColor),
                                              ),
                                              Text(
                                                ksFileSize10MBLimit,
                                                style: regular12TextStyle(
                                                    cSmallBodyTextColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                ),
                              ],
                            ),
                            const Expanded(child: SizedBox()),
                            CustomElevatedButton(
                              buttonWidth: width - 40,
                              buttonHeight: h32,
                              label: ksAdd.tr,
                              onPressed: dashboardController.studentIdFrontImageFile
                                  .value.path.isNotEmpty &&
                                  dashboardController.studentIdBackImageFile.value
                                      .path.isNotEmpty
                                  ? () async {
                                unFocus(context);
                                await dashboardController.uploadStudentId();
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
            if (dashboardController.isStudentIdUploadLoading.value == true)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (dashboardController.isStudentIdUploadLoading.value) {
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

class SchoolBottomSheetContent extends StatelessWidget {
  SchoolBottomSheetContent({super.key});
  final DashboardController dashboardController =
      Get.find<DashboardController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, index) => kH8sizedBox,
          itemCount: dashboardController.schoolList.length,
          itemBuilder: (context, index) {
            return Obx(() => CustomListTile(
                  onPressed: () {
                    dashboardController.temporarySelectedSchool.value =
                        dashboardController.schoolList[index];
                    if (dashboardController.temporarySelectedSchool.value ==
                        "") {
                      dashboardController
                          .payoutStudentSchoolRightButtonState.value = false;
                    } else {
                      dashboardController
                          .payoutStudentSchoolRightButtonState.value = true;
                    }
                  },
                  itemColor:
                      dashboardController.temporarySelectedSchool.value ==
                              dashboardController.schoolList[index]
                          ? cPrimaryTint3Color
                          : cWhiteColor,
                  borderColor:
                      dashboardController.temporarySelectedSchool.value ==
                              dashboardController.schoolList[index]
                          ? cPrimaryColor
                          : cLineColor,
                  title: dashboardController.schoolList[index],
                ));
          },
        ),
      ],
    );
  }
}
