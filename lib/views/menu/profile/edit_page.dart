import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/profile_helpers/edit_profile_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_selection_button.dart';

class EditPage extends StatelessWidget {
  EditPage({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();
  final EditProfileHelper _editProfileHelper = EditProfileHelper();
  final FocusNode _commonSecondaryFocusNode = FocusNode();
  final FocusNode _commonFocusNode = FocusNode();

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
                                _editProfileHelper.commonSelectionButtonOnPressed(context);
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
                                 _editProfileHelper.commonTextfieldSuffixOnPressed();
                                },
                                onSubmit: (value) {
                                  unFocus(context);
                                  _profileController.showCommonEditSuffixIcon.value = false;
                                },
                                onChanged: (value) {
                                  _editProfileHelper.commonTextfieldOnChanged();
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
                                      _editProfileHelper.commonSecondaryTextfieldSuffixOnPressed();
                                    },
                                    onSubmit: (value) {
                                      unFocus(context);
                                      _profileController.showCommonSecondaryEditSuffixIcon.value = false;
                                    },
                                    onChanged: (value) {
                                      _editProfileHelper.commonSecondaryTextfieldOnChanged();
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
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
                                      _editProfileHelper.startDateButtonOnPressed(context);
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
                                       _editProfileHelper.endDateButtonOnPressed(context);
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
                                        _editProfileHelper.commonCheckBoxOnChanged();
                                      },
                                      textStyle: regular14TextStyle(cBlackColor)),
                                )
                            ],
                          ),
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

