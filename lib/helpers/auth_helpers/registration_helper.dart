import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/shimmer_views/profile/gender_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_about_sections/gender_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class RegistrationHelper {
  final AuthenticationController _authenticationController = Get.find<AuthenticationController>();
  final GlobalController _globalController = Get.find<GlobalController>();
  final ProfileController _profileController = Get.find<ProfileController>();

  void checkName() {
    if (_authenticationController.registerFirstNameTextEditingController.text.trim() != '' &&
        _authenticationController.registerLastNameTextEditingController.text.trim() != '') {
      _authenticationController.checkValidName.value = true;
    } else {
      _authenticationController.checkValidName.value = false;
    }
  }

  void checkEmail() {
    if (_authenticationController.registerEmailTextEditingController.text.trim() != '' &&
        _authenticationController.registerEmailTextEditingController.text.isValidEmail) {
      _authenticationController.checkValidEmail.value = true;
    } else {
      _authenticationController.checkValidEmail.value = false;
    }
  }

  void checkPassword() {
    if (_authenticationController.registerPasswordTextEditingController.text.length >= kMinPasswordLength &&
        _authenticationController.registerPasswordTextEditingController.text == _authenticationController.registerConfirmPasswordTextEditingController.text) {
      _authenticationController.checkValidPassword.value = true;
    } else {
      _authenticationController.checkValidPassword.value = false;
    }
  }

  void registerFirstNameOnChange() {
    checkName();
    if (_authenticationController.registerFirstNameTextEditingController.text.trim() == '') {
      _authenticationController.firstNameError.value = ksEmptyFirstNameErrorMessage.tr;
    } else {
      _authenticationController.firstNameError.value = "";
    }
  }

  void registerLastNameOnChange() {
    checkName();
    if (_authenticationController.registerLastNameTextEditingController.text.trim() == '') {
      _authenticationController.lastNameError.value = ksEmptyLastNameErrorMessage.tr;
    } else {
      _authenticationController.lastNameError.value = "";
    }
  }

  void onPressedNext() {
    Get.find<ProfileController>().isRouteFromAboutInfo.value = false;
    _authenticationController.birthDay.value = '';
    Get.toNamed(krSelectBirthday);
  }

  void registerEmailOnChanged() {
    checkEmail();
    if (_authenticationController.registerEmailTextEditingController.text.trim() == '') {
      _authenticationController.registerEmailError.value = ksEmptyEmailErrorMessage.tr;
    } else if (!_authenticationController.registerEmailTextEditingController.text.trim().isValidEmail) {
      _authenticationController.registerEmailError.value = ksInvalidEmailErrorMessage.tr;
    } else {
      _authenticationController.registerEmailError.value = '';
    }
  }

  void onPressedSelectBirthday(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: height * 0.4,
          child: CupertinoDatePicker(
            maximumDate: DateTime.now().subtract(const Duration(days: 15 * 365)),
            initialDateTime: _authenticationController.birthDay.value != ''
                ? DateTime.parse(_authenticationController.birthDay.value)
                : DateTime.now().subtract(const Duration(days: 16 * 365)),
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (value) {
              _authenticationController.birthDay.value = DateFormat("yyyy-MM-dd").format(value);
            },
          ),
        );
      },
    );
  }

  void onPressedConfirmBirthday() async {
    if (!_profileController.isRouteFromAboutInfo.value) {
      Get.toNamed(krSelectGender);
    } else {
      _profileController.birthday.value = _authenticationController.birthDay.value;
      Get.back();
      await _profileController.updateDOB();
      _profileController.isRouteFromAboutInfo.value = false;
    }
  }

  void onPressedSelectGender(context) async {
    if (_authenticationController.gender.value != '') {
      _profileController.tempSelectedGender.value = _authenticationController.gender.value;
    }
    _profileController.isGenderListLoading.value = true;
    _globalController.commonBottomSheet(
      context: context,
      content: Obx(
        () => _profileController.isGenderListLoading.value
            ? const GenderListShimmer()
            : GenderListContent(
                profileController: _profileController,
              ),
      ),
      onPressCloseButton: () {
        Get.back();
      },
      onPressRightButton: () {
        _profileController.isGenderListLoading.value = true;
        if (_profileController.tempSelectedGender.value != '') {
          _authenticationController.gender.value = _profileController.tempSelectedGender.value;
          _profileController.isGenderSelected.value = true;
        }
        Get.back();
      },
      rightText: ksDone.tr,
      rightTextStyle: medium14TextStyle(cPrimaryColor),
      title: ksSelectGender.tr,
      isRightButtonShow: true,
      isScrollControlled: true,
      bottomSheetHeight: height * 0.4,
    );
    await _profileController.getGenderList();
  }

  void passwordOnChanged() {
    checkPassword();
    if (_authenticationController.registerPasswordTextEditingController.text.trim() == '') {
      _authenticationController.registerPasswordError.value = ksEmptyPasswordErrorMessage.tr;
    } else if (_authenticationController.registerPasswordTextEditingController.text.length < kMinPasswordLength) {
      _authenticationController.registerPasswordError.value = ksPasswordLengthErrorMessage.tr;
    } else if ((_authenticationController.registerConfirmPasswordTextEditingController.text !=
            _authenticationController.registerPasswordTextEditingController.text) &&
        _authenticationController.registerConfirmPasswordTextEditingController.text.isNotEmpty) {
      _authenticationController.registerConfirmPasswordError.value = ksUnmatchedPasswordErrorMessage.tr;
    } else {
      _authenticationController.registerPasswordError.value = '';
      _authenticationController.registerConfirmPasswordError.value = '';
    }
  }

  void confirmPasswordOnChanged() {
    checkPassword();
    if (_authenticationController.registerConfirmPasswordTextEditingController.text.trim() == '') {
      _authenticationController.registerConfirmPasswordError.value = ksEmptyConfirmPasswordErrorMessage.tr;
    } else if (_authenticationController.registerConfirmPasswordTextEditingController.text !=
        _authenticationController.registerPasswordTextEditingController.text) {
      _authenticationController.registerConfirmPasswordError.value = ksUnmatchedPasswordErrorMessage.tr;
    } else {
      _authenticationController.registerConfirmPasswordError.value = '';
    }
  }

  void checkCanOTPVerifyNow() {
    if (_authenticationController.otpTextEditingController.text.length == kOTPLength) {
      _authenticationController.canOTPVerifyNow.value = true;
    } else {
      _authenticationController.canOTPVerifyNow.value = false;
    }
  }

  void onPressedVerifyOTP() async {
    if (_authenticationController.parentRoute.value == "login") {
      await _authenticationController.signUpVerify();
    } else if (_authenticationController.parentRoute.value == "register") {
      _profileController.isRouteFromAboutInfo.value = false;
      Get.find<GlobalController>().professionIndex.value = -1;
      await _authenticationController.signUpVerify();
      await _profileController.getProfessionList();
    } else {
      await _authenticationController.forgetPasswordVerify();
    }
  }

  void onPressedSavePhoto(context) async {
    if (!_authenticationController.isProfileImageChanged.value) {
      _globalController.commonBottomSheet(
          context: context,
          onPressCloseButton: () {
            Get.back();
          },
          onPressRightButton: () {},
          rightText: '',
          rightTextStyle: regular14TextStyle(cBiddingColor),
          title: ksUploadPhoto.tr,
          isRightButtonShow: false,
          isScrollControlled: false,
          bottomSheetHeight: 180,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomElevatedButton(
                label: ksAddPhoto.tr,
                prefixIcon: BipHip.camera,
                prefixIconColor: cIconColor,
                suffixIconColor: cIconColor,
                onPressed: () async {
                  await _globalController.selectImageSource(_authenticationController.isProfileImageChanged, _authenticationController.profileLink,
                      _authenticationController.profileFile, 'camera', true);
                },
                buttonHeight: h32,
                buttonWidth: width - 40,
                buttonColor: cWhiteColor,
                borderColor: cLineColor,
                textStyle: semiBold14TextStyle(cBlackColor),
              ),
              kH16sizedBox,
              CustomElevatedButton(
                label: ksChooseFromGallery.tr,
                prefixIcon: BipHip.photo,
                prefixIconColor: cIconColor,
                suffixIconColor: cIconColor,
                onPressed: () async {
                  await _globalController.selectImageSource(_authenticationController.isProfileImageChanged, _authenticationController.profileLink,
                      _authenticationController.profileFile, 'gallery', true);
                },
                buttonHeight: h32,
                buttonWidth: width - 40,
                buttonColor: cWhiteColor,
                borderColor: cLineColor,
                textStyle: semiBold14TextStyle(cBlackColor),
              ),
            ],
          ));
    } else {
      _authenticationController.isImageUploadLoading.value = true;
      await Get.find<ProfileController>().uploadProfileAndCover(_authenticationController.profileFile.value, 'profile', false);
      _authenticationController.isImageUploadLoading.value = false;
    }
  }

  void onSelectingInterest(index) {
    if (!_globalController.interestIndex.contains(index)) {
      _globalController.interestIndex.add(index);
    } else {
      _globalController.interestIndex.remove(index);
    }
  }

  void onPressedSaveInterest() async {
    if (!_profileController.isRouteFromAboutInfo.value) {
      for (int i = 0; i < _globalController.interestIndex.length; i++) {
        _globalController.selectedInterests.add(_globalController.interestList[_globalController.interestIndex[i]]);
      }
      Get.toNamed(krUploadPicture);
      await _profileController.setInterest(_globalController.selectedInterests);
      _globalController.resetChipSelection();
    } else {
      _globalController.selectedInterests.clear();
      for (int i = 0; i < _globalController.interestIndex.length; i++) {
        _globalController.selectedInterests.add(_globalController.interestList[_globalController.interestIndex[i]]);
      }
      Get.back();
      await _profileController.setInterest(_globalController.selectedInterests);
      _profileController.isRouteFromAboutInfo.value = false;
    }
  }

  void onPressedSaveProfession() async {
    if (!_profileController.isRouteFromAboutInfo.value) {
      _profileController.isInterestListLoading.value = true;
      Get.find<GlobalController>().interestIndex.clear();
      _globalController.selectedProfession.value = _globalController.professionList[_globalController.professionIndex.value];
      _profileController.setProfession(_globalController.selectedProfession.value);
      Get.toNamed(krSelectInterest);
      await _profileController.getInterestList();
    } else {
      _globalController.selectedProfession.value = _globalController.professionList[_globalController.professionIndex.value];

      Get.back();
      await _profileController.setProfession(_globalController.selectedProfession.value);
      _profileController.isRouteFromAboutInfo.value = false;
    }
  }

  void checkCanSendOTP() {
    if (_authenticationController.forgotPasswordEmailTextEditingController.text.trim().isValidEmail) {
      _authenticationController.canSendOTP.value = true;
    } else {
      _authenticationController.canSendOTP.value = false;
    }
  }

  void forgetPasswordEmailOnChanged() {
    checkCanSendOTP();
    if (_authenticationController.forgotPasswordEmailTextEditingController.text.trim() == '') {
      _authenticationController.forgotPasswordEmailError.value = ksEmptyEmailErrorMessage.tr;
    } else if (!_authenticationController.forgotPasswordEmailTextEditingController.text.trim().isValidEmail) {
      _authenticationController.forgotPasswordEmailError.value = ksInvalidEmailErrorMessage.tr;
    } else {
      _authenticationController.forgotPasswordEmailError.value = '';
    }
  }

  void checkCanResetPassword() {
    if (_authenticationController.resetNewPasswordTextEditingController.text.trim().length >= kMinPasswordLength &&
        _authenticationController.resetNewPasswordTextEditingController.text.trim() ==
            _authenticationController.resetConfirmPasswordTextEditingController.text.trim()) {
      _authenticationController.canResetPassword.value = true;
    } else {
      _authenticationController.canResetPassword.value = false;
    }
  }

  void forgetPasswordNewPasswordOnChanged() {
    checkCanResetPassword();
    if (_authenticationController.resetNewPasswordTextEditingController.text.trim() == '') {
      _authenticationController.resetPasswordError.value = ksEmptyPasswordErrorMessage.tr;
    } else if (_authenticationController.resetNewPasswordTextEditingController.text.length < kMinPasswordLength) {
      _authenticationController.resetPasswordError.value = ksPasswordLengthErrorMessage.tr;
    } else {
      _authenticationController.resetPasswordError.value = '';
    }
  }

  void forgetPasswordConfirmPasswordOnChanged() {
    checkCanResetPassword();
    if (_authenticationController.resetConfirmPasswordTextEditingController.text.trim() == '') {
      _authenticationController.resetConfirmPasswordError.value = ksEmptyConfirmPasswordErrorMessage.tr;
    } else if (_authenticationController.resetConfirmPasswordTextEditingController.text !=
        _authenticationController.resetNewPasswordTextEditingController.text) {
      _authenticationController.resetConfirmPasswordError.value = ksUnmatchedPasswordErrorMessage.tr;
    } else {
      _authenticationController.resetConfirmPasswordError.value = '';
    }
  }
}
