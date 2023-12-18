import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/shimmers/profile/gender_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/auth/onboarding/picture_upload_screen.dart';
import 'package:bip_hip/views/menu/profile/edit_about/gender_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class RegistrationHelper {
  final AuthenticationController authenticationController = Get.find<AuthenticationController>();
  final GlobalController globalController = Get.find<GlobalController>();
  final ProfileController profileController = Get.find<ProfileController>();

  void checkName() {
    if (authenticationController.registerFirstNameTextEditingController.text.trim() != '' &&
        authenticationController.registerLastNameTextEditingController.text.trim() != '') {
      authenticationController.checkValidName.value = true;
    } else {
      authenticationController.checkValidName.value = false;
    }
  }

  void checkEmail() {
    if (authenticationController.registerEmailTextEditingController.text.trim() != '' &&
        authenticationController.registerEmailTextEditingController.text.isValidEmail) {
      authenticationController.checkValidEmail.value = true;
    } else {
      authenticationController.checkValidEmail.value = false;
    }
  }

  void checkPassword() {
    if (authenticationController.registerPasswordTextEditingController.text.length >= kMinPasswordLength &&
        authenticationController.registerPasswordTextEditingController.text == authenticationController.registerConfirmPasswordTextEditingController.text) {
      authenticationController.checkValidPassword.value = true;
    } else {
      authenticationController.checkValidPassword.value = false;
    }
  }

  void registerFirstNameOnChange() {
    checkName();
    if (authenticationController.registerFirstNameTextEditingController.text.trim() == '') {
      authenticationController.firstNameError.value = ksEmptyFirstNameErrorMessage.tr;
    } else {
      authenticationController.firstNameError.value = "";
    }
  }

  void registerLastNameOnChange() {
    checkName();
    if (authenticationController.registerLastNameTextEditingController.text.trim() == '') {
      authenticationController.lastNameError.value = ksEmptyLastNameErrorMessage.tr;
    } else {
      authenticationController.lastNameError.value = "";
    }
  }

  void onPressedNext() {
    Get.find<ProfileController>().isRouteFromAboutInfo.value = false;
    authenticationController.birthDay.value = '';
    Get.toNamed(krSelectBirthday);
  }

  void registerEmailOnChanged() {
    checkEmail();
    if (authenticationController.registerEmailTextEditingController.text.trim() == '') {
      authenticationController.registerEmailError.value = ksEmptyEmailErrorMessage.tr;
    } else if (!authenticationController.registerEmailTextEditingController.text.trim().isValidEmail) {
      authenticationController.registerEmailError.value = ksInvalidEmailErrorMessage.tr;
    } else {
      authenticationController.registerEmailError.value = '';
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
            initialDateTime: authenticationController.birthDay.value != ''
                ? DateTime.parse(authenticationController.birthDay.value)
                : DateTime.now().subtract(const Duration(days: 16 * 365)),
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (value) {
              authenticationController.birthDay.value = DateFormat("yyyy-MM-dd").format(value);
            },
          ),
        );
      },
    );
  }

  void onPressedConfirmBirthday() async {
    if (!profileController.isRouteFromAboutInfo.value) {
      Get.toNamed(krSelectGender);
    } else {
      profileController.birthday.value = authenticationController.birthDay.value;
      Get.back();
      await profileController.updateDOB();
      profileController.isRouteFromAboutInfo.value = false;
    }
  }

  void onPressedSelectGender(context) async {
    ll(profileController.tempSelectedGender.value);
    if (authenticationController.gender.value != '') {
      profileController.tempSelectedGender.value = authenticationController.gender.value;
    } else {
      profileController.tempSelectedGender.value = '';
    }
    if (profileController.tempSelectedGender.value == '') {
      globalController.isBottomSheetRightButtonActive.value = false;
    } else {
      globalController.isBottomSheetRightButtonActive.value = true;
    }
    profileController.isGenderListLoading.value = true;
    globalController.commonBottomSheet(
      context: context,
      content: Obx(
        () => profileController.isGenderListLoading.value
            ? const GenderListShimmer()
            : GenderListContent(
                profileController: profileController,
              ),
      ),
      onPressCloseButton: () {
        Get.back();
      },
      onPressRightButton: () {
        profileController.isGenderListLoading.value = true;
        if (profileController.tempSelectedGender.value != '') {
          authenticationController.gender.value = profileController.tempSelectedGender.value;
          profileController.isGenderSelected.value = true;
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
    await profileController.getGenderList();
  }

  void passwordOnChanged() {
    checkPassword();
    if (authenticationController.registerPasswordTextEditingController.text.trim() == '') {
      authenticationController.registerPasswordError.value = ksEmptyPasswordErrorMessage.tr;
    } else if (authenticationController.registerPasswordTextEditingController.text.length < kMinPasswordLength) {
      authenticationController.registerPasswordError.value = ksPasswordLengthErrorMessage.tr;
    } else if ((authenticationController.registerConfirmPasswordTextEditingController.text !=
            authenticationController.registerPasswordTextEditingController.text) &&
        authenticationController.registerConfirmPasswordTextEditingController.text.isNotEmpty) {
      authenticationController.registerConfirmPasswordError.value = ksUnmatchedPasswordErrorMessage.tr;
    } else {
      authenticationController.registerPasswordError.value = '';
      authenticationController.registerConfirmPasswordError.value = '';
    }
  }

  void confirmPasswordOnChanged() {
    checkPassword();
    if (authenticationController.registerConfirmPasswordTextEditingController.text.trim() == '') {
      authenticationController.registerConfirmPasswordError.value = ksEmptyConfirmPasswordErrorMessage.tr;
    } else if (authenticationController.registerConfirmPasswordTextEditingController.text !=
        authenticationController.registerPasswordTextEditingController.text) {
      authenticationController.registerConfirmPasswordError.value = ksUnmatchedPasswordErrorMessage.tr;
    } else {
      authenticationController.registerConfirmPasswordError.value = '';
    }
  }

  void checkCanOTPVerifyNow() {
    if (authenticationController.otpTextEditingController.text.length == kOTPLength) {
      authenticationController.canOTPVerifyNow.value = true;
    } else {
      authenticationController.canOTPVerifyNow.value = false;
    }
  }

  void onPressedVerifyOTP() async {
    if (authenticationController.parentRoute.value == "login") {
      await authenticationController.signUpVerify();
    } else if (authenticationController.parentRoute.value == "register") {
      profileController.isRouteFromAboutInfo.value = false;
      Get.find<GlobalController>().professionIndex.value = -1;
      await authenticationController.signUpVerify();
      await profileController.getProfessionList();
    } else {
      await authenticationController.forgetPasswordVerify();
    }
  }

  void onPressedSavePhoto(context) async {
    if (!authenticationController.isProfileImageChanged.value) {
      globalController.commonBottomSheet(
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
                  await globalController.selectImageSource(authenticationController.isProfileImageChanged, authenticationController.profileLink,
                      authenticationController.profileFile, 'camera', true);
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
                  await globalController.selectImageSource(authenticationController.isProfileImageChanged, authenticationController.profileLink,
                      authenticationController.profileFile, 'gallery', true);
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
      authenticationController.isImageUploadLoading.value = true;
      await Get.find<ProfileController>().uploadProfileAndCover(authenticationController.profileFile.value, 'profile', false);
      authenticationController.isImageUploadLoading.value = false;
    }
  }

  void onSelectingInterest(index) {
    if (!globalController.interestIndex.contains(index)) {
      globalController.interestIndex.add(index);
    } else {
      globalController.interestIndex.remove(index);
    }
  }

  void onPressedSaveInterest() async {
    if (!profileController.isRouteFromAboutInfo.value) {
      for (int i = 0; i < globalController.interestIndex.length; i++) {
        globalController.selectedInterests.add(globalController.interestList[globalController.interestIndex[i]]);
      }
      Get.toNamed(krUploadPicture);
      await profileController.setInterest(globalController.selectedInterests);
      globalController.resetChipSelection();
    } else {
      globalController.selectedInterests.clear();
      for (int i = 0; i < globalController.interestIndex.length; i++) {
        globalController.selectedInterests.add(globalController.interestList[globalController.interestIndex[i]]);
      }
      Get.back();
      await profileController.setInterest(globalController.selectedInterests);
      profileController.isRouteFromAboutInfo.value = false;
    }
  }

  void onPressedSaveProfession() async {
    if (!profileController.isRouteFromAboutInfo.value) {
      profileController.isInterestListLoading.value = true;
      Get.find<GlobalController>().interestIndex.clear();
      globalController.selectedProfession.value = globalController.professionList[globalController.professionIndex.value];
      profileController.setProfession(globalController.selectedProfession.value);
      Get.toNamed(krSelectInterest);
      await profileController.getInterestList();
    } else {
      globalController.selectedProfession.value = globalController.professionList[globalController.professionIndex.value];

      Get.back();
      await profileController.setProfession(globalController.selectedProfession.value);
      profileController.isRouteFromAboutInfo.value = false;
    }
  }

  void checkCanSendOTP() {
    if (authenticationController.forgotPasswordEmailTextEditingController.text.trim().isValidEmail) {
      authenticationController.canSendOTP.value = true;
    } else {
      authenticationController.canSendOTP.value = false;
    }
  }

  void forgetPasswordEmailOnChanged() {
    checkCanSendOTP();
    if (authenticationController.forgotPasswordEmailTextEditingController.text.trim() == '') {
      authenticationController.forgotPasswordEmailError.value = ksEmptyEmailErrorMessage.tr;
    } else if (!authenticationController.forgotPasswordEmailTextEditingController.text.trim().isValidEmail) {
      authenticationController.forgotPasswordEmailError.value = ksInvalidEmailErrorMessage.tr;
    } else {
      authenticationController.forgotPasswordEmailError.value = null;
    }
  }

  void checkCanResetPassword() {
    if (authenticationController.resetNewPasswordTextEditingController.text.trim().length >= kMinPasswordLength &&
        authenticationController.resetNewPasswordTextEditingController.text.trim() ==
            authenticationController.resetConfirmPasswordTextEditingController.text.trim()) {
      authenticationController.canResetPassword.value = true;
    } else {
      authenticationController.canResetPassword.value = false;
    }
  }

  void forgetPasswordNewPasswordOnChanged() {
    checkCanResetPassword();
    if (authenticationController.resetNewPasswordTextEditingController.text.trim() == '') {
      authenticationController.resetPasswordError.value = ksEmptyPasswordErrorMessage.tr;
    } else if (authenticationController.resetNewPasswordTextEditingController.text.length < kMinPasswordLength) {
      authenticationController.resetPasswordError.value = ksPasswordLengthErrorMessage.tr;
    } else {
      authenticationController.resetPasswordError.value = null;
      authenticationController.resetConfirmPasswordError.value = null;
    }
  }

  void forgetPasswordConfirmPasswordOnChanged() {
    checkCanResetPassword();
    if (authenticationController.resetConfirmPasswordTextEditingController.text.trim() == '') {
      authenticationController.resetConfirmPasswordError.value = ksEmptyConfirmPasswordErrorMessage.tr;
    } else if (authenticationController.resetConfirmPasswordTextEditingController.text != authenticationController.resetNewPasswordTextEditingController.text) {
      authenticationController.resetConfirmPasswordError.value = ksUnmatchedPasswordErrorMessage.tr;
    } else {
      authenticationController.resetConfirmPasswordError.value = null;
    }
  }

  //*Newly added for new user popup show
  void congratulationsAlertDialog({required BuildContext context, required Widget content}) {
    showAlertDialog(
      context: context,
      child: CommonAlertDialog(
        hasCloseBtn: false,
        addContent: content,
        actions: [
          CustomElevatedButton(
            label: ksOkay.tr,
            onPressed: () {
              Get.back();
            },
            buttonWidth: 70,
            buttonHeight: 40,
            textStyle: semiBold14TextStyle(cWhiteColor),
            buttonColor: cPrimaryColor,
          ),
          kH10sizedBox,
        ],
      ),
    );
  }
}
