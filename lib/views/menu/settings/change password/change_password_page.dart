import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../controllers/auth/authentication_controller.dart';
import '../../../../helpers/auth/registration_helper.dart';
import '../../../../widgets/auth/top_text_and_subtext.dart';
import '../../../../widgets/common/utils/common_headertext.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final AuthenticationController authenticationController = Get.find<AuthenticationController>();
  final RegistrationHelper registrationHelper = RegistrationHelper();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  final FocusNode newPasswordFocusNode = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: cWhiteColor, image: DecorationImage(image: AssetImage(kiOnBoardingImageUrl), fit: BoxFit.cover)),
      child: Obx(
            () => Stack(
          children: [
            SafeArea(
              top: false,
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(kAppBarSize),
                  //* info:: appBar
                  child: CustomAppBar(
                    appBarColor: cTransparentColor,
                    title: ksForgetPassword.tr,
                    onBack: () async {
                      Get.back();
                    },
                  ),
                ),
                backgroundColor: cTransparentColor,
                body: SizedBox(
                  height: height,
                  width: width,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: Column(
                        children: [
                          kH48sizedBox,
                          TopTitleAndSubtitle(
                            title: ksChangePassword.tr,
                            subTitle: ksCreateStrongPassword.tr,
                          ),
                          kH50sizedBox,
                          CustomModifiedTextField(
                            controller: authenticationController.oldPasswordTextEditingController,
                            errorText: authenticationController.oldPasswordError.value,
                            hint: ksCurrentPassword.tr,
                            textHintStyle: regular16TextStyle(cPlaceHolderColor2),
                            fillColor: cWhiteColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(k4BorderRadius),
                              borderSide: const BorderSide(width: 1, color: cLineColor2),
                            ),
                            suffixIcon: authenticationController.isOldPasswordToggleObscure.value ? BipHip.passwordHide : Icons.visibility_outlined,
                            onSuffixPress: () {
                              authenticationController.isOldPasswordToggleObscure.value = !authenticationController.isOldPasswordToggleObscure.value;
                            },
                            onChanged: (text) {
                              registrationHelper.forgetPasswordNewPasswordValidation();
                            },
                            onSubmit: (text) {
                              FocusScope.of(context).requestFocus(newPasswordFocusNode);
                            },
                            inputAction: TextInputAction.next,
                            obscureText: authenticationController.isOldPasswordToggleObscure.value,
                            inputType: TextInputType.visiblePassword,
                          ),
                          // authenticationController.errorTextWiseResponsiveSizedBox(authenticationController.resetPasswordError.value),

                          CustomModifiedTextField(
                            controller: authenticationController.resetNewPasswordTextEditingController,
                            errorText: authenticationController.resetPasswordError.value,
                            focusNode: newPasswordFocusNode,
                            hint: ksTypePassword.tr,
                            textHintStyle: regular16TextStyle(cPlaceHolderColor2),
                            fillColor: cWhiteColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(k4BorderRadius),
                              borderSide: const BorderSide(width: 1, color: cLineColor2),
                            ),
                            suffixIcon: authenticationController.isResetNewPasswordToggleObscure.value ? BipHip.passwordHide : Icons.visibility_outlined,
                            onSuffixPress: () {
                              authenticationController.isResetNewPasswordToggleObscure.value = !authenticationController.isResetNewPasswordToggleObscure.value;
                            },
                            onChanged: (text) {
                              registrationHelper.forgetPasswordNewPasswordValidation();
                            },
                            onSubmit: (text) {
                              FocusScope.of(context).requestFocus(confirmPasswordFocusNode);
                            },
                            inputAction: TextInputAction.next,
                            obscureText: authenticationController.isResetNewPasswordToggleObscure.value,
                            inputType: TextInputType.visiblePassword,
                          ),
                          // authenticationController.errorTextWiseResponsiveSizedBox(authenticationController.resetPasswordError.value),
                          CustomModifiedTextField(
                            controller: authenticationController.resetConfirmPasswordTextEditingController,
                            focusNode: confirmPasswordFocusNode,
                            errorText: authenticationController.resetConfirmPasswordError.value,
                            hint: ksConfirmPassword.tr,
                            textHintStyle: regular16TextStyle(cPlaceHolderColor2),
                            fillColor: cWhiteColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(k4BorderRadius),
                              borderSide: const BorderSide(width: 1, color: cLineColor2),
                            ),
                            suffixIcon: authenticationController.isResetConfirmPasswordToggleObscure.value ? BipHip.passwordHide : Icons.visibility_outlined,
                            onSuffixPress: () {
                              authenticationController.isResetConfirmPasswordToggleObscure.value =
                              !authenticationController.isResetConfirmPasswordToggleObscure.value;
                            },
                            onChanged: (text) {registrationHelper.forgetPasswordConfirmPasswordValidation();
                            },
                            onSubmit: (text) {
                              FocusScope.of(context).unfocus();
                            },
                            obscureText: authenticationController.isResetConfirmPasswordToggleObscure.value,
                            inputAction: TextInputAction.done,
                            inputType: TextInputType.visiblePassword,
                          ),
                          authenticationController.errorTextWiseResponsiveSizedBox(authenticationController.resetConfirmPasswordError.value),
                          GestureDetector(
                              onTap: (){
                                Get.toNamed(krForgotPassword);
                              },
                              child: HeaderText("Forgot Password", color: Colors.blue,)),
                          SizedBox(height: 22.h),
                          CustomElevatedButton(
                            label: ksNext.tr,
                            onPressed: authenticationController.canResetPassword.value
                                ? () async {
                              await authenticationController.changePassword();
                            }
                                : null,
                            buttonWidth: width - 40,
                            textStyle: authenticationController.canResetPassword.value
                                ? semiBold16TextStyle(cWhiteColor)
                                : semiBold16TextStyle(cWhiteColor.withOpacity(.7)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (authenticationController.isChangePasswordLoading.value == true)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (authenticationController.isChangePasswordLoading.value) {
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
