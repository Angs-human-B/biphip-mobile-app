import 'package:bip_hip/controllers/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_selection_button.dart';

class EditPage extends StatelessWidget {
  EditPage({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();
  final GlobalController _globalController = Get.find<GlobalController>();
  final FocusNode _commonSecondaryFocusNode = FocusNode();

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
          body: SingleChildScrollView(
            child: SizedBox(
              height: height - kAppBarSize - MediaQuery.of(context).padding.top,
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
                              _profileController.tempLinkSource.value = _profileController.linkSource.value;
                              _globalController.commonBottomSheet(
                                context: context,
                                content:
                                    (_profileController.commonEditPageTitle.value == ksAddLink || _profileController.commonEditPageTitle.value == ksEditLink)
                                        ? _LinkListContent(profileController: _profileController)
                                        : _EducationBackgroundContent(
                                            profileController: _profileController,
                                          ),
                                isScrollControlled: true,
                                bottomSheetHeight:
                                    (_profileController.commonEditPageTitle.value == ksAddLink || _profileController.commonEditPageTitle.value == ksEditLink)
                                        ? height * 0.4
                                        : height * 0.3,
                                onPressCloseButton: () {
                                  Get.back();
                                },
                                onPressRightButton: () {
                                  if (_profileController.commonEditPageTitle.value == ksAddLink || _profileController.commonEditPageTitle.value == ksEditLink) {
                                    _profileController.linkSource.value = _profileController.tempLinkSource.value;
                                    _profileController.commonEditPageIcon.value = _profileController.getLinkIcon(_profileController.linkSource.value);
                                  }
                                  Get.back();
                                },
                                rightText: ksDone.tr,
                                rightTextStyle: medium14TextStyle(cPrimaryColor),
                                title: (_profileController.commonEditPageTitle.value == ksAddLink || _profileController.commonEditPageTitle.value == ksEditLink)
                                    ? ksSelectLinkSource.tr
                                    : ksSelectEducationInstitute.tr,
                                isRightButtonShow: true,
                              );
                            },
                            text: (_profileController.commonEditPageTitle.value == ksAddLink || _profileController.commonEditPageTitle.value == ksEditLink)
                                ? _profileController.linkSource.value
                                : _profileController.educationBackground.value,
                            hintText: (_profileController.commonEditPageTitle.value == ksAddLink || _profileController.commonEditPageTitle.value == ksEditLink)
                                ? ksSelectLinkSource.tr
                                : ksSelectEducationInstitute.tr,
                          ),
                        ),
                      CustomModifiedTextField(
                        errorText: _profileController.commonEditTextFieldErrorText.value,
                        controller: _profileController.commonEditTextEditingController,
                        maxLength: (_profileController.commonEditTextfieldHintText.value == ksPhone.tr ||
                                _profileController.commonEditTextfieldHintText.value == ksEditPhone.tr)
                            ? 15
                            : 255,
                        hint: _profileController.commonEditTextfieldHintText.value,
                        prefixIcon: _profileController.commonEditPageIcon.value ?? _profileController.commonEditIconData.value,
                        suffixIcon: _profileController.showCommonEditSuffixIcon.value ? BipHip.circleCrossNew : null,
                        inputType: (_profileController.commonEditTextfieldHintText.value == ksPhone.tr ||
                                _profileController.commonEditTextfieldHintText.value == ksEditPhone.tr)
                            ? TextInputType.number
                            : TextInputType.text,
                        borderRadius: k8BorderRadius,
                        inputFormatters: (_profileController.commonEditTextfieldHintText.value == ksPhone.tr ||
                                _profileController.commonEditTextfieldHintText.value == ksEditPhone.tr)
                            ? [FilteringTextInputFormatter.digitsOnly]
                            : null,
                        onSuffixPress: () {
                          _profileController.commonEditTextEditingController.clear();
                          _profileController.showCommonEditSuffixIcon.value = false;
                        },
                        onChanged: (value) {
                          _profileController.showCommonEditSuffixIcon.value = true;
                          if (_profileController.commonEditTextfieldHintText.value == ksEmail.tr ||
                              _profileController.commonEditTextfieldHintText.value == ksEditEmail.tr &&
                                  !_profileController.commonEditTextEditingController.text.isValidEmail) {
                            _profileController.commonEditTextFieldErrorText.value = ksInvalidEmailErrorMessage.tr;
                          } else {
                            _profileController.commonEditTextFieldErrorText.value = '';
                          }
                        },
                      ),
                      if (_profileController.isSecondaryTextfieldShown.value)
                        Padding(
                          padding: const EdgeInsets.only(bottom: k16Padding),
                          child: RawAutocomplete(
                            textEditingController: _profileController.commonEditSecondaryTextEditingController,
                            focusNode: _commonSecondaryFocusNode,
                            optionsBuilder: (TextEditingValue textEditingValue) {
                              return _profileController.temp.where((word) => word.toLowerCase().startsWith(textEditingValue.text.toLowerCase()));
                            },
                            onSelected: (option) {
                              _profileController.designationTextEditingController.text = option;

                              ll(option);
                            },
                            optionsViewBuilder: (context, Function(String) onSelected, options) {
                              return Material(
                                elevation: 4,
                                child: ListView.separated(
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    final option = options.elementAt(index);

                                    return ListTile(
                                      title: Text(option.toString()),
                                      onTap: () {
                                        onSelected(option.toString());
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) => const Divider(),
                                  itemCount: options.length,
                                ),
                              );
                            },
                            fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                              return CustomModifiedTextField(
                                controller: textEditingController,
                                focusNode: focusNode,
                                hint: ksDesignation.tr,
                                prefixIcon: BipHip.work,
                                suffixIcon: _profileController.showCommonSecondaryEditSuffixIcon.value ? BipHip.circleCrossNew : null,
                                borderRadius: k8BorderRadius,
                                onSuffixPress: () {
                                  _profileController.commonEditSecondaryTextEditingController.clear();
                                  _profileController.showCommonSecondaryEditSuffixIcon.value = false;
                                },
                                onChanged: (value) {
                                  _profileController.showCommonSecondaryEditSuffixIcon.value = true;
                                },
                              );
                            },
                          ),
                        ),
                      // Padding(
                      //   padding: const EdgeInsets.only(bottom: k16Padding),
                      //   child: CustomModifiedTextField(
                      //     controller: _profileController.commonEditSecondaryTextEditingController,
                      //     hint: ksDesignation.tr,
                      //     prefixIcon: BipHip.work,
                      //     suffixIcon: _profileController.showCommonSecondaryEditSuffixIcon.value ? BipHip.circleCrossNew : null,
                      //     borderRadius: k8BorderRadius,
                      //     onSuffixPress: () {
                      //       _profileController.commonEditSecondaryTextEditingController.clear();
                      //     },
                      //     onChanged: (value) {
                      //       _profileController.showCommonSecondaryEditSuffixIcon.value = true;
                      //     },
                      //   ),
                      // ),
                      // if (_profileController.isCommonEditDatePickerShown.value)
                      //   Padding(
                      //     padding: const EdgeInsets.symmetric(vertical: k16Padding),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         SizedBox(
                      //           width: (width / 2) - 30,
                      //           child: CustomSelectionButton(
                      //             prefixIcon: BipHip.calendarFill,
                      //             onPressed: () {
                      //               showModalBottomSheet(
                      //                   context: context,
                      //                   builder: (context) {
                      //                     return SizedBox(
                      //                       height: height * 0.4,
                      //                       child: CupertinoDatePicker(
                      //                         mode: CupertinoDatePickerMode.monthYear,
                      //                         onDateTimeChanged: (value) {
                      //                           // _profileController.startDateAddress.value = value.year.toString();
                      //                         },
                      //                       ),
                      //                     );
                      //                   });
                      //             },
                      //             text: _profileController.startDateAddress.value,
                      //             hintText: ksStartDate.tr,
                      //           ),
                      //         ),
                      //         SizedBox(
                      //           width: (width / 2) - 30,
                      //           child: CustomSelectionButton(
                      //             prefixIcon: BipHip.calendarFill,
                      //             onPressed: () {
                      //               showModalBottomSheet(
                      //                   context: context,
                      //                   builder: (context) {
                      //                     return SizedBox(
                      //                       height: height * 0.4,
                      //                       child: CupertinoDatePicker(
                      //                         mode: CupertinoDatePickerMode.monthYear,
                      //                         onDateTimeChanged: (value) {
                      //                           // _profileController.endDateAddress.value = value.year.toString();
                      //                         },
                      //                       ),
                      //                     );
                      //                   });
                      //             },
                      //             text: _profileController.endDateAddress.value,
                      //             hintText: ksEndDate.tr,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      if (_profileController.isCommonEditPrivacyShown.value || _profileController.isCommonEditCheckBoxShown.value)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // if (_profileController.isCommonEditPrivacyShown.value)
                            //   OutLinedButton(
                            //     buttonWidth: 80,
                            //     buttonHeight: 25,
                            //     onPress: () {},
                            //     buttonText: ksPublic.tr,
                            //     buttonTextStyle: semiBold12TextStyle(cBlackColor),
                            //     borderColor: cLineColor,
                            //     suffixWidget: const Padding(
                            //       padding: EdgeInsets.only(right: k8Padding),
                            //       child: Icon(
                            //         BipHip.world,
                            //         color: cIconColor,
                            //         size: kIconSize16,
                            //       ),
                            //     ),
                            //   ),
                            if (_profileController.isCommonEditCheckBoxShown.value)
                              SizedBox(
                                width: _profileController.commonEditCheckBoxText.value == 'Currently living here' ? 155 : 155,
                                child: CustomCheckBox(
                                    value: _profileController.isCommonEditCheckBoxSelected.value,
                                    label: _profileController.commonEditCheckBoxText.value,
                                    onChanged: (v) {
                                      _profileController.isCommonEditCheckBoxSelected.value = !_profileController.isCommonEditCheckBoxSelected.value;
                                      ll(_profileController.isCommonEditCheckBoxSelected.value);
                                    },
                                    textStyle: regular14TextStyle(cBlackColor)),
                              )
                          ],
                        ),
                      const Spacer(),
                      Row(
                        children: [
                          if (_profileController.functionFlag.contains('EDIT'))
                            CustomElevatedButton(
                                label: ksDelete,
                                buttonColor: cWhiteColor,
                                borderColor: cRedColor,
                                textStyle: semiBold14TextStyle(cRedColor),
                                buttonHeight: h32,
                                buttonWidth: (width - 48) / 2,
                                onPressed: () {
                                  _profileController.selectFunction("${_profileController.functionFlag.value} DELETE", _profileController.deleteIndex.value);
                                  Get.back();
                                }),
                          if (_profileController.functionFlag.contains('EDIT')) kW8sizedBox,
                          CustomElevatedButton(
                              label: ksSave,
                              textStyle: semiBold14TextStyle(cWhiteColor),
                              buttonHeight: h32,
                              buttonWidth: !_profileController.functionFlag.contains('EDIT') ? width - 40 : (width - 48) / 2,
                              onPressed: () {
                                ll(_profileController.functionFlag.value);
                                _profileController.selectFunction(_profileController.functionFlag.value);
                                Get.back();
                                //_profileController.clearCommonEditPageData();
                              }),
                        ],
                      ),
                      kHBottomSizedBox
                    ],
                  ),
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
            return Obx(
              () => RadioListTile(
                title: Text(profileController.educationBackgroundList[index]),
                value: profileController.educationBackgroundList[index],
                activeColor: cPrimaryColor,
                contentPadding: EdgeInsets.zero,
                groupValue: profileController.educationBackground.value,
                controlAffinity: ListTileControlAffinity.trailing,
                onChanged: (value) {
                  profileController.educationBackground.value = value;
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

class _LinkListContent extends StatelessWidget {
  const _LinkListContent({
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
          itemCount: profileController.linkSourceList.length,
          itemBuilder: (BuildContext context, int index) {
            return Obx(
              () => CustomListTile(
                title: Text(profileController.linkSourceList[index]),
                trailing: CustomRadioButton(
                  onChanged: () {
                    profileController.tempLinkSource.value = profileController.linkSourceList[index];
                  },
                  isSelected: profileController.tempLinkSource.value == profileController.linkSourceList[index],
                ),
                itemColor: profileController.tempLinkSource.value == profileController.linkSourceList[index] ? cPrimaryTint3Color : cWhiteColor,
                onPressed: () {
                  profileController.tempLinkSource.value = profileController.linkSourceList[index];
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
