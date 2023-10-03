import 'package:bip_hip/controllers/authentication_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/custom_circular_progress_bar.dart';
import 'package:bip_hip/widgets/common/utils/top_text_and_subtext.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final AuthenticationController _authenticationController = Get.find<AuthenticationController>();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    heightWidthKeyboardValue(context);
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              title: ksForgetPassword.tr,
              onBack: () async {
                Get.back();
              },
              action: const [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: CustomCircularProgressBar(
                    percent: 1.0,
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: cWhiteColor,
          body: SizedBox(
            height: height,
            width: width,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: Obx(
                  () => Column(
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
                        suffixIcon: _authenticationController.isResetNewPasswordToggleObscure.value ? BipHip.closedEye : BipHip.openedEye,
                        onSuffixPress: () {
                          _authenticationController.isResetNewPasswordToggleObscure.value = !_authenticationController.isResetNewPasswordToggleObscure.value;
                        },
                        onChanged: (text) {
                          _authenticationController.checkCanResetPassword();
                          if (_authenticationController.resetNewPasswordTextEditingController.text.trim() == '') {
                            _authenticationController.resetPasswordError.value = ksEmptyPasswordErrorMessage.tr;
                          } else if (_authenticationController.resetNewPasswordTextEditingController.text.length < kMinPasswordLength) {
                            _authenticationController.resetPasswordError.value = ksPasswordLengthErrorMessage.tr;
                          } else {
                            _authenticationController.resetPasswordError.value = '';
                          }
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
                        suffixIcon: _authenticationController.isResetConfirmPasswordToggleObscure.value ? BipHip.closedEye : BipHip.openedEye,
                        onSuffixPress: () {
                          _authenticationController.isResetConfirmPasswordToggleObscure.value =
                              !_authenticationController.isResetConfirmPasswordToggleObscure.value;
                        },
                        onChanged: (text) {
                          _authenticationController.checkCanResetPassword();
                          if (_authenticationController.resetConfirmPasswordTextEditingController.text.trim() == '') {
                            _authenticationController.resetConfirmPasswordError.value = ksEmptyConfirmPasswordErrorMessage.tr;
                          } else if (_authenticationController.resetConfirmPasswordTextEditingController.text !=
                              _authenticationController.resetNewPasswordTextEditingController.text) {
                            _authenticationController.resetConfirmPasswordError.value = ksUnmatchedPasswordErrorMessage.tr;
                          } else {
                            _authenticationController.resetConfirmPasswordError.value = '';
                          }
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
      ),
    );
  }
}
