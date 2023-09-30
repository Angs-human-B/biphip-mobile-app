import 'package:bip_hip/controllers/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/custom_outline_button.dart';
import 'package:bip_hip/widgets/common/custom_selection_button.dart';
import 'package:flutter/cupertino.dart';

class EditPage extends StatelessWidget {
  EditPage({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();

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
              title: 'Edit ${_profileController.commonEditPageTitle}'.tr,
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
              child: Column(
                children: [
                  kH16sizedBox,
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
                            width: 145,
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
    );
  }
}
