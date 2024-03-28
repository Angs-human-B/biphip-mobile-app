import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/helpers/menu/kids/kid_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_profile.dart';
import 'package:bip_hip/widgets/common/button/custom_outline_button.dart';
import 'package:bip_hip/widgets/common/button/custom_selection_button.dart';
// import 'package:bip_hip/widgets/common/button/custom_selection_button.dart';

class KidEditPage extends StatelessWidget {
  KidEditPage({super.key});
  final KidsController kidsController = Get.find<KidsController>();
  final KidHelper kidHelper = KidHelper();
  final FocusNode commonSecondaryFocusNode = FocusNode();
  final FocusNode commonFocusNode = FocusNode();

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
                  child: Obx(
                    () => CustomAppBar(
                      appBarColor: cWhiteColor,
                      title: '${kidsController.kidCommonEditPageTitle}'.tr,
                      hasBackButton: true,
                      isCenterTitle: true,
                      onBack: () {
                        Get.back();
                      },
                      action: [
                        if (kidsController.kidFunctionFlag.contains('EDIT'))
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: CustomTextButton(
                                onPressed: () {
                                  deleteAlertDialog(
                                      context: context,
                                      content: DeletePopupContent(
                                          text: ksDeleteConfirmation.tr,
                                          deleteOnPressed: () {
                                            kidHelper.selectFunction("${kidsController.kidFunctionFlag.value} DELETE", kidsController.deleteIndex.value);
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
                ),
                //Obx(
                // () =>
                body: Stack(
                  children: [
                    SizedBox(
                      height: height - kAppBarSize - MediaQuery.of(context).padding.top,
                      width: width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                        child: Column(
                          children: [
                            kH16sizedBox,
                            // if (kidsController.isDropdownShown.value)
                            // Padding(
                            //   padding: const EdgeInsets.only(bottom: k16Padding),
                            //   child: CustomSelectionButton(
                            //     buttonColor: cWhiteColor,
                            //     buttonHeight: 32,
                            //     borderColor: cLineColor,
                            //     contentPadding: const EdgeInsets.symmetric(horizontal: k8Padding),
                            //     onPressed: () async {
                            //       kidHelper.commonSelectionButtonOnPressed(context);
                            //     },
                            //     text: kidsController.kidEducationBackground.value,
                            //     hintText: ksSelectEducationInstitute.tr,
                            //   ),
                            // ),
                            RawAutocomplete(
                              textEditingController: kidsController.kidCommonEditTextEditingController,
                              focusNode: commonFocusNode,
                              optionsBuilder: (TextEditingValue textEditingValue) {
                                return kidsController.temporaryListCommon.where((word) => word.toLowerCase().startsWith(textEditingValue.text.toLowerCase()));
                              },
                              onSelected: (option) {
                                kidsController.kidCommonEditTextEditingController.text = option;
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
                                              kidsController.kidCommonEditTextEditingController.text = option.toString();
                                              kidHelper.checkSaveButtonActive();
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
                                    // errorText: kidsController.commonEditTextFieldErrorText.value,
                                    controller: kidsController.kidCommonEditTextEditingController,
                                    maxLength: (kidsController.commonEditTextfieldHintText.value == ksPhone.tr ||
                                            kidsController.commonEditTextfieldHintText.value == ksEditPhone.tr)
                                        ? 15
                                        : 120,
                                    hint: kidsController.commonEditTextfieldHintText.value,
                                    prefixIcon: kidsController.commonEditPageIcon.value ?? kidsController.kidCommonEditIconData.value,
                                    suffixIcon: kidsController.showCommonEditSuffixIcon.value ? BipHip.circleCrossNew : null,
                                    inputType: (kidsController.commonEditTextfieldHintText.value == ksPhone.tr ||
                                            kidsController.commonEditTextfieldHintText.value == ksEditPhone.tr)
                                        ? TextInputType.number
                                        : TextInputType.text,
                                    borderRadius: k8BorderRadius,
                                    inputFormatters: (kidsController.commonEditTextfieldHintText.value == ksPhone.tr ||
                                            kidsController.commonEditTextfieldHintText.value == ksEditPhone.tr)
                                        ? [FilteringTextInputFormatter.digitsOnly]
                                        : null,
                                    onSuffixPress: () {
                                      // editProfileHelper.commonTextfieldSuffixOnPressed();//!Write this function
                                    },
                                    onSubmit: (value) {
                                      unFocus(context);
                                      kidsController.showCommonEditSuffixIcon.value = false;
                                    },
                                    onChanged: (value) {
                                      // editProfileHelper.commonTextfieldOnChanged();//!Create this function
                                    },
                                  ),
                                );
                              },
                            ),
                            if (kidsController.isKidSecondaryTextfieldShown.value)
                              Padding(
                                padding: const EdgeInsets.only(bottom: k8Padding),
                                child: RawAutocomplete(
                                  textEditingController: kidsController.kidCommonEditSecondaryTextEditingController,
                                  focusNode: commonSecondaryFocusNode,
                                  optionsBuilder: (TextEditingValue textEditingValue) {
                                    return kidsController.temporaryList.where((word) => word.toLowerCase().startsWith(textEditingValue.text.toLowerCase()));
                                  },
                                  onSelected: (option) {
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
                                                  kidsController.kidCommonEditSecondaryTextEditingController.text = option.toString();
                                                  kidHelper.checkSaveButtonActive();
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
                                        suffixIcon: kidsController.showCommonSecondaryEditSuffixIcon.value ? BipHip.circleCrossNew : null,
                                        borderRadius: k8BorderRadius,
                                        onSuffixPress: () {
                                          kidHelper.commonSecondaryTextfieldSuffixOnPressed();
                                        },
                                        onSubmit: (value) {
                                          unFocus(context);
                                          kidsController.showCommonSecondaryEditSuffixIcon.value = false;
                                        },
                                        onChanged: (value) {
                                          // editProfileHelper.commonSecondaryTextfieldOnChanged();//!Write this function
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            if (kidsController.isCommonEditDatePickerShown.value)
                              Padding(
                                padding: const EdgeInsets.only(bottom: k16Padding),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: kidsController.isSingleDatePicker.value ? width - 40 : (width / 2) - 30,
                                      child: CustomSelectionButton(
                                        prefixIcon: BipHip.calendarFill,
                                        prefixIconSize: screenWiseSize(kIconSize20, 4),
                                        onPressed: () {
                                          kidHelper.startDateButtonOnPressed(context); //!Write this function
                                        },
                                        text: kidsController.commonStartDate.value,
                                        hintText: kidsController.isSingleDatePicker.value ? ksDate.tr : ksStartDate.tr,
                                      ),
                                    ),
                                    if (!kidsController.isSingleDatePicker.value)
                                      SizedBox(
                                        width: (width / 2) - 30,
                                        child: CustomSelectionButton(
                                          prefixIcon: BipHip.calendarFill,
                                          prefixIconSize: screenWiseSize(kIconSize20, 4),
                                          onPressed: () {
                                            kidHelper.endDateButtonOnPressed(context); //!Change
                                          },
                                          text: kidsController.commonEndDate.value,
                                          hintText: ksEndDate.tr,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            if (kidsController.isCommonEditPrivacyShown.value || kidsController.isCommonEditCheckBoxShown.value)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if (kidsController.isCommonEditPrivacyShown.value)
                                    OutLinedButton(
                                      buttonWidth: 80,
                                      buttonHeight: 25,
                                      onPress: () {},
                                      buttonText: ksPublic.tr,
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
                                  if (kidsController.isCommonEditCheckBoxShown.value)
                                    Obx(() => SizedBox(
                                          width: width / 2,
                                          child: CustomCheckBox(
                                              value: kidsController.isCommonEditCheckBoxSelected.value,
                                              label: kidsController.commonEditCheckBoxText.value,
                                              onChanged: (v) {
                                                kidHelper.commonCheckBoxOnChanged();
                                              },
                                              textStyle: regular14TextStyle(cBlackColor)),
                                        )),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      // Obx(
                      // () =>
                      child: CustomElevatedButton(
                          label: ksSave,
                          textStyle: semiBold14TextStyle(cWhiteColor),
                          buttonHeight: h42,
                          buttonWidth: width - 40,
                          onPressed: () {
                            //kidsController.enableKidSaveButton.value ?
                            ll(kidsController.kidFunctionFlag.value);
                            kidHelper.selectFunction(kidsController.kidFunctionFlag.value);
                            // if (kidsController.kidFunctionFlag.value != 'ADD LINK' && profileController.functionFlag.value != 'EDIT LINK') {
                            //   Get.back();
                            // }
                            //_profileController.clearCommonEditPageData();
                          }),
                    ),
                    // ),
                  ],
                ),
              ),
            ),
            if (kidsController.isKidContactLoading.value || kidsController.isKidSchoolLoading.value)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (kidsController.isKidContactLoading.value) {
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
