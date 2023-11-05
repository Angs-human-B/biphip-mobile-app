import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/helpers/auth_helpers/registration_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/auth/top_text_and_subtext.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final AuthenticationController _authenticationController = Get.find<AuthenticationController>();
  final RegistrationHelper _registrationHelper = RegistrationHelper();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    heightWidthKeyboardValue(context);
    return Container(
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(kiOnBoardingImageUrl), fit: BoxFit.cover)),

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
                          kH24sizedBox,
                          kH24sizedBox,
                          TopTitleAndSubtitle(
                            title: ksResetPassword.tr,
                            subTitle: ksCreateStrongPassword.tr,
                          ),
                          kH50sizedBox,
                          CustomModifiedTextField(
                            controller: _authenticationController.resetNewPasswordTextEditingController,
                            errorText: _authenticationController.resetPasswordError.value,
                            hint: ksTypePassword.tr,
                            textHintStyle: regular16TextStyle(cPlaceHolderColor2),
                            fillColor: cWhiteColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(k4BorderRadius),
                              borderSide: const BorderSide(width: 1, color: cLineColor2),
                            ),
                            suffixIcon: _authenticationController.isResetNewPasswordToggleObscure.value ? BipHip.passwordHide : BipHip.passwordShow,
                            onSuffixPress: () {
                              _authenticationController.isResetNewPasswordToggleObscure.value =
                                  !_authenticationController.isResetNewPasswordToggleObscure.value;
                            },
                            onChanged: (text) {
                              _registrationHelper.forgetPasswordNewPasswordOnChanged();
                            },
                            onSubmit: (text) {
                              FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
                            },
                            inputAction: TextInputAction.next,
                            obscureText: _authenticationController.isResetNewPasswordToggleObscure.value,
                            inputType: TextInputType.visiblePassword,
                          ),
                          kH4sizedBox,
                          CustomModifiedTextField(
                            controller: _authenticationController.resetConfirmPasswordTextEditingController,
                            focusNode: _confirmPasswordFocusNode,
                            errorText: _authenticationController.resetConfirmPasswordError.value,
                            hint: ksConfirmPassword.tr,
                            textHintStyle: regular16TextStyle(cPlaceHolderColor2),
                            fillColor: cWhiteColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(k4BorderRadius),
                              borderSide: const BorderSide(width: 1, color: cLineColor2),
                            ),
                            suffixIcon: _authenticationController.isResetConfirmPasswordToggleObscure.value ? BipHip.passwordHide : BipHip.passwordShow,
                            onSuffixPress: () {
                              _authenticationController.isResetConfirmPasswordToggleObscure.value =
                                  !_authenticationController.isResetConfirmPasswordToggleObscure.value;
                            },
                            onChanged: (text) {
                              _registrationHelper.forgetPasswordConfirmPasswordOnChanged();
                            },
                            onSubmit: (text) {
                              FocusScope.of(context).unfocus();
                            },
                            obscureText: _authenticationController.isResetConfirmPasswordToggleObscure.value,
                            inputAction: TextInputAction.done,
                            inputType: TextInputType.visiblePassword,
                          ),
                          kH24sizedBox,
                          CustomElevatedButton(
                            label: ksNext.tr,
                            onPressed: _authenticationController.canResetPassword.value
                                ? () async {
                                    await _authenticationController.resetPassword();
                                  }
                                : null,
                            buttonWidth: width - 40,
                            textStyle: _authenticationController.canResetPassword.value
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
            if (_authenticationController.isResetPasswordLoading.value == true)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (_authenticationController.isResetPasswordLoading.value) {
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
