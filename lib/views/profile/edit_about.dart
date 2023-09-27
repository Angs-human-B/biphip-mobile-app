import 'package:bip_hip/controllers/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/custom_outline_button.dart';
import 'package:bip_hip/widgets/common/custom_selection_button.dart';
import 'package:flutter/cupertino.dart';

class EditAboutInfo extends StatelessWidget {
  EditAboutInfo({super.key});

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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Present Address',
                            style: semiBold16TextStyle(cBlackColor),
                          ),
                          if (!_profileController.showEditAddress.value)
                            OutLinedButton(
                              buttonText: 'Add City',
                              buttonTextStyle: semiBold14TextStyle(cPrimaryColor),
                              borderColor: cWhiteColor,
                              onPress: () {
                                _profileController.showEditAddress.value = !_profileController.showEditAddress.value;
                              },
                              buttonWidth: 108,
                              suffixWidget: const Padding(
                                padding: EdgeInsets.only(right: k8Padding),
                                child: Icon(
                                  BipHip.addNew,
                                  color: cPrimaryColor,
                                ),
                              ),
                            )
                        ],
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
