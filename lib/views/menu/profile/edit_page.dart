import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/photos/gallery_photos.dart';
import 'package:bip_hip/widgets/common/button/custom_selection_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class EditPage extends StatelessWidget {
  EditPage({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();
  final GlobalController _globalController = Get.find<GlobalController>();
  final FocusNode _commonSecondaryFocusNode = FocusNode();
  final FocusNode _commonFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          // resizeToAvoidBottomInset: true,
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
              action: [
                if (_profileController.functionFlag.contains('EDIT'))
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CustomTextButton(
                        onPressed: () {
                          _profileController.selectFunction("${_profileController.functionFlag.value} DELETE", _profileController.deleteIndex.value);
                          Get.back();
                        },
                        text: ksDelete,
                        textStyle: semiBold14TextStyle(cRedColor)),
                  )
              ],
            ),
          ),
          body: Obx(
            () => Stack(
              children: [
                SizedBox(
                  height: height - kAppBarSize - MediaQuery.of(context).padding.top,
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                    child: Column(
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
                              onPressed: () async {
                                _profileController.isLinkListLoading.value = true;
                                _profileController.tempLinkSource.value = _profileController.linkSource.value;
                                _profileController.tempEducationBackground.value = _profileController.educationBackground.value;
                                if (_profileController.tempLinkSource.value == '' &&
                                    (_profileController.commonEditPageTitle.value == ksAddLink || _profileController.commonEditPageTitle.value == ksEditLink)) {
                                  _globalController.isBottomSheetRightButtonActive.value = false;
                                } else if (_profileController.tempEducationBackground.value == '' &&
                                    (_profileController.commonEditPageTitle.value == ksAddEducationalEvent ||
                                        _profileController.commonEditPageTitle.value == ksEditSchool ||
                                        _profileController.commonEditPageTitle.value == ksEditCollege)) {
                                  _globalController.isBottomSheetRightButtonActive.value = false;
                                } else {
                                  _globalController.isBottomSheetRightButtonActive.value = true;
                                }
                                _globalController.commonBottomSheet(
                                  context: context,
                                  content: Obx(
                                    () => (_profileController.commonEditPageTitle.value == ksAddLink ||
                                            _profileController.commonEditPageTitle.value == ksEditLink)
                                        ? (_profileController.isLinkListLoading.value
                                            ? const _LinkListContentShimmer()
                                            : _LinkListContent(profileController: _profileController))
                                        : _EducationBackgroundContent(
                                            profileController: _profileController,
                                          ),
                                  ),
                                  isScrollControlled: true,
                                  bottomSheetHeight:
                                      (_profileController.commonEditPageTitle.value == ksAddLink || _profileController.commonEditPageTitle.value == ksEditLink)
                                          ? height * 0.9
                                          : 200,
                                  onPressCloseButton: () {
                                    Get.back();
                                  },
                                  onPressRightButton: () {
                                    if (_profileController.commonEditPageTitle.value == ksAddLink ||
                                        _profileController.commonEditPageTitle.value == ksEditLink) {
                                      _profileController.linkSource.value = _profileController.tempLinkSource.value;
                                      _profileController.commonEditPageIcon.value = _profileController.getLinkIcon(_profileController.linkSource.value);
                                    } else {
                                      _profileController.educationBackground.value = _profileController.tempEducationBackground.value;
                                    }
                                    _profileController.checkSaveButtonActive();
                                    Get.back();
                                  },
                                  rightText: ksDone.tr,
                                  rightTextStyle: medium14TextStyle(cPrimaryColor),
                                  title:
                                      (_profileController.commonEditPageTitle.value == ksAddLink || _profileController.commonEditPageTitle.value == ksEditLink)
                                          ? ksSelectLinkSource.tr
                                          : ksSelectEducationInstitute.tr,
                                  isRightButtonShow: true,
                                );
                                _profileController.getLinkList();
                              },
                              text: (_profileController.commonEditPageTitle.value == ksAddLink || _profileController.commonEditPageTitle.value == ksEditLink)
                                  ? _profileController.linkSource.value
                                  : _profileController.educationBackground.value,
                              hintText:
                                  (_profileController.commonEditPageTitle.value == ksAddLink || _profileController.commonEditPageTitle.value == ksEditLink)
                                      ? ksSelectLinkSource.tr
                                      : ksSelectEducationInstitute.tr,
                            ),
                          ),
                        // CustomModifiedTextField(
                        //   errorText: _profileController.commonEditTextFieldErrorText.value,
                        //   controller: _profileController.commonEditTextEditingController,
                        //   maxLength: (_profileController.commonEditTextfieldHintText.value == ksPhone.tr ||
                        //           _profileController.commonEditTextfieldHintText.value == ksEditPhone.tr)
                        //       ? 15
                        //       : 255,
                        //   hint: _profileController.commonEditTextfieldHintText.value,
                        //   prefixIcon: _profileController.commonEditPageIcon.value ?? _profileController.commonEditIconData.value,
                        //   suffixIcon: _profileController.showCommonEditSuffixIcon.value ? BipHip.circleCrossNew : null,
                        //   inputType: (_profileController.commonEditTextfieldHintText.value == ksPhone.tr ||
                        //           _profileController.commonEditTextfieldHintText.value == ksEditPhone.tr)
                        //       ? TextInputType.number
                        //       : TextInputType.text,
                        //   borderRadius: k8BorderRadius,
                        //   inputFormatters: (_profileController.commonEditTextfieldHintText.value == ksPhone.tr ||
                        //           _profileController.commonEditTextfieldHintText.value == ksEditPhone.tr)
                        //       ? [FilteringTextInputFormatter.digitsOnly]
                        //       : null,
                        //   onSuffixPress: () {
                        //     _profileController.commonEditTextEditingController.clear();
                        //     _profileController.showCommonEditSuffixIcon.value = false;
                        //   },
                        //   onChanged: (value) {
                        //     if (_profileController.commonEditTextEditingController.text != '') {
                        //       _profileController.showCommonEditSuffixIcon.value = true;
                        //     } else {
                        //       _profileController.showCommonEditSuffixIcon.value = false;
                        //     }
                        //     if (_profileController.commonEditTextfieldHintText.value == ksEmail.tr ||
                        //         _profileController.commonEditTextfieldHintText.value == ksEditEmail.tr) {
                        //       if (!_profileController.commonEditTextEditingController.text.isValidEmail) {
                        //         _profileController.commonEditTextFieldErrorText.value = ksInvalidEmailErrorMessage.tr;
                        //       } else {
                        //         _profileController.commonEditTextFieldErrorText.value = '';
                        //       }
                        //     }
                        //   },
                        // ),
                        RawAutocomplete(
                          textEditingController: _profileController.commonEditTextEditingController,
                          focusNode: _commonFocusNode,
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            return _profileController.tempListCommon.where((word) => word.toLowerCase().startsWith(textEditingValue.text.toLowerCase()));
                          },
                          onSelected: (option) {
                            _profileController.commonEditTextEditingController.text = option;
                          },
                          optionsViewBuilder: (context, Function(String) onSelected, options) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: SizedBox(
                                width: width - 40,
                                child: Material(
                                  elevation: 4,
                                  child: ListView.separated(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      final option = options.elementAt(index);
                                      return CustomListTile(
                                        title: Text(
                                          option.toString(),
                                          style: medium16TextStyle(cBlackColor),
                                        ),
                                        onPressed: () {
                                          onSelected(option.toString());
                                          _profileController.commonEditTextEditingController.text = option.toString();
                                          _profileController.checkSaveButtonActive();

                                          unfocus(context);
                                        },
                                      );
                                    },
                                    separatorBuilder: (context, index) => Container(
                                      height: 1,
                                      color: cLineColor,
                                    ),
                                    itemCount: options.length,
                                  ),
                                ),
                              ),
                            );
                          },
                          fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                            return Obx(
                              () => CustomModifiedTextField(
                                focusNode: focusNode,
                                errorText: _profileController.commonEditTextFieldErrorText.value,
                                controller: _profileController.commonEditTextEditingController,
                                maxLength: (_profileController.commonEditTextfieldHintText.value == ksPhone.tr ||
                                        _profileController.commonEditTextfieldHintText.value == ksEditPhone.tr)
                                    ? 15
                                    : 120,
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
                                  _profileController.checkSaveButtonActive();
                                },
                                onSubmit: (value) {
                                  unFocus(context);
                                  _profileController.showCommonEditSuffixIcon.value = false;
                                },
                                onChanged: (value) {
                                  if (_profileController.commonEditTextEditingController.text != '') {
                                    _profileController.showCommonEditSuffixIcon.value = true;
                                  } else {
                                    _profileController.showCommonEditSuffixIcon.value = false;
                                  }
                                  if (_profileController.commonEditTextfieldHintText.value == ksEmail.tr ||
                                      _profileController.commonEditTextfieldHintText.value == ksEditEmail.tr) {
                                    if (!_profileController.commonEditTextEditingController.text.isValidEmail) {
                                      _profileController.commonEditTextFieldErrorText.value = ksInvalidEmailErrorMessage.tr;
                                    } else {
                                      _profileController.commonEditTextFieldErrorText.value = '';
                                    }
                                  }
                                  _profileController.checkSaveButtonActive();
                                },
                              ),
                            );
                          },
                        ),

                        if (_profileController.isSecondaryTextfieldShown.value)
                          Padding(
                            padding: const EdgeInsets.only(bottom: k8Padding),
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
                                return Align(
                                  alignment: Alignment.topLeft,
                                  child: SizedBox(
                                    width: width - 40,
                                    child: Material(
                                      elevation: 4,
                                      child: ListView.separated(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          final option = options.elementAt(index);

                                          return CustomListTile(
                                            title: Text(
                                              option.toString(),
                                              style: medium16TextStyle(cBlackColor),
                                            ),
                                            onPressed: () {
                                              onSelected(option.toString());
                                              _profileController.commonEditSecondaryTextEditingController.text = option.toString();
                                              _profileController.checkSaveButtonActive();

                                              unfocus(context);
                                            },
                                          );
                                        },
                                        separatorBuilder: (context, index) => Container(
                                          height: 1,
                                          color: cLineColor,
                                        ),
                                        itemCount: options.length,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                                return Obx(
                                  () => CustomModifiedTextField(
                                    controller: textEditingController,
                                    focusNode: focusNode,
                                    hint: ksDesignation.tr,
                                    prefixIcon: BipHip.work,
                                    suffixIcon: _profileController.showCommonSecondaryEditSuffixIcon.value ? BipHip.circleCrossNew : null,
                                    borderRadius: k8BorderRadius,
                                    onSuffixPress: () {
                                      _profileController.commonEditSecondaryTextEditingController.clear();
                                      _profileController.checkSaveButtonActive();

                                      _profileController.showCommonSecondaryEditSuffixIcon.value = false;
                                    },
                                    onSubmit: (value) {
                                      unFocus(context);
                                      _profileController.showCommonSecondaryEditSuffixIcon.value = false;
                                    },
                                    onChanged: (value) {
                                      _profileController.checkSaveButtonActive();

                                      if (_profileController.commonEditSecondaryTextEditingController.text.isNotEmpty) {
                                        _profileController.showCommonSecondaryEditSuffixIcon.value = true;
                                      } else {
                                        _profileController.showCommonSecondaryEditSuffixIcon.value = false;
                                      }
                                    },
                                  ),
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
                        if (_profileController.isCommonEditDatePickerShown.value)
                          Padding(
                            padding: const EdgeInsets.only(bottom: k16Padding),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: _profileController.isSingleDatePicker.value ? width - 40 : (width / 2) - 30,
                                  child: CustomSelectionButton(
                                    prefixIcon: BipHip.calendarFill,
                                    prefixIconSize: screenWiseSize(kIconSize20, 4),
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return SizedBox(
                                              height: height * 0.4,
                                              child: CupertinoDatePicker(
                                                // maximumDate: DateTime.now(),
                                                initialDateTime: _profileController.commonStartDate.value != ''
                                                    ? DateTime.parse(_profileController.commonStartDate.value)
                                                    : DateTime.now(),
                                                mode: CupertinoDatePickerMode.date,
                                                onDateTimeChanged: (value) {
                                                  _profileController.commonStartDate.value = DateFormat("yyyy-MM-dd").format(value);
                                                  _profileController.checkSaveButtonActive();
                                                },
                                              ),
                                            );
                                          });
                                    },
                                    text: _profileController.commonStartDate.value,
                                    hintText: _profileController.isSingleDatePicker.value ? ksDate.tr : ksStartDate.tr,
                                  ),
                                ),
                                if (!_profileController.isSingleDatePicker.value)
                                  SizedBox(
                                    width: (width / 2) - 30,
                                    child: CustomSelectionButton(
                                      prefixIcon: BipHip.calendarFill,
                                      prefixIconSize: screenWiseSize(kIconSize20, 4),
                                      onPressed: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return SizedBox(
                                                height: height * 0.4,
                                                child: CupertinoDatePicker(
                                                  mode: CupertinoDatePickerMode.date,
                                                  // maximumDate: DateTime.now(),
                                                  initialDateTime: _profileController.commonEndDate.value != ''
                                                      ? DateTime.parse(_profileController.commonEndDate.value)
                                                      : DateTime.now(),
                                                  onDateTimeChanged: (value) {
                                                    _profileController.commonEndDate.value = DateFormat("yyyy-MM-dd").format(value);
                                                    _profileController.checkSaveButtonActive();
                                                  },
                                                ),
                                              );
                                            });
                                      },
                                      text: _profileController.commonEndDate.value,
                                      hintText: ksEndDate.tr,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        if (_profileController.isCommonEditPrivacyShown.value || _profileController.isCommonEditCheckBoxShown.value)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                  width: _profileController.commonEditCheckBoxText.value == 'Currently living here' ? width / 2 : width / 2,
                                  child: CustomCheckBox(
                                      value: _profileController.isCommonEditCheckBoxSelected.value,
                                      label: _profileController.commonEditCheckBoxText.value,
                                      onChanged: (v) {
                                        _profileController.isCommonEditCheckBoxSelected.value = !_profileController.isCommonEditCheckBoxSelected.value;
                                        if (!_profileController.functionFlag.contains('PRESENT')) {
                                          if (_profileController.isCommonEditCheckBoxSelected.value) {
                                            _profileController.isSingleDatePicker.value = true;
                                            _profileController.commonEndDate.value = '';
                                          } else {
                                            _profileController.isSingleDatePicker.value = false;
                                          }
                                        }
                                        _profileController.checkSaveButtonActive();
                                      },
                                      textStyle: regular14TextStyle(cBlackColor)),
                                )
                            ],
                          ),

                        // Row(
                        //   children: [
                        //     CustomElevatedButton(
                        //         label: ksDelete,
                        //         buttonColor: cWhiteColor,
                        //         borderColor: cRedColor,
                        //         textStyle: semiBold14TextStyle(cRedColor),
                        //         buttonHeight: h32,
                        //         buttonWidth: (width - 48) / 2,
                        //         onPressed: () {
                        //           _profileController.selectFunction("${_profileController.functionFlag.value} DELETE", _profileController.deleteIndex.value);
                        //           Get.back();
                        //         }),
                        //     if (_profileController.functionFlag.contains('EDIT')) kW8sizedBox,
                        //     CustomElevatedButton(
                        //         label: ksSave,
                        //         textStyle: semiBold14TextStyle(cWhiteColor),
                        //         buttonHeight: h32,
                        //         buttonWidth: !_profileController.functionFlag.contains('EDIT') ? width - 40 : (width - 48) / 2,
                        //         onPressed: () {
                        //           ll(_profileController.functionFlag.value);
                        //           _profileController.selectFunction(_profileController.functionFlag.value);
                        //           Get.back();
                        //           //_profileController.clearCommonEditPageData();
                        //         }),
                        //   ],
                        // ),
                        // kHBottomSizedBox
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Obx(
                    () => CustomElevatedButton(
                        label: ksSave,
                        textStyle: semiBold14TextStyle(cWhiteColor),
                        buttonHeight: h32,
                        buttonWidth: width - 40,
                        onPressed: _profileController.enableSaveButton.value
                            ? () {
                                ll(_profileController.functionFlag.value);
                                _profileController.selectFunction(_profileController.functionFlag.value);
                                Get.back();
                                //_profileController.clearCommonEditPageData();
                              }
                            : null),
                  ),
                )
              ],
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
    return Obx(() => Column(
          children: [
            profileController.educationBackgroundList.isNotEmpty
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: profileController.educationBackgroundList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: k8Padding),
                        child: Obx(() => CustomListTile(
                              title: profileController.educationBackgroundList[index],
                              borderColor: profileController.tempEducationBackground.value == profileController.educationBackgroundList[index]
                                  ? cPrimaryColor
                                  : cLineColor,
                              trailing: CustomRadioButton(
                                onChanged: () {
                                  profileController.tempEducationBackground.value = profileController.educationBackgroundList[index];
                                },
                                isSelected: profileController.tempEducationBackground.value == profileController.educationBackgroundList[index],
                              ),
                              itemColor: profileController.tempEducationBackground.value == profileController.educationBackgroundList[index]
                                  ? cPrimaryTint3Color
                                  : cWhiteColor,
                              onPressed: () {
                                profileController.tempEducationBackground.value = profileController.educationBackgroundList[index];
                                if (profileController.tempEducationBackground.value == '') {
                                  Get.find<GlobalController>().isBottomSheetRightButtonActive.value = false;
                                } else {
                                  Get.find<GlobalController>().isBottomSheetRightButtonActive.value = true;
                                }
                              },
                            )),
                      );
                    },
                  )
                : EmptyView(
                    height: 140,
                    title: ksNoDataAvailable.tr,
                  ),
          ],
        ));
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
    return Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            profileController.linkSourceList.isNotEmpty
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: profileController.linkSourceList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Obx(
                        () => Padding(
                          padding: const EdgeInsets.only(bottom: k8Padding),
                          child: CustomListTile(
                            title: profileController.linkSourceList[index],
                            borderColor: profileController.tempLinkSource.value == profileController.linkSourceList[index] ? cPrimaryColor : cLineColor,
                            trailing: CustomRadioButton(
                              onChanged: () {
                                profileController.tempLinkSource.value = profileController.linkSourceList[index];
                              },
                              isSelected: profileController.tempLinkSource.value == profileController.linkSourceList[index],
                            ),
                            itemColor: profileController.tempLinkSource.value == profileController.linkSourceList[index] ? cPrimaryTint3Color : cWhiteColor,
                            onPressed: () {
                              profileController.tempLinkSource.value = profileController.linkSourceList[index];
                              if (profileController.tempLinkSource.value == '') {
                                Get.find<GlobalController>().isBottomSheetRightButtonActive.value = false;
                              } else {
                                Get.find<GlobalController>().isBottomSheetRightButtonActive.value = true;
                              }
                            },
                          ),
                        ),
                      );
                    },
                  )
                : EmptyView(
                    height: height * 0.8,
                    title: ksNoDataAvailable.tr,
                  ),
          ],
        ));
  }
}

class _LinkListContentShimmer extends StatelessWidget {
  const _LinkListContentShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: k12Padding),
              child: CustomListTile(
                borderColor: cLineColor,
                title: ShimmerCommon(
                  widget: Container(
                    decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                    height: 16,
                    width: 120,
                  ),
                ),
                trailing: ShimmerCommon(
                  widget: Container(
                    decoration: const BoxDecoration(color: cWhiteColor, shape: BoxShape.circle),
                    height: 16,
                    width: 16,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
