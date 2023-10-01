import 'package:bip_hip/controllers/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/custom_outline_button.dart';
import 'package:bip_hip/widgets/common/custom_selection_button.dart';
import 'package:flutter/cupertino.dart';

class EditPage extends StatelessWidget {
  EditPage({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();
  final GlobalController _globalController = Get.find<GlobalController>();

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
              title: '${_profileController.commonEditPageTitle}'.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: SizedBox(
            height: height - kAppBarSize,
            width: width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: Obx(
                () => Column(
                  children: [
                    kH16sizedBox,
                    if (_profileController.isDropdownShown.value)
                      Padding(
                        padding: const EdgeInsets.only(bottom: k16Padding),
                        child: CustomSelectionButton(
                          buttonColor: cWhiteColor,
                          buttonHeight: 32,
                          borderColor: cLineColor,
                          contentPadding: const EdgeInsets.symmetric(horizontal: k8Padding),
                          onPressed: () {
                            _profileController.showEditRelationshipStatus.value = true;
                            _globalController.commonBottomSheet(
                              context: context,
                              content: _EducationBackgroundContent(
                                profileController: _profileController,
                              ),
                              isScrollControlled: true,
                              bottomSheetHeight: height * 0.3,
                              onPressCloseButton: () {
                                Get.back();
                              },
                              onPressRightButton: () {
                                Get.back();
                              },
                              rightText: 'Done',
                              rightTextStyle: medium14TextStyle(cPrimaryColor),
                              title: 'Select Education Institute',
                              isRightButtonShow: true,
                            );
                          },
                          text: _profileController.educationBackground.value,
                          hintText: 'Select Education Institute',
                        ),
                      ),
                    CustomModifiedTextField(
                      controller: _profileController.commonEditTextEditingController,
                      hint: _profileController.commonEditTextfieldHintText.value,
                      prefixIcon: _profileController.commonEditIconData.value,
                      suffixIcon: BipHip.circleCrossNew,
                      borderRadius: k8BorderRadius,
                      onSuffixPress: () {
                        _profileController.commonEditTextEditingController.clear();
                      },
                    ),
                    if (_profileController.isCommonEditDatePickerShown.value)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: k16Padding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: (width / 2) - 30,
                              child: CustomSelectionButton(
                                prefixIcon: BipHip.calendarFill,
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return SizedBox(
                                          height: height * 0.4,
                                          child: CupertinoDatePicker(
                                            mode: CupertinoDatePickerMode.monthYear,
                                            onDateTimeChanged: (value) {
                                              // _profileController.startDateAddress.value = value.year.toString();
                                            },
                                          ),
                                        );
                                      });
                                },
                                text: _profileController.startDateAddress.value,
                                hintText: 'Start Date',
                              ),
                            ),
                            SizedBox(
                              width: (width / 2) - 30,
                              child: CustomSelectionButton(
                                prefixIcon: BipHip.calendarFill,
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return SizedBox(
                                          height: height * 0.4,
                                          child: CupertinoDatePicker(
                                            mode: CupertinoDatePickerMode.monthYear,
                                            onDateTimeChanged: (value) {
                                              // _profileController.endDateAddress.value = value.year.toString();
                                            },
                                          ),
                                        );
                                      });
                                },
                                text: _profileController.endDateAddress.value,
                                hintText: 'End Date',
                              ),
                            ),
                          ],
                        ),
                      ),
                    kH16sizedBox,
                    if (_profileController.isCommonEditPrivacyShown.value || _profileController.isCommonEditCheckBoxShown.value)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (_profileController.isCommonEditPrivacyShown.value)
                            OutLinedButton(
                              buttonWidth: 80,
                              buttonHeight: 25,
                              onPress: () {},
                              buttonText: 'Public',
                              buttonTextStyle: semiBold12TextStyle(cBlackColor),
                              borderColor: cLineColor,
                              suffixWidget: const Padding(
                                padding: EdgeInsets.only(right: k8Padding),
                                child: Icon(
                                  BipHip.world,
                                  color: cIconColor,
                                  size: kIconSize16,
                                ),
                              ),
                            ),
                          if (_profileController.isCommonEditCheckBoxShown.value)
                            SizedBox(
                              width: _profileController.commonEditCheckBoxText.value == 'Currently studying here' ? 175 : 155,
                              child: CustomCheckBox(
                                  value: _profileController.isCommonEditCheckBoxSelected.value,
                                  label: _profileController.commonEditCheckBoxText.value,
                                  onChanged: (v) {
                                    _profileController.isCommonEditCheckBoxSelected.value = !_profileController.isCommonEditCheckBoxSelected.value;
                                  },
                                  textStyle: regular14TextStyle(cBlackColor)),
                            )
                        ],
                      ),
                    const Spacer(),
                    CustomElevatedButton(
                        label: 'Save',
                        textStyle: semiBold14TextStyle(cWhiteColor),
                        buttonHeight: h32,
                        buttonWidth: width - 40,
                        onPressed: () {
                          ll(_profileController.functionFlag.value);
                          _profileController.selectFunction(_profileController.functionFlag.value);
                          Get.back();
                        }),
                    kHBottomSizedBox
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

class _EducationBackgroundContent extends StatelessWidget {
  const _EducationBackgroundContent({
    Key? key,
    required this.profileController,
  }) : super(key: key);

  final ProfileController profileController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: profileController.educationBackgroundList.length,
          itemBuilder: (BuildContext context, int index) {
            return Obx(() => RadioListTile(
                  title: Text(profileController.educationBackgroundList[index]),
                  value: profileController.educationBackgroundList[index],
                  activeColor: cPrimaryColor,
                  contentPadding: EdgeInsets.zero,
                  groupValue: profileController.educationBackground.value,
                  controlAffinity: ListTileControlAffinity.trailing,
                  onChanged: (value) {
                    profileController.educationBackground.value = value;
                  },
                ));
          },
        ),
      ],
    );
  }
}
