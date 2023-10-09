import 'package:bip_hip/controllers/authentication_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/custom_circular_progress_bar.dart';
import 'package:bip_hip/widgets/common/utils/top_text_and_subtext.dart';

class SetPassword extends StatelessWidget {
  SetPassword({super.key});

  final FocusNode _confirmPasswordFocusNode = FocusNode();
  final AuthenticationController _authenticationController = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    heightWidthKeyboardValue(context);
    return Container(
      color: cWhiteColor,
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
                    title: ksRegistration.tr,
                    onBack: () async {
                      Get.back();
                    },
                    action: const [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: CustomCircularProgressBar(
                          percent: 0.8,
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
                      child: Column(
                        children: [
                          kH24sizedBox,
                          kH24sizedBox,
                          TopTitleAndSubtitle(
                            title: ksCreatePassword.tr,
                            subTitle: ksCreateStrongPassword.tr,
                          ),
                          kH50sizedBox,
                          CustomModifiedTextField(
                            controller: _authenticationController.registerPasswordTextEditingController,
                            errorText: _authenticationController.registerPasswordError.value,
                            hint: ksPassword.tr,
                            suffixIcon: _authenticationController.isRegisterPasswordToggleObscure.value ? BipHip.closedEye : BipHip.openedEye,
                            onSuffixPress: () {
                              _authenticationController.isRegisterPasswordToggleObscure.value =
                                  !_authenticationController.isRegisterPasswordToggleObscure.value;
                            },
                            onChanged: (text) {
                              _authenticationController.checkPassword();
                              if (_authenticationController.registerPasswordTextEditingController.text.trim() == '') {
                                _authenticationController.registerPasswordError.value = ksEmptyPasswordErrorMessage.tr;
                              } else if (_authenticationController.registerPasswordTextEditingController.text.length < kMinPasswordLength) {
                                _authenticationController.registerPasswordError.value = ksPasswordLengthErrorMessage.tr;
                              } else {
                                _authenticationController.registerPasswordError.value = '';
                              }
                            },
                            onSubmit: (text) {
                              FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
                            },
                            obscureText: _authenticationController.isRegisterPasswordToggleObscure.value,
                            inputAction: TextInputAction.next,
                            inputType: TextInputType.visiblePassword,
                          ),
                          kH4sizedBox,
                          CustomModifiedTextField(
                            controller: _authenticationController.registerConfirmPasswordTextEditingController,
                            focusNode: _confirmPasswordFocusNode,
                            errorText: _authenticationController.registerConfirmPasswordError.value,
                            hint: ksConfirmPassword.tr,
                            suffixIcon: _authenticationController.isRegisterConfirmPasswordToggleObscure.value ? BipHip.closedEye : BipHip.openedEye,
                            onSuffixPress: () {
                              _authenticationController.isRegisterConfirmPasswordToggleObscure.value =
                                  !_authenticationController.isRegisterConfirmPasswordToggleObscure.value;
                            },
                            onChanged: (text) {
                              _authenticationController.checkPassword();
                              if (_authenticationController.registerConfirmPasswordTextEditingController.text.trim() == '') {
                                _authenticationController.registerConfirmPasswordError.value = ksEmptyConfirmPasswordErrorMessage.tr;
                              } else if (_authenticationController.registerConfirmPasswordTextEditingController.text !=
                                  _authenticationController.registerPasswordTextEditingController.text) {
                                _authenticationController.registerConfirmPasswordError.value = ksUnmatchedPasswordErrorMessage.tr;
                              } else {
                                _authenticationController.registerConfirmPasswordError.value = '';
                              }
                            },
                            onSubmit: (text) {
                              FocusScope.of(context).unfocus();
                            },
                            obscureText: _authenticationController.isRegisterConfirmPasswordToggleObscure.value,
                            inputAction: TextInputAction.done,
                            inputType: TextInputType.visiblePassword,
                          ),
                          kH24sizedBox,
                          CustomElevatedButton(
                            label: ksNext.tr,
                            onPressed: _authenticationController.checkValidPassword.value
                                ? () async {
                                    await _authenticationController.userRegister();
                                  }
                                : null,
                            buttonWidth: width - 40,
                            textStyle: _authenticationController.checkValidPassword.value
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
            if (_authenticationController.isRegisterLoading.value == true)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (_authenticationController.isRegisterLoading.value) {
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
