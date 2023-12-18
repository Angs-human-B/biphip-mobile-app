import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/helpers/auth/registration_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/auth/top_text_and_subtext.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final AuthenticationController authenticationController = Get.find<AuthenticationController>();
  final RegistrationHelper registrationHelper = RegistrationHelper();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    heightWidthKeyboardValue(context);
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
                          kH24sizedBox,
                          kH24sizedBox,
                          TopTitleAndSubtitle(
                            title: ksResetPassword.tr,
                            subTitle: ksCreateStrongPassword.tr,
                          ),
                          kH50sizedBox,
                          CustomModifiedTextField(
                            controller: authenticationController.resetNewPasswordTextEditingController,
                            errorText: authenticationController.resetPasswordError.value,
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
                              registrationHelper.forgetPasswordNewPasswordOnChanged();
                            },
                            onSubmit: (text) {
                              FocusScope.of(context).requestFocus(confirmPasswordFocusNode);
                            },
                            inputAction: TextInputAction.next,
                            obscureText: authenticationController.isResetNewPasswordToggleObscure.value,
                            inputType: TextInputType.visiblePassword,
                          ),
                           authenticationController.setGap(authenticationController.resetPasswordError.value),
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
                            onChanged: (text) {
                              registrationHelper.forgetPasswordConfirmPasswordOnChanged();
                            },
                            onSubmit: (text) {
                              FocusScope.of(context).unfocus();
                            },
                            obscureText: authenticationController.isResetConfirmPasswordToggleObscure.value,
                            inputAction: TextInputAction.done,
                            inputType: TextInputType.visiblePassword,
                          ),
                           authenticationController.setGap(authenticationController.resetConfirmPasswordError.value),
                          CustomElevatedButton(
                            label: ksNext.tr,
                            onPressed: authenticationController.canResetPassword.value
                                ? () async {
                                    await authenticationController.resetPassword();
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
            if (authenticationController.isResetPasswordLoading.value == true)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (authenticationController.isResetPasswordLoading.value) {
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
