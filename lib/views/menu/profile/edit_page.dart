import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/profile/edit_profile_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_profile.dart';
import 'package:bip_hip/widgets/common/button/custom_selection_button.dart';

class EditPage extends StatelessWidget {
  EditPage({super.key});
  final ProfileController profileController = Get.find<ProfileController>();
  final EditProfileHelper editProfileHelper = EditProfileHelper();
  final FocusNode commonSecondaryFocusNode = FocusNode();
  final FocusNode commonFocusNode = FocusNode();

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
              title: '${profileController.commonEditPageTitle}'.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
              action: [
                if (profileController.functionFlag.contains('EDIT'))
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CustomTextButton(
                        onPressed: () {
                          deleteAlertDialog(
                              context: context,
                              content: DeletePopupContent(
                                  text: ksDeleteConfirmation.tr,
                                  deleteOnPressed: () {
                                    editProfileHelper.selectFunction("${profileController.functionFlag.value} DELETE", profileController.deleteIndex.value);
                                    Get.back();
                                    Get.back();
                                  }),
                              title: ksConfirmation.tr);
                          // editProfileHelper.selectFunction("${profileController.functionFlag.value} DELETE", profileController.deleteIndex.value);
                          // Get.back();
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
                        if (profileController.isDropdownShown.value)
                          Padding(
                            padding: const EdgeInsets.only(bottom: k16Padding),
                            child: CustomSelectionButton(
                              buttonColor: cWhiteColor,
                              buttonHeight: 32,
                              borderColor: cLineColor,
                              contentPadding: const EdgeInsets.symmetric(horizontal: k8Padding),
                              onPressed: () async {
                                editProfileHelper.commonSelectionButtonOnPressed(context);
                              },
                              text: (profileController.commonEditPageTitle.value == ksAddLink || profileController.commonEditPageTitle.value == ksEditLink)
                                  ? profileController.linkSource.value
                                  : profileController.educationBackground.value,
                              hintText: (profileController.commonEditPageTitle.value == ksAddLink || profileController.commonEditPageTitle.value == ksEditLink)
                                  ? ksSelectLinkSource.tr
                                  : ksSelectEducationInstitute.tr,
                            ),
                          ),
                        RawAutocomplete(
                          textEditingController: profileController.commonEditTextEditingController,
                          focusNode: commonFocusNode,
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            return profileController.temporaryListCommon.where((word) => word.toLowerCase().startsWith(textEditingValue.text.toLowerCase()));
                          },
                          onSelected: (option) {
                            profileController.commonEditTextEditingController.text = option;
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
                                          profileController.commonEditTextEditingController.text = option.toString();
                                          editProfileHelper.checkSaveButtonActive();
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
                                errorText: profileController.commonEditTextFieldErrorText.value,
                                controller: profileController.commonEditTextEditingController,
                                maxLength: (profileController.commonEditTextfieldHintText.value == ksPhone.tr ||
                                        profileController.commonEditTextfieldHintText.value == ksEditPhone.tr)
                                    ? 15
                                    : 120,
                                hint: profileController.commonEditTextfieldHintText.value,
                                prefixIcon: profileController.commonEditPageIcon.value ?? profileController.commonEditIconData.value,
                                suffixIcon: profileController.showCommonEditSuffixIcon.value ? BipHip.circleCrossNew : null,
                                inputType: (profileController.commonEditTextfieldHintText.value == ksPhone.tr ||
                                        profileController.commonEditTextfieldHintText.value == ksEditPhone.tr)
                                    ? TextInputType.number
                                    : TextInputType.text,
                                borderRadius: k8BorderRadius,
                                inputFormatters: (profileController.commonEditTextfieldHintText.value == ksPhone.tr ||
                                        profileController.commonEditTextfieldHintText.value == ksEditPhone.tr)
                                    ? [FilteringTextInputFormatter.digitsOnly]
                                    : null,
                                onSuffixPress: () {
                                  editProfileHelper.commonTextfieldSuffixOnPressed();
                                },
                                onSubmit: (value) {
                                  unFocus(context);
                                  profileController.showCommonEditSuffixIcon.value = false;
                                },
                                onChanged: (value) {
                                  editProfileHelper.commonTextfieldOnChanged();
                                },
                              ),
                            );
                          },
                        ),
                        if (profileController.isSecondaryTextfieldShown.value)
                          Padding(
                            padding: const EdgeInsets.only(bottom: k8Padding),
                            child: RawAutocomplete(
                              textEditingController: profileController.commonEditSecondaryTextEditingController,
                              focusNode: commonSecondaryFocusNode,
                              optionsBuilder: (TextEditingValue textEditingValue) {
                                return profileController.temp.where((word) => word.toLowerCase().startsWith(textEditingValue.text.toLowerCase()));
                              },
                              onSelected: (option) {
                                profileController.designationTextEditingController.text = option;

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
                                              profileController.commonEditSecondaryTextEditingController.text = option.toString();
                                              editProfileHelper.checkSaveButtonActive();
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
                                    suffixIcon: profileController.showCommonSecondaryEditSuffixIcon.value ? BipHip.circleCrossNew : null,
                                    borderRadius: k8BorderRadius,
                                    onSuffixPress: () {
                                      editProfileHelper.commonSecondaryTextfieldSuffixOnPressed();
                                    },
                                    onSubmit: (value) {
                                      unFocus(context);
                                      profileController.showCommonSecondaryEditSuffixIcon.value = false;
                                    },
                                    onChanged: (value) {
                                      editProfileHelper.commonSecondaryTextfieldOnChanged();
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        if (profileController.isCommonEditDatePickerShown.value)
                          Padding(
                            padding: const EdgeInsets.only(bottom: k16Padding),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: profileController.isSingleDatePicker.value ? width - 40 : (width / 2) - 30,
                                  child: CustomSelectionButton(
                                    prefixIcon: BipHip.calendarFill,
                                    prefixIconSize: screenWiseSize(kIconSize20, 4),
                                    onPressed: () {
                                      editProfileHelper.startDateButtonOnPressed(context);
                                    },
                                    text: profileController.commonStartDate.value,
                                    hintText: profileController.isSingleDatePicker.value ? ksDate.tr : ksStartDate.tr,
                                  ),
                                ),
                                if (!profileController.isSingleDatePicker.value)
                                  SizedBox(
                                    width: (width / 2) - 30,
                                    child: CustomSelectionButton(
                                      prefixIcon: BipHip.calendarFill,
                                      prefixIconSize: screenWiseSize(kIconSize20, 4),
                                      onPressed: () {
                                        editProfileHelper.endDateButtonOnPressed(context);
                                      },
                                      text: profileController.commonEndDate.value,
                                      hintText: ksEndDate.tr,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        if (profileController.isCommonEditPrivacyShown.value || profileController.isCommonEditCheckBoxShown.value)
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
                              if (profileController.isCommonEditCheckBoxShown.value)
                                SizedBox(
                                  width: profileController.commonEditCheckBoxText.value == 'Currently living here' ? width / 2 : width / 2,
                                  child: CustomCheckBox(
                                      value: profileController.isCommonEditCheckBoxSelected.value,
                                      label: profileController.commonEditCheckBoxText.value,
                                      onChanged: (v) {
                                        editProfileHelper.commonCheckBoxOnChanged();
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
                        buttonHeight: h42,
                        buttonWidth: width - 40,
                        onPressed: profileController.enableSaveButton.value
                            ? () {
                                ll(profileController.functionFlag.value);
                                editProfileHelper.selectFunction(profileController.functionFlag.value);
                                if (profileController.functionFlag.value != 'ADD LINK' && profileController.functionFlag.value != 'EDIT LINK') {
                                  Get.back();
                                }
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
