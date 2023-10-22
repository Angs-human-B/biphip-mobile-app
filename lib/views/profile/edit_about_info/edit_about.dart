import 'package:bip_hip/controllers/authentication_controller.dart';
import 'package:bip_hip/controllers/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/auth/register/select_gender.dart';
import 'package:bip_hip/views/profile/edit_profile.dart';
import 'package:bip_hip/views/profile/profile_widgets/gallery_photos.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';
import 'package:bip_hip/widgets/common/button/custom_modified_text_button.dart';
import 'package:bip_hip/widgets/common/button/custom_selection_button.dart';
import 'package:bip_hip/widgets/common/common_shimmer.dart';
import 'package:intl/intl.dart';

class EditAboutInfo extends StatelessWidget {
  EditAboutInfo({super.key});

  final ProfileController _profileController = Get.find<ProfileController>();
  final AuthenticationController _authenticationController = Get.find<AuthenticationController>();
  final GlobalController _globalController = Get.find<GlobalController>();

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
                  child: CustomAppBar(
                    appBarColor: cWhiteColor,
                    title: ksAbout.tr,
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
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kH10sizedBox,
                          Text(
                            ksAddress.tr,
                            style: semiBold18TextStyle(cBlackColor),
                          ),
                          kH20sizedBox,
                          RowTextButton(
                            text: ksHomeTown.tr,
                            buttonText: ksAdd.tr,
                            showAddButton: _profileController.hometownData.value == null ? true : false,
                            buttonWidth: 151,
                            onPressedAdd: () async {
                              _profileController.resetTextEditor();
                              _profileController.getCityList();
                              _profileController.getMethod(9);
                            },
                          ),
                          // for (int i = 0; i < _profileController.otherCityList.length; i++)
                          if (_profileController.hometownData.value != null)
                            Padding(
                              padding: const EdgeInsets.only(top: k10Padding),
                              child: InfoContainer(
                                prefixIcon: BipHip.location,
                                suffixIcon: BipHip.edit,
                                text: checkNullOrStringNull(_profileController.hometownData.value?.city),
                                suffixOnPressed: () async {
                                  _profileController.enableSaveButton.value = true;
                                  _profileController.getMethod(0);
                                  _profileController.getCityList();
                                  // _globalController.commonBottomSheet(
                                  //     context: context,
                                  //     isScrollControlled: false,
                                  //     bottomSheetHeight: isDeviceScreenLarge() ? 180 : 160,
                                  //     content: EditModalSheet(
                                  //       editButtonText: ksEditAddress.tr,
                                  //       editOnPressed: () {
                                  //         _profileController.getMethod(0);
                                  //       },
                                  //       deleteButtonText: ksDeleteAddress.tr,
                                  //       deleteOnPressed: () async {
                                  //         Get.back();
                                  //         await _profileController.deleteCity(_profileController.hometownData.value!.id);
                                  //       },
                                  //     ),
                                  //     onPressCloseButton: () {
                                  //       Get.back();
                                  //     },
                                  //     onPressRightButton: null,
                                  //     rightText: '',
                                  //     rightTextStyle: regular10TextStyle(cBlackColor),
                                  //     title: ksEdit.tr,
                                  //     isRightButtonShow: false);
                                },
                              ),
                            ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: k16Padding),
                            child: RowTextButton(
                              text: ksPresentAddress.tr,
                              buttonText: ksAdd.tr,
                              showAddButton: _profileController.currentCityData.value == null ? true : false,
                              onPressedAdd: () async {
                                _profileController.resetTextEditor();
                                _profileController.getMethod(1);
                                Get.toNamed(krEdit);
                                _profileController.getCityList();
                              },
                              buttonWidth: 108,
                            ),
                          ),
                          // for (int i = 0; i < _profileController.otherCityList.length; i++)
                          if (_profileController.currentCityData.value != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: h16),
                              child: InfoContainer(
                                prefixIcon: BipHip.location,
                                suffixIcon: BipHip.edit,
                                text: checkNullOrStringNull(_profileController.currentCityData.value!.city),
                                suffixOnPressed: () async {
                                  _profileController.enableSaveButton.value = true;
                                  _profileController.isCurrentlyLiveHere.value = true;
                                  _profileController.cityID.value = _profileController.currentCityData.value!.id!;
                                  _profileController.getMethod(2);
                                  _profileController.getCityList();

                                  // _globalController.commonBottomSheet(
                                  //     context: context,
                                  //     isScrollControlled: false,
                                  //     bottomSheetHeight: isDeviceScreenLarge() ? 180 : 160,
                                  //     onPressCloseButton: () {
                                  //       Get.back();
                                  //     },
                                  //     onPressRightButton: null,
                                  //     rightText: '',
                                  //     rightTextStyle: regular10TextStyle(cBlackColor),
                                  //     title: ksEdit.tr,
                                  //     isRightButtonShow: false,
                                  //     content: EditModalSheet(
                                  //       editButtonText: ksEditAddress.tr,
                                  //       editOnPressed: () {
                                  //         _profileController.cityID.value = _profileController.currentCityData.value!.id!;
                                  //         _profileController.isCurrentlyLiveHere.value = true;
                                  //         _profileController.getMethod(2);
                                  //       },
                                  //       deleteButtonText: ksDeleteAddress.tr,
                                  //       deleteOnPressed: () async {
                                  //         _profileController.deleteCity(_profileController.currentCityData.value!.id!);

                                  //         Get.back();
                                  //       },
                                  //     ));
                                },
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: k16Padding),
                            child: RowTextButton(
                              text: ksOther.tr,
                              buttonText: ksAdd.tr,
                              showAddButton: true,
                              onPressedAdd: () async {
                                _profileController.resetTextEditor();

                                _profileController.getMethod(3);
                                Get.toNamed(krEdit);
                                _profileController.getCityList();
                              },
                              buttonWidth: 108,
                            ),
                          ),
                          for (int i = 0; i < _profileController.otherCityList.length; i++)
                            if (_profileController.otherCityList[i].isCurrent == 0 && _profileController.otherCityList[i].isHometown == 0)
                              Padding(
                                padding: const EdgeInsets.only(bottom: k10Padding),
                                child: InfoContainer(
                                  prefixIcon: BipHip.location,
                                  suffixIcon: BipHip.edit,
                                  text: _profileController.otherCityList[i].city!,
                                  suffixOnPressed: () async {
                                    _profileController.cityID.value = _profileController.otherCityList[i].id!;
                                    _profileController.presentAddressTextEditingController.text = _profileController.otherCityList[i].city!;
                                    _profileController.enableSaveButton.value = true;
                                    _profileController.getMethod(4);
                                    _profileController.getCityList();
                                    // _globalController.commonBottomSheet(
                                    //     context: context,
                                    //     isScrollControlled: false,
                                    //     bottomSheetHeight: isDeviceScreenLarge() ? 180 : 160,
                                    //     onPressCloseButton: () {
                                    //       Get.back();
                                    //     },
                                    //     onPressRightButton: null,
                                    //     rightText: '',
                                    //     rightTextStyle: regular10TextStyle(cBlackColor),
                                    //     title: ksEdit.tr,
                                    //     isRightButtonShow: false,
                                    //     content: EditModalSheet(
                                    //       editButtonText: ksEditAddress.tr,
                                    //       editOnPressed: () {
                                    //         // _profileController.cityListIndex.value = index;
                                    //         _profileController.presentAddressTextEditingController.text = _profileController.otherCityList[i].city!;
                                    //         _profileController.getMethod(4);
                                    //       },
                                    //       deleteButtonText: ksDeleteAddress.tr,
                                    //       deleteOnPressed: () async {
                                    //         _profileController.deleteCity(_profileController.otherCityList[i].id);
                                    //         Get.back();
                                    //       },
                                    //     ));
                                  },
                                ),
                              ),
                          const CustomDivider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: k16Padding),
                            child: RowTextButton(
                              text: ksEducationalBackground.tr,
                              textStyle: semiBold18TextStyle(cBlackColor),
                              buttonText: ksAdd.tr,
                              showAddButton: true,
                              onPressedAdd: () {
                                _profileController.resetTextEditor();
                                _profileController.getMethod(5);
                                _profileController.getSchoolList();
                              },
                              buttonWidth: 126,
                            ),
                          ),
                          if (_profileController.schoolDataList.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(bottom: k16Padding),
                              child: Text(
                                ksSchool.tr,
                                style: semiBold16TextStyle(cBlackColor),
                              ),
                            ),
                          for (int i = 0; i < _profileController.schoolDataList.length; i++)
                            Padding(
                              padding: const EdgeInsets.only(bottom: k10Padding),
                              child: InfoContainer(
                                prefixIcon: BipHip.schoolNew,
                                suffixIcon: BipHip.edit,
                                text: checkNullOrStringNull(_profileController.schoolDataList[i].school),
                                suffixOnPressed: () {
                                  _profileController.resetTextEditor();
                                  _profileController.enableSaveButton.value = true;
                                  if (_profileController.schoolDataList[i].started != null) {
                                    _profileController.tempSchoolStartDate.value =
                                        DateFormat("yyyy-MM-dd").format(_profileController.schoolDataList[i].started!);
                                  }
                                  if (_profileController.schoolDataList[i].ended != null) {
                                    _profileController.tempSchoolEndDate.value = DateFormat("yyyy-MM-dd").format(_profileController.schoolDataList[i].ended!);
                                  }
                                  _profileController.schoolID.value = _profileController.schoolDataList[i].id!;
                                  _profileController.educationInstituteTextEditingController.text = _profileController.schoolDataList[i].school!;
                                  if (_profileController.schoolDataList[i].graduated == 0) {
                                    _profileController.isCurrentlyStudyingHere.value = true;
                                  } else {
                                    _profileController.isCurrentlyStudyingHere.value = false;
                                  }
                                  _profileController.getMethod(6);
                                  _profileController.getSchoolList();
                                },
                              ),
                            ),
                          if (_profileController.collegeDataList.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(bottom: k16Padding),
                              child: Text(
                                ksCollege.tr,
                                style: semiBold16TextStyle(cBlackColor),
                              ),
                            ),
                          for (int i = 0; i < _profileController.collegeDataList.length; i++)
                            Padding(
                              padding: const EdgeInsets.only(bottom: k10Padding),
                              child: InfoContainer(
                                prefixIcon: BipHip.schoolNew,
                                suffixIcon: BipHip.edit,
                                text: checkNullOrStringNull(_profileController.collegeDataList[i].school),
                                suffixOnPressed: () {
                                  _profileController.resetTextEditor();
                                  _profileController.enableSaveButton.value = true;
                                  if (_profileController.collegeDataList[i].started != null) {
                                    _profileController.tempSchoolStartDate.value =
                                        DateFormat("yyyy-MM-dd").format(_profileController.collegeDataList[i].started!);
                                  }
                                  if (_profileController.collegeDataList[i].ended != null) {
                                    _profileController.tempSchoolEndDate.value = DateFormat("yyyy-MM-dd").format(_profileController.collegeDataList[i].ended!);
                                  }
                                  _profileController.collegeID.value = _profileController.collegeDataList[i].id!;
                                  _profileController.educationInstituteTextEditingController.text = _profileController.collegeDataList[i].school!;
                                  if (_profileController.collegeDataList[i].graduated == 0) {
                                    _profileController.isCurrentlyStudyingHere.value = true;
                                  } else {
                                    _profileController.isCurrentlyStudyingHere.value = false;
                                  }
                                  _profileController.getMethod(7);
                                  _profileController.getSchoolList();
                                  // _globalController.commonBottomSheet(
                                  //     context: context,
                                  //     isScrollControlled: false,
                                  //     bottomSheetHeight: isDeviceScreenLarge() ? 180 : 160,
                                  //     onPressCloseButton: () {
                                  //       Get.back();
                                  //     },
                                  //     onPressRightButton: null,
                                  //     rightText: '',
                                  //     rightTextStyle: regular10TextStyle(cBlackColor),
                                  //     title: ksEdit,
                                  //     isRightButtonShow: false,
                                  //     content: EditModalSheet(
                                  //       editButtonText: ksEditCollege.tr,
                                  //       editOnPressed: () {
                                  //         _profileController.collegeID.value = _profileController.collegeDataList[i].id!;
                                  //         _profileController.educationInstituteTextEditingController.text = _profileController.collegeDataList[i].school!;
                                  //         if (_profileController.collegeDataList[i].graduated == 1) {
                                  //           _profileController.isCurrentlyStudyingHere.value = true;
                                  //         } else {
                                  //           _profileController.isCurrentlyStudyingHere.value = false;
                                  //         }
                                  //         _profileController.getMethod(7);
                                  //       },
                                  //       deleteButtonText: ksDeleteCollege.tr,
                                  //       deleteOnPressed: () {
                                  //         Get.back();
                                  //         _profileController.deleteCollege(_profileController.collegeDataList[i].id);
                                  //       },
                                  //     ));
                                },
                              ),
                            ),
                          const CustomDivider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: k16Padding),
                            child: Text(
                              ksRelationshipStatus.tr,
                              style: semiBold18TextStyle(cBlackColor),
                            ),
                          ),
                          CustomSelectionButton(
                            prefixIcon: BipHip.love,
                            onPressed: () async {
                              _profileController.isRelationListLoading.value = true;
                              if (_profileController.relationshipStatus.value != '') {
                                _profileController.tempRelationshipStatus.value = _profileController.relationshipStatus.value;
                              } else if (_profileController.userData.value!.relation != null) {
                                _profileController.tempRelationshipStatus.value = checkNullOrStringNull(_profileController.userData.value!.relation);
                              }
                              ll("value : ${_profileController.tempRelationshipStatus.value}");
                              _globalController.commonBottomSheet(
                                context: context,
                                content: Obx(
                                  () => _profileController.isRelationListLoading.value
                                      ? const _RelationshipStatusListShimmer()
                                      : _RelationshipStatusListContent(
                                          profileController: _profileController,
                                        ),
                                ),
                                isScrollControlled: true,
                                bottomSheetHeight: height * 0.6,
                                onPressCloseButton: () {
                                  Get.back();
                                },
                                onPressRightButton: () {
                                  if (_profileController.tempRelationshipStatus.value != '') {
                                    _profileController.relationshipStatus.value = _profileController.tempRelationshipStatus.value;
                                    _profileController.showEditRelationshipStatus.value = true;
                                  }
                                  Get.back();
                                },
                                rightText: ksDone.tr,
                                rightTextStyle: medium14TextStyle(cPrimaryColor),
                                title: ksSelectRelationshipStatus.tr,
                                isRightButtonShow: true,
                              );
                              await _profileController.getRelationshipList();
                            },
                            text: _profileController.relationshipStatus.value != ''
                                ? _profileController.relationshipStatus.value
                                : checkNullOrStringNull(_profileController.userData.value!.relation) ?? ksSelectRelationshipStatus,
                            hintText: ksSelectRelationshipStatus.tr,
                          ),
                          // if (_profileController.relationshipStatus.value != '' && _profileController.showEditRelationshipStatus.value) kH20sizedBox,
                          // if (_profileController.relationshipStatus.value != '' && _profileController.showEditRelationshipStatus.value)
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
                          if (_profileController.relationshipStatus.value != '' && _profileController.showEditRelationshipStatus.value) kH20sizedBox,
                          if (_profileController.relationshipStatus.value != '' && _profileController.showEditRelationshipStatus.value)
                            CancelSaveButton(
                              onPressedCancel: () {
                                _profileController.relationshipStatus.value = '';
                                _profileController.showEditRelationshipStatus.value = false;
                              },
                              onPressedSave: () async {
                                _profileController.storeUserSetting('relationship', _profileController.relationshipStatus.value);
                                _profileController.showEditRelationshipStatus.value = false;
                                _profileController.relationshipStatus.value = '';
                              },
                            ),
                          kH16sizedBox,
                          const CustomDivider(),
                          if (_profileController.showAllEditOption.value)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: k16Padding),
                              child: RowTextButton(
                                text: ksGender.tr,
                                buttonText: ksAdd.tr,
                                textStyle: semiBold18TextStyle(cBlackColor),
                                showAddButton: false,
                                onPressedAdd: null,
                                buttonWidth: 149,
                              ),
                            ),
                          if (_profileController.showAllEditOption.value)
                            Padding(
                              padding: const EdgeInsets.only(bottom: k16Padding),
                              child: CustomSelectionButton(
                                prefixIcon: BipHip.gender,
                                onPressed: () async {
                                  _profileController.isGenderListLoading.value = true;
                                  _profileController.tempSelectedGender.value = checkNullOrStringNull(_profileController.userData.value!.gender);
                                  if (_profileController.selectedGender.value != '') {
                                    _profileController.tempSelectedGender.value = _profileController.selectedGender.value;
                                  }

                                  _globalController.commonBottomSheet(
                                    context: context,
                                    content: Obx(
                                      () => _profileController.isGenderListLoading.value
                                          ? const GenderListShimmer()
                                          : GenderListContent(
                                              profileController: _profileController,
                                            ),
                                    ),
                                    isScrollControlled: true,
                                    bottomSheetHeight: isDeviceScreenLarge() ? 255 : 240,
                                    onPressCloseButton: () {
                                      Get.back();
                                    },
                                    onPressRightButton: () {
                                      if (_profileController.tempSelectedGender.value != '') {
                                        _profileController.selectedGender.value = _profileController.tempSelectedGender.value;
                                        _profileController.isGenderSelected.value = true;
                                      }
                                      Get.back();
                                    },
                                    rightText: ksDone.tr,
                                    rightTextStyle: medium14TextStyle(cPrimaryColor),
                                    title: ksSelectGender.tr,
                                    isRightButtonShow: true,
                                  );
                                  await _profileController.getGenderList();
                                },
                                text: _profileController.selectedGender.value != ''
                                    ? _profileController.selectedGender.value
                                    : checkNullOrStringNull(_profileController.userData.value!.gender) ?? ksSelectGender.tr,
                                hintText: ksSelectGender.tr,
                              ),
                            ),
                          if (_profileController.isGenderSelected.value)
                            Padding(
                              padding: const EdgeInsets.only(bottom: k16Padding),
                              child: CancelSaveButton(
                                onPressedCancel: () {
                                  _profileController.selectedGender.value = '';
                                  _profileController.isGenderSelected.value = false;
                                },
                                onPressedSave: () async {
                                  await _profileController.storeUserSetting('gender', _profileController.selectedGender.value);
                                  _profileController.selectedGender.value = '';
                                  _profileController.isGenderSelected.value = false;
                                },
                              ),
                            ),
                          if (_profileController.showAllEditOption.value) const CustomDivider(),
                          if (_profileController.showAllEditOption.value)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: k16Padding),
                              child: RowTextButton(
                                text: ksDateOfBirth.tr,
                                buttonText: ksAdd.tr,
                                textStyle: semiBold18TextStyle(cBlackColor),
                                showAddButton: false,
                                onPressedAdd: null,
                                buttonWidth: 149,
                              ),
                            ),
                          if (_profileController.userData.value!.dob != null && _profileController.showAllEditOption.value)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: InfoContainer(
                                prefixIcon: BipHip.birthday,
                                suffixIcon: BipHip.edit,
                                text: DateFormat("yyyy-MM-dd").format(_profileController.userData.value!.dob!),
                                suffixOnPressed: () {
                                  _authenticationController.birthDay.value = DateFormat("yyyy-MM-dd").format(_profileController.userData.value!.dob!);
                                  _profileController.isRouteFromAboutInfo.value = true;

                                  Get.toNamed(krSelectBirthday);
                                },
                              ),
                            ),
                          if (_profileController.showAllEditOption.value) const CustomDivider(),
                          if (_profileController.showAllEditOption.value)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: k16Padding),
                              child: RowTextButton(
                                text: ksProfession.tr,
                                buttonText: ksAdd.tr,
                                textStyle: semiBold18TextStyle(cBlackColor),
                                showAddButton: _profileController.userData.value!.profession.isEmpty ? true : false,
                                onPressedAdd: () async {
                                  _profileController.isRouteFromAboutInfo.value = true;
                                  _globalController.professionIndex.value = -1;
                                  Get.toNamed(krSelectProfession);
                                  await _profileController.getProfessionList();
                                },
                                buttonWidth: 149,
                              ),
                            ),
                          if (_profileController.userData.value!.profession.isNotEmpty && _profileController.showAllEditOption.value)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: InfoContainer(
                                prefixIcon: BipHip.profession,
                                suffixIcon: BipHip.edit,
                                text: checkNullOrStringNull(_profileController.userData.value!.profession[0]) ?? ksSelectProfession.tr,
                                suffixOnPressed: () async {
                                  _globalController.professionIndex.value = -1;
                                  _profileController.isRouteFromAboutInfo.value = true;
                                  Get.toNamed(krSelectProfession);
                                  await _profileController.getProfessionList();
                                  for (int i = 0; i < _globalController.professionList.length; i++) {
                                    if (_globalController.professionList[i] == _profileController.userData.value!.profession[0]) {
                                      _globalController.professionIndex.value = i;
                                    }
                                  }
                                  ll(_globalController.professionIndex.value);
                                },
                              ),
                            ),
                          if (_profileController.showAllEditOption.value) const CustomDivider(),
                          if (_profileController.showAllEditOption.value)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: k16Padding),
                              child: RowTextButton(
                                text: ksInterest.tr,
                                buttonText: ksAdd.tr,
                                textStyle: semiBold18TextStyle(cBlackColor),
                                suffixWidget: _profileController.userData.value!.interest.isNotEmpty
                                    ? Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: Icon(
                                          BipHip.edit,
                                          color: cIconColor,
                                          size: screenWiseSize(kIconSize22, 4),
                                        ),
                                      )
                                    : null,
                                showAddButton: true,
                                onPressedAdd: () async {
                                  _globalController.interestIndex.clear();
                                  _profileController.isRouteFromAboutInfo.value = true;
                                  Get.toNamed(krSelectInterest);
                                  await _profileController.getInterestList();
                                  for (int j = 0; j < _profileController.userData.value!.interest.length; j++) {
                                    for (int i = 0; i < _globalController.interestList.length; i++) {
                                      if (_globalController.interestList[i] == _profileController.userData.value!.interest[j]) {
                                        _globalController.interestIndex.add(i);
                                      }
                                    }
                                  }
                                },
                                buttonWidth: 149,
                              ),
                            ),
                          if (_profileController.userData.value!.interest.isNotEmpty && _profileController.showAllEditOption.value)
                            Padding(
                              padding: const EdgeInsets.only(bottom: k8Padding),
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                direction: Axis.horizontal,
                                spacing: 8.0,
                                children: [
                                  for (int i = 0; i < _profileController.userData.value!.interest.length; i++)
                                    CustomChoiceChips(
                                      label: _profileController.userData.value!.interest[i],
                                      isSelected: false,
                                      onSelected: null,
                                    )
                                ],
                              ),
                            ),
                          if (_profileController.showAllEditOption.value) const CustomDivider(),
                          kH16sizedBox,
                          Text(
                            ksWork.tr,
                            style: semiBold18TextStyle(cBlackColor),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: k16Padding),
                            child: RowTextButton(
                              text: ksCurrentWorkplace.tr,
                              buttonText: ksAdd.tr,
                              showAddButton: true,
                              onPressedAdd: () async {
                                _profileController.resetTextEditor();
                                _profileController.getMethod(8);
                                _profileController.getCompanyList();
                              },
                              buttonWidth: 149,
                            ),
                          ),
                          if (_profileController.currentWorkplace.value != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: k16Padding),
                              child: InfoContainer(
                                prefixIcon: BipHip.officeFill,
                                suffixIcon: BipHip.edit,
                                text: checkNullOrStringNull(_profileController.currentWorkplace.value!.company),
                                suffixOnPressed: () async {
                                  _profileController.resetTextEditor();
                                  _profileController.enableSaveButton.value = true;
                                  if (_profileController.currentWorkplace.value!.started != null) {
                                    _profileController.tempWorkplaceStartDate.value =
                                        DateFormat("yyyy-MM-dd").format(_profileController.currentWorkplace.value!.started!);
                                  }
                                  if (_profileController.currentWorkplace.value!.ended != null) {
                                    _profileController.tempWorkplaceEndDate.value =
                                        DateFormat("yyyy-MM-dd").format(_profileController.currentWorkplace.value!.ended!);
                                  }
                                  _profileController.officeID.value = _profileController.currentWorkplace.value!.id!;
                                  _profileController.companyNameTextEditingController.text = _profileController.currentWorkplace.value!.company!;
                                  _profileController.designationTextEditingController.text = _profileController.currentWorkplace.value!.position ?? '';
                                  if (_profileController.currentWorkplace.value!.isCurrent == 1) {
                                    _profileController.isCurrentlyWorkingHere.value = true;
                                  } else {
                                    _profileController.isCurrentlyWorkingHere.value = false;
                                  }
                                  _profileController.getMethod(10);
                                  _profileController.getCompanyList();
                                  // _globalController.commonBottomSheet(
                                  //     isScrollControlled: false,
                                  //     bottomSheetHeight: isDeviceScreenLarge() ? 180 : 160,
                                  //     onPressCloseButton: () {
                                  //       Get.back();
                                  //     },
                                  //     onPressRightButton: null,
                                  //     rightText: '',
                                  //     rightTextStyle: regular10TextStyle(cBlackColor),
                                  //     title: ksEdit.tr,
                                  //     isRightButtonShow: false,
                                  //     context: context,
                                  //     content: EditModalSheet(
                                  //       editButtonText: ksEditWorkplace.tr,
                                  //       editOnPressed: () {
                                  //         _profileController.officeID.value = _profileController.currentWorkplace.value!.id!;
                                  //         _profileController.companyNameTextEditingController.text = _profileController.currentWorkplace.value!.company!;
                                  //         _profileController.designationTextEditingController.text = _profileController.currentWorkplace.value!.position ?? '';
                                  //         if (_profileController.currentWorkplace.value!.isCurrent == 1) {
                                  //           _profileController.isCurrentlyWorkingHere.value = true;
                                  //         } else {
                                  //           _profileController.isCurrentlyWorkingHere.value = false;
                                  //         }
                                  //         _profileController.getMethod(10);
                                  //       },
                                  //       deleteButtonText: ksDeleteWorkplace.tr,
                                  //       deleteOnPressed: () async {
                                  //         Get.back();
                                  //         await _profileController.deleteWork(_profileController.currentWorkplace.value!.id);
                                  //       },
                                  //     ));
                                },
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: k16Padding),
                            child: RowTextButton(
                              text: ksOther.tr,
                              buttonText: ksAdd.tr,
                              showAddButton: true,
                              onPressedAdd: () async {
                                _profileController.resetTextEditor();
                                _profileController.getMethod(8);
                                _profileController.getCompanyList();
                              },
                              buttonWidth: 149,
                            ),
                          ),
                          for (int i = 0; i < _profileController.workplaceDataList.length; i++)
                            if (_profileController.workplaceDataList[i].isCurrent != 1)
                              Padding(
                                padding: const EdgeInsets.only(bottom: k10Padding),
                                child: InfoContainer(
                                  prefixIcon: BipHip.officeFill,
                                  suffixIcon: BipHip.edit,
                                  text: _profileController.workplaceDataList[i].company!,
                                  suffixOnPressed: () async {
                                    _profileController.resetTextEditor();
                                    _profileController.enableSaveButton.value = true;
                                    _profileController.getCompanyList();
                                    if (_profileController.workplaceDataList[i].started != null) {
                                      _profileController.tempWorkplaceStartDate.value =
                                          DateFormat("yyyy-MM-dd").format(_profileController.workplaceDataList[i].started!);
                                    }
                                    if (_profileController.workplaceDataList[i].ended != null) {
                                      _profileController.tempWorkplaceEndDate.value =
                                          DateFormat("yyyy-MM-dd").format(_profileController.workplaceDataList[i].ended!);
                                    }
                                    _profileController.officeID.value = _profileController.workplaceDataList[i].id!;
                                    _profileController.companyNameTextEditingController.text = _profileController.workplaceDataList[i].company!;
                                    _profileController.designationTextEditingController.text = _profileController.workplaceDataList[i].position ?? '';
                                    if (_profileController.workplaceDataList[i].isCurrent == 1) {
                                      _profileController.isCurrentlyWorkingHere.value = true;
                                    } else {
                                      _profileController.isCurrentlyWorkingHere.value = false;
                                    }
                                    _profileController.getMethod(10);
                                    // _globalController.commonBottomSheet(
                                    //     isScrollControlled: false,
                                    //     bottomSheetHeight: isDeviceScreenLarge() ? 180 : 160,
                                    //     onPressCloseButton: () {
                                    //       Get.back();
                                    //     },
                                    //     onPressRightButton: null,
                                    //     rightText: '',
                                    //     rightTextStyle: regular10TextStyle(cBlackColor),
                                    //     title: ksEdit.tr,
                                    //     isRightButtonShow: false,
                                    //     context: context,
                                    //     content: EditModalSheet(
                                    //       editButtonText: ksEditWorkplace.tr,
                                    //       editOnPressed: () {
                                    //         _profileController.officeID.value = _profileController.workplaceDataList[i].id!;
                                    //         _profileController.companyNameTextEditingController.text = _profileController.workplaceDataList[i].company!;
                                    //         _profileController.designationTextEditingController.text = _profileController.workplaceDataList[i].position ?? '';
                                    //         if (_profileController.workplaceDataList[i].isCurrent == 1) {
                                    //           _profileController.isCurrentlyWorkingHere.value = true;
                                    //         } else {
                                    //           _profileController.isCurrentlyWorkingHere.value = false;
                                    //         }
                                    //         _profileController.getMethod(10);
                                    //       },
                                    //       deleteButtonText: ksDeleteWorkplace.tr,
                                    //       deleteOnPressed: () async {
                                    //         Get.back();
                                    //         await _profileController.deleteWork(_profileController.workplaceDataList[i].id);
                                    //       },
                                    //     ));
                                  },
                                ),
                              ),
                          if (_profileController.showAllEditOption.value) const CustomDivider(),
                          if (_profileController.showAllEditOption.value) kH16sizedBox,
                          if (_profileController.showAllEditOption.value)
                            Padding(
                              padding: const EdgeInsets.only(bottom: k16Padding),
                              child: Text(
                                ksContactDetails.tr,
                                style: semiBold18TextStyle(cBlackColor),
                              ),
                            ),
                          if (_profileController.showAllEditOption.value)
                            Padding(
                              padding: const EdgeInsets.only(bottom: k16Padding),
                              child: RowTextButton(
                                text: ksPhone.tr,
                                buttonText: ksAdd.tr,
                                showAddButton: true,
                                onPressedAdd: () {
                                  _profileController.resetTextEditor();
                                  _profileController.getMethod(11);
                                },
                                buttonWidth: 177,
                              ),
                            ),
                          for (int i = 0; i < _profileController.contactDataList.length; i++)
                            if (_profileController.contactDataList[i].type == 'phone' && _profileController.showAllEditOption.value)
                              Padding(
                                padding: const EdgeInsets.only(bottom: k10Padding),
                                child: InfoContainer(
                                  prefixIcon: BipHip.phoneFill,
                                  suffixIcon: BipHip.edit,
                                  text: checkNullOrStringNull(_profileController.contactDataList[i].value),
                                  suffixOnPressed: () {
                                    _profileController.resetTextEditor();
                                    _profileController.enableSaveButton.value = true;
                                    _profileController.phoneID.value = _profileController.contactDataList[i].id!;
                                    _profileController.phoneTextEditingController.text = _profileController.contactDataList[i].value!;
                                    _profileController.getMethod(12);
                                    // _globalController.commonBottomSheet(
                                    //     context: context,
                                    //     isScrollControlled: false,
                                    //     bottomSheetHeight: isDeviceScreenLarge() ? 180 : 160,
                                    //     onPressCloseButton: () {
                                    //       Get.back();
                                    //     },
                                    //     onPressRightButton: null,
                                    //     rightText: '',
                                    //     rightTextStyle: regular10TextStyle(cBlackColor),
                                    //     title: ksEdit.tr,
                                    //     isRightButtonShow: false,
                                    //     content: EditModalSheet(
                                    //       editButtonText: ksEditPhone.tr,
                                    //       editOnPressed: () {
                                    //         _profileController.phoneID.value = _profileController.contactDataList[i].id!;
                                    //         _profileController.phoneTextEditingController.text = _profileController.contactDataList[i].value!;
                                    //         _profileController.getMethod(12);
                                    //       },
                                    //       deleteButtonText: ksDeletePhone.tr,
                                    //       deleteOnPressed: () async {
                                    //         _profileController.deleteContact(_profileController.contactDataList[i].id);
                                    //         Get.back();
                                    //       },
                                    //     ));
                                  },
                                ),
                              ),
                          if (_profileController.showAllEditOption.value)
                            Padding(
                              padding: const EdgeInsets.only(bottom: k16Padding),
                              child: RowTextButton(
                                text: ksEmail.tr,
                                buttonText: ksAdd.tr,
                                showAddButton: true,
                                onPressedAdd: () {
                                  _profileController.resetTextEditor();
                                  _profileController.getMethod(13);
                                },
                                buttonWidth: 118,
                              ),
                            ),
                          for (int i = 0; i < _profileController.contactDataList.length; i++)
                            if (_profileController.contactDataList[i].type == 'email' && _profileController.showAllEditOption.value)
                              Padding(
                                padding: const EdgeInsets.only(bottom: k10Padding),
                                child: InfoContainer(
                                  prefixIcon: BipHip.mail,
                                  suffixIcon: BipHip.edit,
                                  text: checkNullOrStringNull(_profileController.contactDataList[i].value),
                                  suffixOnPressed: () {
                                    _profileController.resetTextEditor();
                                    _profileController.enableSaveButton.value = true;
                                    _profileController.emailID.value = _profileController.contactDataList[i].id!;
                                    _profileController.emailTextEditingController.text = _profileController.contactDataList[i].value!;
                                    _profileController.getMethod(14);
                                    // _globalController.commonBottomSheet(
                                    //     context: context,
                                    //     isScrollControlled: false,
                                    //     bottomSheetHeight: isDeviceScreenLarge() ? 180 : 160,
                                    //     onPressCloseButton: () {
                                    //       Get.back();
                                    //     },
                                    //     onPressRightButton: null,
                                    //     rightText: '',
                                    //     rightTextStyle: regular10TextStyle(cBlackColor),
                                    //     title: ksEdit.tr,
                                    //     isRightButtonShow: false,
                                    //     content: EditModalSheet(
                                    //       editButtonText: ksEditEmail.tr,
                                    //       editOnPressed: () {
                                    //         _profileController.emailID.value = _profileController.contactDataList[i].id!;
                                    //         _profileController.emailTextEditingController.text = _profileController.contactDataList[i].value!;
                                    //         _profileController.getMethod(14);
                                    //       },
                                    //       deleteButtonText: ksDeleteEmail.tr,
                                    //       deleteOnPressed: () async {
                                    //         await _profileController.deleteContact(_profileController.contactDataList[i].id);
                                    //         Get.back();
                                    //       },
                                    //     ));
                                  },
                                ),
                              ),
                          // if (_profileController.showAllEditOption.value) kH16sizedBox,
                          if (_profileController.showAllEditOption.value) const CustomDivider(),
                          if (_profileController.showAllEditOption.value)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: k16Padding),
                              child: RowTextButton(
                                text: ksWebsiteAndSocialLinks.tr,
                                buttonText: ksAdd.tr,
                                textStyle: semiBold18TextStyle(cBlackColor),
                                showAddButton: true,
                                onPressedAdd: () {
                                  _profileController.resetTextEditor();
                                  _profileController.linkSource.value = '';
                                  _profileController.commonEditPageIcon.value = null;
                                  _profileController.getMethod(15);
                                },
                                buttonWidth: 109,
                              ),
                            ),
                          for (int i = 0; i < _profileController.linkDataList.length; i++)
                            if (_profileController.showAllEditOption.value)
                              Padding(
                                padding: const EdgeInsets.only(bottom: k10Padding),
                                child: InfoContainer(
                                  prefixIcon: _profileController.getLinkIcon(_profileController.linkDataList[i].type!),
                                  suffixIcon: BipHip.edit,
                                  text: checkNullOrStringNull(_profileController.linkDataList[i].link),
                                  suffixOnPressed: () {
                                    _profileController.resetTextEditor();
                                    _profileController.enableSaveButton.value = true;
                                    _profileController.commonEditPageIcon.value = null;
                                    _profileController.linkTextEditingController.text = _profileController.linkDataList[i].link!;
                                    _profileController.linkID.value = _profileController.linkDataList[i].id!;
                                    _profileController.linkSource.value = _profileController.linkDataList[i].type!;
                                    _profileController.getMethod(16);
                                    // _globalController.commonBottomSheet(
                                    //     context: context,
                                    //     isScrollControlled: false,
                                    //     bottomSheetHeight: isDeviceScreenLarge() ? 180 : 160,
                                    //     onPressCloseButton: () {
                                    //       Get.back();
                                    //     },
                                    //     onPressRightButton: null,
                                    //     rightText: '',
                                    //     rightTextStyle: regular10TextStyle(cBlackColor),
                                    //     title: ksEdit.tr,
                                    //     isRightButtonShow: false,
                                    //     content: EditModalSheet(
                                    //       editButtonText: ksEditLink.tr,
                                    //       editOnPressed: () {
                                    //         _profileController.linkTextEditingController.text = _profileController.linkDataList[i].link!;
                                    //         _profileController.linkID.value = _profileController.linkDataList[i].id!;
                                    //         _profileController.linkSource.value = _profileController.linkDataList[i].type!;
                                    //         _profileController.getMethod(16);
                                    //       },
                                    //       deleteButtonText: ksDeleteLink.tr,
                                    //       deleteOnPressed: () async {
                                    //         Get.back();
                                    //         await _profileController.deleteLink(_profileController.linkDataList[i].id);
                                    //       },
                                    //     ));
                                  },
                                ),
                              ),
                          kH12sizedBox
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (_profileController.isEditProfileLoading.value == true)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (_profileController.isEditProfileLoading.value) {
                      return false;
                    }
                    return true;
                  },
                ),
              )
          ],
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
    return InkWell(
      onTap: suffixOnPressed,
      child: Container(
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
                  size: screenWiseSize(kIconSize24, 4),
                ),
              ),
              kW8sizedBox,
              Expanded(
                child: Text(
                  text,
                  style: regular16TextStyle(cIconColor),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Icon(
                suffixIcon,
                size: screenWiseSize(kIconSize22, 4),
                color: cIconColor,
              )
            ],
          ),
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
            label: ksCancel.tr,
            textStyle: semiBold14TextStyle(cRedColor),
            buttonColor: cWhiteColor,
            borderColor: cRedColor,
            buttonHeight: h32,
            buttonWidth: 80,
            onPressed: onPressedCancel),
        kW16sizedBox,
        CustomElevatedButton(label: ksSave.tr, textStyle: semiBold14TextStyle(cWhiteColor), buttonHeight: h32, buttonWidth: 80, onPressed: onPressedSave),
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
    return Obx(() => Column(
          children: [
            profileController.relationshipStatusList.isNotEmpty
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: profileController.relationshipStatusList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Obx(
                        () => Padding(
                          padding: const EdgeInsets.only(bottom: k8Padding),
                          child: CustomListTile(
                            title: profileController.relationshipStatusList[index],
                            trailing: CustomRadioButton(
                              onChanged: () {
                                profileController.tempRelationshipStatus.value = profileController.relationshipStatusList[index];
                              },
                              isSelected: profileController.tempRelationshipStatus.value == profileController.relationshipStatusList[index],
                            ),
                            itemColor: profileController.tempRelationshipStatus.value == profileController.relationshipStatusList[index]
                                ? cPrimaryTint3Color
                                : cWhiteColor,
                            onPressed: () {
                              profileController.tempRelationshipStatus.value = profileController.relationshipStatusList[index];
                            },
                          ),
                        ),
                      );
                    },
                  )
                : EmptyView(
                    height: height * 0.45,
                    title: ksNoDataAvailable.tr,
                  ),
          ],
        ));
  }
}

class _RelationshipStatusListShimmer extends StatelessWidget {
  const _RelationshipStatusListShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: ShimmerCommon(
               widget: Container(
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: k8CircularBorderRadius,
                    color: cWhiteColor,
                  ),
                ),
              ),
              contentPadding: EdgeInsets.zero,
            );
          },
        ),
      ],
    );
  }
}

class GenderListContent extends StatelessWidget {
  const GenderListContent({
    Key? key,
    required this.profileController,
  }) : super(key: key);

  final ProfileController profileController;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            profileController.genderList.isNotEmpty
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: profileController.genderList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Obx(
                        () => Padding(
                          padding: const EdgeInsets.only(bottom: k8Padding),
                          child: CustomListTile(
                            title: profileController.genderList[index],
                            trailing: CustomRadioButton(
                              onChanged: () {
                                profileController.tempSelectedGender.value = profileController.genderList[index];
                              },
                              isSelected: profileController.tempSelectedGender.value == profileController.genderList[index],
                            ),
                            itemColor: profileController.tempSelectedGender.value == profileController.genderList[index] ? cPrimaryTint3Color : cWhiteColor,
                            onPressed: () {
                              profileController.tempSelectedGender.value = profileController.genderList[index];
                            },
                          ),
                        ),
                      );
                    },
                  )
                : EmptyView(
                    height: isDeviceScreenLarge() ? 185 : 170,
                    title: ksNoDataAvailable.tr,
                  ),
          ],
        ));
  }
}

class RowTextButton extends StatelessWidget {
  const RowTextButton(
      {super.key,
      required this.text,
      required this.buttonText,
      required this.showAddButton,
      this.onPressedAdd,
      required this.buttonWidth,
      this.suffixWidget,
      this.textStyle});
  final String text, buttonText;
  final bool showAddButton;
  final VoidCallback? onPressedAdd;
  final double buttonWidth;
  final Widget? suffixWidget;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: textStyle ?? semiBold16TextStyle(cBlackColor),
        ),
        if (showAddButton && suffixWidget == null)
          CustomTextButtonV2(
            onPressed: onPressedAdd,
            text: buttonText,
            textStyle: semiBold14TextStyle(cPrimaryColor),
            prefixWidget: Icon(
              BipHip.addNew,
              color: cPrimaryColor,
              size: isDeviceScreenLarge() ? h20 : h16,
            ),
          ),
        if (suffixWidget != null)
          TextButton(
            onPressed: onPressedAdd,
            style: kTextButtonStyle,
            child: suffixWidget!,
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
