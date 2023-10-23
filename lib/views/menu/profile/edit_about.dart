import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/auth/register/select_gender.dart';
import 'package:bip_hip/views/menu/profile/edit_profile.dart';
import 'package:bip_hip/views/menu/photos/gallery_photos.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';
import 'package:bip_hip/widgets/common/button/custom_modified_text_button.dart';
import 'package:bip_hip/widgets/common/button/custom_selection_button.dart';
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
                backgroundColor: cBackgroundColor,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        kH10sizedBox,
                        Container(
                          color: cWhiteColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                kH16sizedBox,
                                Text(
                                  ksAddress.tr,
                                  style: semiBold18TextStyle(cBlackColor),
                                ),
                                kH12sizedBox,
                                if (_profileController.hometownData.value == null)
                                  InfoContainer2(
                                    suffixText: ksHomeTown.tr,
                                    isAddButton: true,
                                    suffixOnPressed: () async {
                                      _profileController.resetTextEditor();
                                      _profileController.getCityList();
                                      _profileController.getMethod(9);
                                    },
                                  ),
                                if (_profileController.hometownData.value != null)
                                  InfoContainer2(
                                    subtitlePrefixText: ksHomeTown.tr,
                                    suffixText: checkNullOrStringNull(_profileController.hometownData.value?.city),
                                    isAddButton: false,
                                    suffixOnPressed: () async {
                                      _profileController.enableSaveButton.value = true;
                                      _profileController.getMethod(0);
                                      _profileController.getCityList();
                                    },
                                  ),
                                kH12sizedBox,
                                if (_profileController.currentCityData.value == null)
                                  InfoContainer2(
                                    suffixText: ksPresentAddress.tr,
                                    isAddButton: true,
                                    suffixOnPressed: () async {
                                      _profileController.resetTextEditor();
                                      _profileController.getMethod(1);
                                      Get.toNamed(krEdit);
                                      _profileController.getCityList();
                                    },
                                  ),
                                if (_profileController.currentCityData.value != null)
                                  InfoContainer2(
                                    subtitlePrefixText: ksCurrentCity.tr,
                                    suffixText: checkNullOrStringNull(_profileController.currentCityData.value!.city),
                                    isAddButton: false,
                                    suffixOnPressed: () async {
                                      _profileController.enableSaveButton.value = true;
                                      _profileController.isCurrentlyLiveHere.value = true;
                                      _profileController.cityID.value = _profileController.currentCityData.value!.id!;
                                      _profileController.getMethod(2);
                                      _profileController.getCityList();
                                    },
                                  ),
                                kH12sizedBox,
                                InfoContainer2(
                                  suffixText: ksOther.tr,
                                  isAddButton: true,
                                  suffixOnPressed: () async {
                                    _profileController.resetTextEditor();
                                    _profileController.isSingleDatePicker.value = true;
                                    _profileController.getMethod(3);
                                    Get.toNamed(krEdit);
                                    _profileController.getCityList();
                                  },
                                ),
                                kH12sizedBox,
                                for (int i = 0; i < _profileController.otherCityList.length; i++)
                                  if (_profileController.otherCityList[i].isCurrent == 0 && _profileController.otherCityList[i].isHometown == 0)
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: k12Padding),
                                      child: InfoContainer2(
                                        suffixText: _profileController.otherCityList[i].city!,
                                        subtitlePrefixText: 'Moved in',
                                        subtitleSuffixText: DateFormat("MMMM dd, yyyy").format(_profileController.otherCityList[i].moved!),
                                        isAddButton: false,
                                        suffixOnPressed: () async {
                                          _profileController.cityID.value = _profileController.otherCityList[i].id!;
                                          _profileController.presentAddressTextEditingController.text = _profileController.otherCityList[i].city!;
                                          _profileController.enableSaveButton.value = true;
                                          _profileController.isSingleDatePicker.value = true;
                                          _profileController.getMethod(4);
                                          _profileController.getCityList();
                                        },
                                      ),
                                    ),
                                kH4sizedBox
                              ],
                            ),
                          ),
                        ),
                        kH8sizedBox,
                        Container(
                          color: cWhiteColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                kH16sizedBox,
                                InfoContainer2(
                                  suffixText: ksEducationalBackground.tr,
                                  suffixTextStyle: semiBold18TextStyle(cBlackColor),
                                  isAddButton: true,
                                  suffixOnPressed: () {
                                    _profileController.resetTextEditor();
                                    _profileController.getMethod(5);
                                    _profileController.getSchoolList();
                                  },
                                ),
                                kH12sizedBox,
                                for (int i = 0; i < _profileController.schoolDataList.length; i++)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: k12Padding),
                                    child: InfoContainer2(
                                      suffixText: checkNullOrStringNull(_profileController.schoolDataList[i].school),
                                      prefixText: _profileController.schoolDataList[i].ended != null ? 'Studied at' : 'Studies at',
                                      isAddButton: false,
                                      suffixOnPressed: () async {
                                        _profileController.resetTextEditor();
                                        _profileController.enableSaveButton.value = true;
                                        if (_profileController.schoolDataList[i].started != null) {
                                          _profileController.tempSchoolStartDate.value =
                                              DateFormat("yyyy-MM-dd").format(_profileController.schoolDataList[i].started!);
                                        }
                                        if (_profileController.schoolDataList[i].ended != null) {
                                          _profileController.tempSchoolEndDate.value =
                                              DateFormat("yyyy-MM-dd").format(_profileController.schoolDataList[i].ended!);
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
                                for (int i = 0; i < _profileController.collegeDataList.length; i++)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: k12Padding),
                                    child: InfoContainer2(
                                      suffixText: checkNullOrStringNull(_profileController.collegeDataList[i].school),
                                      prefixText: _profileController.collegeDataList[i].ended != null ? 'Studied at' : 'Studies at',
                                      isAddButton: false,
                                      suffixOnPressed: () async {
                                        _profileController.resetTextEditor();
                                        _profileController.enableSaveButton.value = true;
                                        if (_profileController.collegeDataList[i].started != null) {
                                          _profileController.tempSchoolStartDate.value =
                                              DateFormat("yyyy-MM-dd").format(_profileController.collegeDataList[i].started!);
                                        }
                                        if (_profileController.collegeDataList[i].ended != null) {
                                          _profileController.tempSchoolEndDate.value =
                                              DateFormat("yyyy-MM-dd").format(_profileController.collegeDataList[i].ended!);
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
                                      },
                                    ),
                                  ),
                                kH4sizedBox
                              ],
                            ),
                          ),
                        ),
                        kH8sizedBox,
                        Container(
                          color: cWhiteColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              kH16sizedBox,
                              Text(
                                ksRelationshipStatus.tr,
                                style: semiBold18TextStyle(cBlackColor),
                              ),
                              kH12sizedBox,
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
                              if (_profileController.relationshipStatus.value != '' && _profileController.showEditRelationshipStatus.value) kH12sizedBox,
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
                            ]),
                          ),
                        ),
                        if (_profileController.showAllEditOption.value) kH8sizedBox,
                        if (_profileController.showAllEditOption.value)
                          Container(
                            color: cWhiteColor,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                kH16sizedBox,
                                Text(
                                  ksGender.tr,
                                  style: semiBold18TextStyle(cBlackColor),
                                ),
                                kH12sizedBox,
                                CustomSelectionButton(
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
                                if (_profileController.isGenderSelected.value) kH12sizedBox,
                                if (_profileController.isGenderSelected.value)
                                  CancelSaveButton(
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
                                kH16sizedBox,
                              ]),
                            ),
                          ),
                        if (_profileController.showAllEditOption.value) kH8sizedBox,
                        if (_profileController.showAllEditOption.value)
                          Container(
                            color: cWhiteColor,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                kH16sizedBox,
                                Text(
                                  ksDateOfBirth.tr,
                                  style: semiBold18TextStyle(cBlackColor),
                                ),
                                kH12sizedBox,
                                InfoContainer2(
                                  suffixText: '',
                                  prefixText: DateFormat("yyyy-MM-dd").format(_profileController.userData.value!.dob!),
                                  isAddButton: false,
                                  suffixOnPressed: () {
                                    _authenticationController.birthDay.value = DateFormat("yyyy-MM-dd").format(_profileController.userData.value!.dob!);
                                    _profileController.isRouteFromAboutInfo.value = true;
                                    Get.toNamed(krSelectBirthday);
                                  },
                                ),
                                kH16sizedBox,
                              ]),
                            ),
                          ),
                        if (_profileController.showAllEditOption.value) kH8sizedBox,
                        if (_profileController.showAllEditOption.value)
                          Container(
                            color: cWhiteColor,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                kH16sizedBox,
                                RowTextButton(
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
                                kH12sizedBox,
                                if (_profileController.userData.value!.profession.isNotEmpty && _profileController.showAllEditOption.value)
                                  InfoContainer2(
                                    suffixText: '',
                                    prefixText: checkNullOrStringNull(_profileController.userData.value!.profession[0]),
                                    isAddButton: false,
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
                                    },
                                  ),
                                kH16sizedBox,
                              ]),
                            ),
                          ),
                        if (_profileController.showAllEditOption.value) kH8sizedBox,
                        if (_profileController.showAllEditOption.value)
                          Container(
                            color: cWhiteColor,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                kH16sizedBox,
                                InfoContainer2(
                                  suffixText: ksInterest.tr,
                                  suffixTextStyle: semiBold18TextStyle(cBlackColor),
                                  isAddButton: _profileController.userData.value!.interest.isEmpty ? true : false,
                                  suffixOnPressed: () async {
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
                                ),
                                kH8sizedBox,
                                Wrap(
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
                                kH8sizedBox,
                              ]),
                            ),
                          ),
                        kH8sizedBox,
                        Container(
                          color: cWhiteColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              kH16sizedBox,
                              Text(
                                ksWork.tr,
                                style: semiBold18TextStyle(cBlackColor),
                              ),
                              kH12sizedBox,
                              if (_profileController.currentWorkplace.value == null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: k12Padding),
                                  child: InfoContainer2(
                                    suffixText: ksCurrentWorkplace.tr,
                                    isAddButton: true,
                                    suffixOnPressed: () async {
                                      _profileController.resetTextEditor();
                                      _profileController.getMethod(8);
                                      _profileController.getCompanyList();
                                    },
                                  ),
                                ),
                              if (_profileController.currentWorkplace.value != null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: k12Padding),
                                  child: InfoContainer2(
                                    prefixText: _profileController.currentWorkplace.value!.position == null
                                        ? null
                                        : '${_profileController.currentWorkplace.value!.position} at',
                                    suffixText: checkNullOrStringNull(_profileController.currentWorkplace.value!.company),
                                    isAddButton: false,
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
                                    },
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: k12Padding),
                                child: InfoContainer2(
                                  suffixText: ksOther.tr,
                                  isAddButton: true,
                                  suffixOnPressed: () async {
                                    _profileController.resetTextEditor();
                                    _profileController.getMethod(8);
                                    _profileController.getCompanyList();
                                  },
                                ),
                              ),
                              for (int i = 0; i < _profileController.workplaceDataList.length; i++)
                                if (_profileController.workplaceDataList[i].isCurrent != 1)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: k12Padding),
                                    child: InfoContainer2(
                                      prefixText: _profileController.workplaceDataList[i].position == null
                                          ? null
                                          : 'Former ${_profileController.workplaceDataList[i].position} at',
                                      suffixText: _profileController.workplaceDataList[i].company!,
                                      isAddButton: false,
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
                                      },
                                    ),
                                  ),
                              kH4sizedBox,
                            ]),
                          ),
                        ),
                        kH8sizedBox,
                        if (_profileController.showAllEditOption.value)
                          Container(
                            color: cWhiteColor,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  kH16sizedBox,
                                  Text(
                                    ksContactDetails.tr,
                                    style: semiBold18TextStyle(cBlackColor),
                                  ),
                                  kH12sizedBox,
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: k12Padding),
                                    child: InfoContainer2(
                                      suffixText: ksPhone.tr,
                                      isAddButton: true,
                                      suffixOnPressed: () {
                                        _profileController.resetTextEditor();
                                        _profileController.getMethod(11);
                                      },
                                    ),
                                  ),
                                  for (int i = 0; i < _profileController.contactDataList.length; i++)
                                    if (_profileController.contactDataList[i].type == 'phone')
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: k12Padding),
                                        child: InfoContainer2(
                                          suffixText: '',
                                          prefixText: checkNullOrStringNull(_profileController.contactDataList[i].value),
                                          isAddButton: false,
                                          suffixOnPressed: () {
                                            _profileController.resetTextEditor();
                                            _profileController.enableSaveButton.value = true;
                                            _profileController.phoneID.value = _profileController.contactDataList[i].id!;
                                            _profileController.phoneTextEditingController.text = _profileController.contactDataList[i].value!;
                                            _profileController.getMethod(12);
                                          },
                                        ),
                                      ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: k12Padding),
                                    child: InfoContainer2(
                                      suffixText: ksEmail.tr,
                                      isAddButton: true,
                                      suffixOnPressed: () {
                                        _profileController.resetTextEditor();
                                        _profileController.getMethod(13);
                                      },
                                    ),
                                  ),
                                  for (int i = 0; i < _profileController.contactDataList.length; i++)
                                    if (_profileController.contactDataList[i].type == 'email')
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: k12Padding),
                                        child: InfoContainer2(
                                          suffixText: '',
                                          prefixText: checkNullOrStringNull(_profileController.contactDataList[i].value),
                                          isAddButton: false,
                                          suffixOnPressed: () {
                                            _profileController.resetTextEditor();
                                            _profileController.enableSaveButton.value = true;
                                            _profileController.emailID.value = _profileController.contactDataList[i].id!;
                                            _profileController.emailTextEditingController.text = _profileController.contactDataList[i].value!;
                                            _profileController.getMethod(14);
                                          },
                                        ),
                                      ),
                                  kH4sizedBox
                                ],
                              ),
                            ),
                          ),
                        kH8sizedBox,
                        if (_profileController.showAllEditOption.value)
                          Container(
                            color: cWhiteColor,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  kH16sizedBox,
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: k12Padding),
                                    child: InfoContainer2(
                                      suffixText: ksWebsiteAndSocialLinks.tr,
                                      suffixTextStyle: semiBold18TextStyle(cBlackColor),
                                      isAddButton: true,
                                      suffixOnPressed: () {
                                        _profileController.resetTextEditor();
                                        _profileController.linkSource.value = '';
                                        _profileController.commonEditPageIcon.value = null;
                                        _profileController.getMethod(15);
                                      },
                                    ),
                                  ),
                                  for (int i = 0; i < _profileController.linkDataList.length; i++)
                                    if (_profileController.showAllEditOption.value)
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: k12Padding),
                                        child: InfoContainer2(
                                          suffixText: '',
                                          prefixText: checkNullOrStringNull(_profileController.linkDataList[i].link),
                                          isAddButton: false,
                                          suffixOnPressed: () {
                                            _profileController.resetTextEditor();
                                            _profileController.enableSaveButton.value = true;
                                            _profileController.commonEditPageIcon.value = null;
                                            _profileController.linkTextEditingController.text = _profileController.linkDataList[i].link!;
                                            _profileController.linkID.value = _profileController.linkDataList[i].id!;
                                            _profileController.linkSource.value = _profileController.linkDataList[i].type!;
                                            _profileController.getMethod(16);
                                          },
                                        ),
                                      ),
                                  kH4sizedBox
                                ],
                              ),
                            ),
                          ),
                        kH12sizedBox
                      ],
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
        decoration: BoxDecoration(borderRadius: k8CircularBorderRadius, color: cWhiteColor),
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

class InfoContainer2 extends StatelessWidget {
  const InfoContainer2(
      {super.key,
      required this.suffixText,
      this.suffixOnPressed,
      this.prefixText,
      required this.isAddButton,
      this.subtitlePrefixText,
      this.subtitleSuffixText,
      this.suffixTextStyle});
  final String suffixText;
  final String? prefixText, subtitlePrefixText, subtitleSuffixText;
  final TextStyle? suffixTextStyle;
  final VoidCallback? suffixOnPressed;
  final bool isAddButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: k8CircularBorderRadius, color: cWhiteColor),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    overflow: TextOverflow.clip,
                    text: TextSpan(children: [
                      if (prefixText != null) TextSpan(text: '$prefixText ', style: regular16TextStyle(cBlackColor)),
                      TextSpan(
                        text: suffixText,
                        style: suffixTextStyle ?? semiBold16TextStyle(cBlackColor),
                      )
                    ])),
                if (subtitlePrefixText != null || subtitleSuffixText != null)
                  Padding(
                    padding: const EdgeInsets.only(top: k4Padding),
                    child: RichText(
                        overflow: TextOverflow.clip,
                        text: TextSpan(children: [
                          TextSpan(text: '$subtitlePrefixText ', style: regular12TextStyle(cSmallBodyTextColor)),
                          TextSpan(
                            text: subtitleSuffixText,
                            style: regular12TextStyle(cSmallBodyTextColor),
                          )
                        ])),
                  ),
              ],
            ),
          ),
          isAddButton
              ? CustomTextButtonV2(
                  onPressed: suffixOnPressed,
                  text: ksAdd.tr,
                  textStyle: semiBold16TextStyle(cPrimaryColor),
                  prefixWidget: Icon(
                    BipHip.addNew,
                    color: cPrimaryColor,
                    size: isDeviceScreenLarge() ? h20 : h16,
                  ),
                )
              : InkWell(
                  onTap: suffixOnPressed,
                  child: Icon(
                    BipHip.edit,
                    size: screenWiseSize(kIconSize22, 4),
                    color: cIconColor,
                  ),
                ),
        ],
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
          itemCount: 10,
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
