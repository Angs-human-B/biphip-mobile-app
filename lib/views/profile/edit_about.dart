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
                      Text(
                        'Hometown',
                        style: semiBold16TextStyle(cBlackColor),
                      ),
                      kH10sizedBox,
                      CustomModifiedTextField(
                        controller: _profileController.homeTownTextEditingController,
                        hint: 'Hometown',
                        prefixIcon: BipHip.location,
                        suffixIcon: BipHip.circleCrossNew,
                        borderRadius: k8BorderRadius,
                        onSuffixPress: () {
                          _profileController.homeTownTextEditingController.clear();
                        },
                      ),
                      kH24sizedBox,
                      RowTextButton(
                        text: 'Present Address',
                        buttonText: 'Add City',
                        showAddButton: _profileController.showEditAddress.value,
                        onPressedAdd: () {
                          _profileController.showEditAddress.value = !_profileController.showEditAddress.value;
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
                                suffixIcon: BipHip.circleCrossNew,
                                text: item,
                                suffixOnPressed: () {
                                  _profileController.cityList.remove(_profileController.cityList[index]);
                                },
                              );
                            }),
                      if (_profileController.showEditAddress.value) kH16sizedBox,
                      if (_profileController.showEditAddress.value)
                        CustomModifiedTextField(
                          controller: _profileController.presentAddressTextEditingController,
                          hint: 'Enter city',
                          prefixIcon: BipHip.location,
                          suffixIcon: BipHip.circleCrossNew,
                          borderRadius: k8BorderRadius,
                          onSuffixPress: () {
                            _profileController.presentAddressTextEditingController.clear();
                          },
                        ),
                      if (_profileController.showEditAddress.value)
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
                                                _profileController.startDateAddress.value = value.toString();
                                              },
                                            ),
                                          );
                                        });
                                  },
                                  text: _profileController.startDateAddress.value,
                                  hintText: 'Start date',
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
                                                _profileController.endDateAddress.value = value.toString();
                                              },
                                            ),
                                          );
                                        });
                                  },
                                  text: _profileController.endDateAddress.value,
                                  hintText: 'End date',
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (_profileController.showEditAddress.value)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                            SizedBox(
                              width: 145,
                              child: CustomCheckBox(
                                  value: _profileController.isCurrentlyLiveHere.value,
                                  label: "Currently live here",
                                  onChanged: (v) {
                                    _profileController.isCurrentlyLiveHere.value = !_profileController.isCurrentlyLiveHere.value;
                                  },
                                  textStyle: regular14TextStyle(cBlackColor)),
                            )
                          ],
                        ),
                      if (_profileController.showEditAddress.value)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: k10Padding),
                          child: CancelSaveButton(
                            onPressedCancel: () {
                              _profileController.showEditAddress.value = false;
                            },
                            onPressedSave: () {
                              _profileController.cityList.add(_profileController.presentAddressTextEditingController.text.trim());
                              _profileController.showEditAddress.value = false;
                              _profileController.presentAddressTextEditingController.clear();
                            },
                          ),
                        ),
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
                        hintText: 'Select ',
                      ),
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
        padding: const EdgeInsets.symmetric(horizontal: k12Padding),
        child: Row(
          children: [
            Icon(
              prefixIcon,
              color: cIconColor,
            ),
            kW8sizedBox,
            Text(
              text,
              style: regular14TextStyle(cBlackColor),
            ),
            const Spacer(),
            InkWell(
                onTap: suffixOnPressed,
                child: Icon(
                  suffixIcon,
                  color: cIconColor,
                )),
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
        if (!showAddButton)
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
