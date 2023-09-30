import 'package:bip_hip/controllers/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile/edit_profile.dart';
import 'package:bip_hip/widgets/common/custom_outline_button.dart';
import 'package:bip_hip/widgets/common/custom_selection_button.dart';
import 'package:flutter/cupertino.dart';

class EditAboutInfo extends StatelessWidget {
  EditAboutInfo({super.key});

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
              title: 'About'.tr,
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
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kH20sizedBox,
                      Text(
                        'Address',
                        style: semiBold18TextStyle(cBlackColor),
                      ),
                      kH20sizedBox,
                      RowTextButton(
                        text: 'Hometown',
                        buttonText: 'Add Hometown',
                        showAddButton: _profileController.homeTown.value == '' ? true : false,
                        buttonWidth: 151,
                        onPressedAdd: () {
                          _profileController.setEditPageValue('Add Hometown Address', BipHip.location, _profileController.homeTownTextEditingController,
                              'Enter hometown address', false, true, false, false, '', 'HOMETOWN');
                          Get.toNamed(krEdit);
                        },
                      ),
                      if (_profileController.homeTown.value != '')
                        Padding(
                          padding: const EdgeInsets.only(top: k10Padding),
                          child: InfoContainer(
                            prefixIcon: BipHip.location,
                            suffixIcon: BipHip.edit,
                            text: _profileController.homeTown.value,
                            suffixOnPressed: () {
                              _globalController.blankBottomSheet(
                                  context: context,
                                  isScrollControlled: false,
                                  bottomSheetHeight: 150,
                                  content: EditModalSheet(
                                    editButtonText: 'Edit Address',
                                    editOnPressed: () {
                                      _profileController.setEditPageValue(
                                          'Edit Hometown Address',
                                          BipHip.location,
                                          _profileController.homeTownTextEditingController,
                                          'Edit hometown address',
                                          false,
                                          true,
                                          false,
                                          false,
                                          'checkBoxText',
                                          'EDIT HOMETOWN');
                                      Get.toNamed(krEdit);
                                    },
                                    deleteButtonText: 'Delete Address',
                                    deleteOnPressed: () {
                                      _profileController.homeTown.value = '';
                                      Get.back();
                                    },
                                  ));
                            },
                          ),
                        ),
                      kH16sizedBox,
                      RowTextButton(
                        text: 'Present Address',
                        buttonText: 'Add City',
                        showAddButton: true,
                        onPressedAdd: () {
                          _profileController.setEditPageValue('Add Present Address', BipHip.location, _profileController.presentAddressTextEditingController,
                              'Add location', true, true, true, false, 'Currently living here', 'ADD PRESENT');
                          Get.toNamed(krEdit);
                        },
                        buttonWidth: 108,
                      ),
                      if (_profileController.cityList.isNotEmpty) kH12sizedBox,
                      if (_profileController.cityList.isNotEmpty)
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: _profileController.cityList.length,
                            itemBuilder: (context, index) {
                              var item = _profileController.cityList[index];
                              return InfoContainer(
                                prefixIcon: BipHip.location,
                                suffixIcon: BipHip.edit,
                                text: item,
                                suffixOnPressed: () {
                                  // _profileController.cityList.remove(_profileController.cityList[index]);
                                  _globalController.blankBottomSheet(
                                      context: context,
                                      isScrollControlled: false,
                                      bottomSheetHeight: 150,
                                      content: EditModalSheet(
                                        editButtonText: 'Edit Address',
                                        editOnPressed: () {
                                           _profileController.setEditPageValue('Edit Present Address', BipHip.location, _profileController.presentAddressTextEditingController, 'Edit location', true, true, true, _profileController.isCurrentlyLiveHere.value, 'Currently living here','EDIT PRESENT');
                                        },
                                        deleteButtonText: 'Delete Address',
                                        deleteOnPressed: () {
                                          _profileController.cityList.remove(_profileController.cityList[index]);
                                          Get.back();
                                        },
                                      ));
                                },
                              );
                            }),
                      // if (_profileController.showEditAddress.value) kH16sizedBox,
                      // if (_profileController.showEditAddress.value)
                      //   CustomModifiedTextField(
                      //     controller: _profileController.presentAddressTextEditingController,
                      //     hint: 'Enter city',
                      //     prefixIcon: BipHip.location,
                      //     suffixIcon: BipHip.circleCrossNew,
                      //     borderRadius: k8BorderRadius,
                      //     onSuffixPress: () {
                      //       _profileController.presentAddressTextEditingController.clear();
                      //     },
                      //   ),
                      //if (_profileController.showEditAddress.value)
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: k16Padding),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       SizedBox(
                      //         width: (width / 2) - 30,
                      //         child: CustomSelectionButton(
                      //           prefixIcon: BipHip.calendarFill,
                      //           onPressed: () {
                      //             showModalBottomSheet(
                      //                 context: context,
                      //                 builder: (context) {
                      //                   return SizedBox(
                      //                     height: height * 0.4,
                      //                     child: CupertinoDatePicker(
                      //                       mode: CupertinoDatePickerMode.monthYear,
                      //                       onDateTimeChanged: (value) {
                      //                         _profileController.startDateAddress.value = value.year.toString();
                      //                       },
                      //                     ),
                      //                   );
                      //                 });
                      //           },
                      //           text: _profileController.startDateAddress.value,
                      //           hintText: 'Start Date',
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         width: (width / 2) - 30,
                      //         child: CustomSelectionButton(
                      //           prefixIcon: BipHip.calendarFill,
                      //           onPressed: () {
                      //             showModalBottomSheet(
                      //                 context: context,
                      //                 builder: (context) {
                      //                   return SizedBox(
                      //                     height: height * 0.4,
                      //                     child: CupertinoDatePicker(
                      //                       mode: CupertinoDatePickerMode.monthYear,
                      //                       onDateTimeChanged: (value) {
                      //                         _profileController.endDateAddress.value = value.year.toString();
                      //                       },
                      //                     ),
                      //                   );
                      //                 });
                      //           },
                      //           text: _profileController.endDateAddress.value,
                      //           hintText: 'End Date',
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // if (_profileController.showEditAddress.value)
                      //   Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       OutLinedButton(
                      //         buttonWidth: 80,
                      //         buttonHeight: 25,
                      //         onPress: () {},
                      //         buttonText: 'Public',
                      //         buttonTextStyle: semiBold12TextStyle(cBlackColor),
                      //         borderColor: cLineColor,
                      //         suffixWidget: const Padding(
                      //           padding: EdgeInsets.only(right: k8Padding),
                      //           child: Icon(
                      //             BipHip.world,
                      //             color: cIconColor,
                      //             size: kIconSize16,
                      //           ),
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         width: 145,
                      //         child: CustomCheckBox(
                      //             value: _profileController.isCurrentlyLiveHere.value,
                      //             label: "Currently live here",
                      //             onChanged: (v) {
                      //               _profileController.isCurrentlyLiveHere.value = !_profileController.isCurrentlyLiveHere.value;
                      //             },
                      //             textStyle: regular14TextStyle(cBlackColor)),
                      //       )
                      //     ],
                      //   ),
                      // if (_profileController.showEditAddress.value)
                      //   Padding(
                      //     padding: const EdgeInsets.symmetric(vertical: k10Padding),
                      //     child: CancelSaveButton(
                      //       onPressedCancel: () {
                      //         _profileController.showEditAddress.value = false;
                      //       },
                      //       onPressedSave: () {
                      //         _profileController.cityList.add(_profileController.presentAddressTextEditingController.text.trim());
                      //         _profileController.showEditAddress.value = false;
                      //         _profileController.presentAddressTextEditingController.clear();
                      //       },
                      //     ),
                      //   ),
                      kH20sizedBox,
                      const CustomDivider(),
                      kH20sizedBox,
                      Text(
                        'Relationship Status',
                        style: semiBold18TextStyle(cBlackColor),
                      ),
                      kH20sizedBox,
                      CustomSelectionButton(
                        prefixIcon: BipHip.love,
                        onPressed: () {
                          _profileController.showEditRelationshipStatus.value = true;
                          _globalController.commonBottomSheet(
                            context: context,
                            content: _RelationshipStatusListContent(
                              profileController: _profileController,
                            ),
                            isScrollControlled: true,
                            bottomSheetHeight: height * 0.6,
                            onPressCloseButton: () {
                              Get.back();
                            },
                            onPressRightButton: null,
                            rightText: '',
                            rightTextStyle: regular10TextStyle(cBlackColor),
                            title: 'Select Relationship Status',
                            isRightButtonShow: false,
                          );
                        },
                        text: _profileController.relationshipStatus.value,
                        hintText: 'Select Relationship Status',
                      ),
                      if (_profileController.showEditRelationshipStatus.value) kH20sizedBox,
                      if (_profileController.showEditRelationshipStatus.value)
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
                      if (_profileController.showEditRelationshipStatus.value) kH20sizedBox,
                      if (_profileController.showEditRelationshipStatus.value)
                        CancelSaveButton(
                          onPressedCancel: () {
                            _profileController.showEditRelationshipStatus.value = false;
                          },
                          onPressedSave: () {
                            _profileController.showEditRelationshipStatus.value = false;
                          },
                        ),
                      kH20sizedBox,
                      const CustomDivider(),
                      kH20sizedBox,
                      RowTextButton(
                        text: 'Education Background',
                        buttonText: 'Add School',
                        showAddButton: _profileController.showAddSchool.value,
                        onPressedAdd: () {
                          _profileController.showAddSchool.value = !_profileController.showAddSchool.value;
                        },
                        buttonWidth: 126,
                      ),
                      CustomSelectionButton(
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
                      kH16sizedBox,
                      CustomModifiedTextField(
                        controller: _profileController.educationInstituteTextEditingController,
                        hint: 'Institute name',
                        prefixIcon: BipHip.schoolNew,
                        suffixIcon: BipHip.circleCrossNew,
                        borderRadius: k8BorderRadius,
                        onSuffixPress: () {
                          _profileController.educationInstituteTextEditingController.clear();
                        },
                      ),
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
                                              _profileController.joiningYearEducation.value = value.year.toString();
                                            },
                                          ),
                                        );
                                      });
                                },
                                text: _profileController.joiningYearEducation.value,
                                hintText: 'Joining Year',
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
                                              _profileController.leavingYearEducation.value = value.year.toString();
                                            },
                                          ),
                                        );
                                      });
                                },
                                text: _profileController.leavingYearEducation.value,
                                hintText: 'Leaving Year',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: CustomCheckBox(
                            value: _profileController.isCurrentlyStudyingHere.value,
                            label: "Currently studying here",
                            onChanged: (v) {
                              _profileController.isCurrentlyStudyingHere.value = !_profileController.isCurrentlyStudyingHere.value;
                            },
                            textStyle: regular14TextStyle(cBlackColor)),
                      )
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

class InfoContainer extends StatelessWidget {
  const InfoContainer({super.key, required this.prefixIcon, required this.suffixIcon, required this.text, this.suffixOnPressed});
  final IconData prefixIcon;
  final IconData suffixIcon;
  final String text;
  final VoidCallback? suffixOnPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(borderRadius: k8CircularBorderRadius, color: cGreyBoxColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: k8Padding),
        child: Row(
          children: [
            Transform.scale(
              scale: .85,
              child: Icon(
                prefixIcon,
                color: cIconColor,
                size: screenWiseSize(kIconSize20, 4),
              ),
            ),
            kW8sizedBox,
            Text(
              text,
              style: regular16TextStyle(cIconColor),
            ),
            const Spacer(),
            CustomIconButton(
              onPress: suffixOnPressed,
              icon: suffixIcon,
              hasBorder: false,
              size: screenWiseSize(kIconSize20, 4),
            )
          ],
        ),
      ),
    );
  }
}

class CancelSaveButton extends StatelessWidget {
  const CancelSaveButton({super.key, required this.onPressedCancel, required this.onPressedSave});
  final VoidCallback onPressedCancel, onPressedSave;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomElevatedButton(
            label: 'Cancel',
            textStyle: semiBold14TextStyle(cRedColor),
            buttonColor: cWhiteColor,
            borderColor: cRedColor,
            buttonHeight: h32,
            buttonWidth: 80,
            onPressed: onPressedCancel),
        kW16sizedBox,
        CustomElevatedButton(label: 'Save', textStyle: semiBold14TextStyle(cWhiteColor), buttonHeight: h32, buttonWidth: 80, onPressed: onPressedSave),
      ],
    );
  }
}

class _RelationshipStatusListContent extends StatelessWidget {
  const _RelationshipStatusListContent({
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
          itemCount: profileController.relationshipStatusList.length,
          itemBuilder: (BuildContext context, int index) {
            return Obx(() => RadioListTile(
                  title: Text(profileController.relationshipStatusList[index]),
                  value: profileController.relationshipStatusList[index],
                  activeColor: cPrimaryColor,
                  contentPadding: EdgeInsets.zero,
                  groupValue: profileController.relationshipStatus.value,
                  controlAffinity: ListTileControlAffinity.trailing,
                  onChanged: (value) {
                    profileController.relationshipStatus.value = value;
                  },
                ));
          },
        ),
      ],
    );
  }
}

class RowTextButton extends StatelessWidget {
  const RowTextButton({super.key, required this.text, required this.buttonText, required this.showAddButton, this.onPressedAdd, required this.buttonWidth});
  final String text, buttonText;
  final bool showAddButton;
  final VoidCallback? onPressedAdd;
  final double buttonWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: semiBold16TextStyle(cBlackColor),
        ),
        if (showAddButton)
          OutLinedButton(
            buttonText: buttonText,
            buttonTextStyle: semiBold14TextStyle(cPrimaryColor),
            borderColor: cWhiteColor,
            onPress: onPressedAdd,
            buttonWidth: buttonWidth,
            suffixWidget: const Padding(
              padding: EdgeInsets.only(right: k8Padding),
              child: Icon(
                BipHip.addNew,
                color: cPrimaryColor,
              ),
            ),
          )
      ],
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

class EditModalSheet extends StatelessWidget {
  const EditModalSheet({super.key, this.editOnPressed, this.deleteOnPressed, required this.editButtonText, required this.deleteButtonText});
  final VoidCallback? editOnPressed, deleteOnPressed;
  final String editButtonText, deleteButtonText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomElevatedButton(
          onPressed: editOnPressed,
          label: editButtonText,
          buttonColor: cWhiteColor,
          borderColor: cBlackColor,
          buttonWidth: width - 40,
          textStyle: semiBold14TextStyle(cBlackColor),
          prefixIcon: BipHip.edit,
          prefixIconColor: cBlackColor,
        ),
        kH12sizedBox,
        CustomElevatedButton(
          onPressed: deleteOnPressed,
          label: deleteButtonText,
          buttonColor: cWhiteColor,
          borderColor: cBlackColor,
          buttonWidth: width - 40,
          textStyle: semiBold14TextStyle(cBlackColor),
          prefixIcon: BipHip.delete,
          prefixIconColor: cBlackColor,
        ),
      ],
    );
  }
}
