import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/post/create_post.dart';
import 'package:bip_hip/widgets/common/button/custom_outline_button.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:bip_hip/widgets/common/utils/custom_circular_progress_bar.dart';

class AddKidBasicInfo extends StatelessWidget {
  AddKidBasicInfo({super.key});
  final KidsController kidsController = Get.find<KidsController>();
  final GlobalController globalController = Get.find<GlobalController>();
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
              appBarColor: cWhiteColor,
              title: ksAddKid.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                unFocus(context);
                Get.back();
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const CustomDivider(
                  thickness: 1,
                ),
                KidTopTitleSubtitleAndCircularProgressBar(
                  title: ksBasicInfo.tr,
                  subTitle: ksOtherKnowAboutYourKid.tr,
                  circularCenterText: ks1of4.tr,
                  percent: 0.25,
                ),
                kH16sizedBox,
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                  child: CustomDivider(
                    thickness: 1,
                  ),
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding).copyWith(top: k16Padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomModifiedTextField(
                          controller: kidsController.kidNameTextEditingController,
                          hint: ksWriteKidName.tr,
                          errorText: kidsController.kidNameErrorText.value,
                          onChanged: (text) {
                            kidsController.kidNameOnChanged();
                          },
                          onSubmit: (text) {},
                          inputAction: TextInputAction.next,
                          inputType: TextInputType.text,
                          maxLength: 50,
                        ),
                        kH8sizedBox,
                        TextAndIconRowSellingPost(
                          text: kidsController.selectedKidRelation.value == '' ? ksSelectRelation.tr : kidsController.selectedKidRelation.value,
                          textStyle: regular16TextStyle(kidsController.selectedKidRelation.value == '' ? cPlaceHolderColor : cBlackColor),
                          suffixIcon: BipHip.downArrow,
                          onPressed: () {
                            kidsController.tempSelectedKidRelation.value = kidsController.selectedKidRelation.value;
                            if (kidsController.tempSelectedKidRelation.value == '') {
                              globalController.isBottomSheetRightButtonActive.value = false;
                            } else {
                              globalController.isBottomSheetRightButtonActive.value = true;
                            }
                            globalController.commonBottomSheet(
                                context: context,
                                bottomSheetHeight: isDeviceScreenLarge() ? height * 0.5 : height * 0.6,
                                content: KidRelationContent(),
                                onPressCloseButton: () {
                                  Get.back();
                                },
                                onPressRightButton: () {
                                  kidsController.selectedKidRelation.value = kidsController.tempSelectedKidRelation.value;
                                  Get.back();
                                },
                                rightText: ksDone.tr,
                                rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                                title: ksSelectRelation.tr,
                                isRightButtonShow: true);
                          },
                        ),
                        kH16sizedBox,
                        CustomModifiedTextField(
                          controller: kidsController.kidAgeTextEditingController,
                          hint: ksWriteAge.tr,
                          errorText: kidsController.kidAgeErrorText.value,
                          onChanged: (text) {
                            kidsController.kidAgeOnChanged();
                          },
                          onSubmit: (text) {},
                          inputAction: TextInputAction.done,
                          inputType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          maxLength: 3,
                        ),
                        kH8sizedBox,
                        TextAndIconRowSellingPost(
                          text: kidsController.selectedKidGender.value == '' ? ksSelectGender.tr : kidsController.selectedKidGender.value,
                          textStyle: regular16TextStyle(kidsController.selectedKidGender.value == '' ? cPlaceHolderColor : cBlackColor),
                          suffixIcon: BipHip.downArrow,
                          onPressed: () {
                            kidsController.tempSelectedKidGender.value = kidsController.selectedKidGender.value;
                            if (kidsController.tempSelectedKidGender.value == '') {
                              globalController.isBottomSheetRightButtonActive.value = false;
                            } else {
                              globalController.isBottomSheetRightButtonActive.value = true;
                            }
                            globalController.commonBottomSheet(
                                context: context,
                                bottomSheetHeight: height * 0.4,
                                content: KidGenderContent(),
                                onPressCloseButton: () {
                                  Get.back();
                                },
                                onPressRightButton: () {
                                  kidsController.selectedKidGender.value = kidsController.tempSelectedKidGender.value;
                                  Get.back();
                                },
                                rightText: ksDone.tr,
                                rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                                title: ksSelectGender.tr,
                                isRightButtonShow: true);
                          },
                        ),
                        kH16sizedBox,
                        CustomModifiedTextField(
                          controller: kidsController.kidSchoolNameTextEditingController,
                          hint: ksWriteSchoolName.tr,
                          onChanged: (text) {
                            kidsController.checkNextButtonEnable();
                          },
                          onSubmit: (text) {},
                          inputAction: TextInputAction.done,
                          inputType: TextInputType.text,
                          maxLength: 50,
                        ),
                      ],
                    ),
                  ),
                ),
                kH100sizedBox,
                Obx(() => CustomElevatedButton(
                      buttonWidth: width - 40,
                      buttonHeight: h40,
                      label: ksNext.tr,
                      onPressed: kidsController.isNextButtonEnabled.value
                          ? () {
                              unFocus(context);
                              // kidsController.kidParentEmailController.text = Get.find<ProfileController>().userData.value!.email.toString();
                              // kidsController.kidParentPhoneController.text = Get.find<ProfileController>().userData.value!.phone.toString();
                              Get.toNamed(krAddKidContactInfo);
                            }
                          : null,
                      textStyle: semiBold16TextStyle(cWhiteColor),
                    )),
                kH30sizedBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class KidTopTitleSubtitleAndCircularProgressBar extends StatelessWidget {
  const KidTopTitleSubtitleAndCircularProgressBar(
      {super.key, required this.title, required this.subTitle, required this.circularCenterText, required this.percent});
  final String title;
  final String subTitle;
  final String circularCenterText;
  final double percent;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding).copyWith(top: k16Padding),
      child: LimitedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: semiBold18TextStyle(cBlackColor),
                ),
                kH4sizedBox,
                Text(
                  subTitle,
                  style: regular14TextStyle(cSmallBodyTextColor),
                ),
              ],
            ),
            CustomCircularProgressBar(
              percent: percent,
              radius: h32,
              lineWidth: 5,
              centerWidget: Text(
                circularCenterText,
                style: regular16TextStyle(cBlackColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class KidRelationContent extends StatelessWidget {
  KidRelationContent({super.key});
  final KidsController kidsController = Get.find<KidsController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: kidsController.kidRelationList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: k12Padding),
                child: Obx(() => OutLinedButton(
                      onPress: () {
                        kidsController.tempSelectedKidRelation.value = kidsController.kidRelationList[index].toString();
                        if (kidsController.tempSelectedKidRelation.value == '') {
                          Get.find<GlobalController>().isBottomSheetRightButtonActive.value = false;
                        } else {
                          Get.find<GlobalController>().isBottomSheetRightButtonActive.value = true;
                        }
                      },
                      buttonText: kidsController.kidRelationList[index].toString(),
                      buttonTextStyle: regular16TextStyle(cBlackColor),
                      borderColor:
                          kidsController.tempSelectedKidRelation.value == kidsController.kidRelationList[index].toString() ? cPrimaryColor : cLineColor2,
                      buttonColor:
                          kidsController.tempSelectedKidRelation.value == kidsController.kidRelationList[index].toString() ? cPrimaryTint3Color : cWhiteColor,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    )),
              );
            }),
      ],
    ));
  }
}

class KidGenderContent extends StatelessWidget {
  KidGenderContent({super.key});
  final KidsController kidsController = Get.find<KidsController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: kidsController.kidGenderList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: k12Padding),
                child: Obx(() => OutLinedButton(
                      onPress: () {
                        kidsController.tempSelectedKidGender.value = kidsController.kidGenderList[index].toString();
                        if (kidsController.tempSelectedKidGender.value == '') {
                          Get.find<GlobalController>().isBottomSheetRightButtonActive.value = false;
                        } else {
                          Get.find<GlobalController>().isBottomSheetRightButtonActive.value = true;
                        }
                      },
                      buttonText: kidsController.kidGenderList[index].toString(),
                      buttonTextStyle: regular16TextStyle(cBlackColor),
                      borderColor: kidsController.tempSelectedKidGender.value == kidsController.kidGenderList[index].toString() ? cPrimaryColor : cLineColor2,
                      buttonColor:
                          kidsController.tempSelectedKidGender.value == kidsController.kidGenderList[index].toString() ? cPrimaryTint3Color : cWhiteColor,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    )),
              );
            }),
      ],
    ));
  }
}
