import 'package:bip_hip/controllers/authentication_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/checkbox_and_container.dart';
import 'package:bip_hip/widgets/common/button/linkup_text.dart';
import 'package:bip_hip/widgets/common/button/logo_and_text_widget.dart';
import 'package:bip_hip/widgets/common/utils/top_text_and_subtext.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

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
              child: Scaffold(
                backgroundColor: cWhiteColor,
                body: SizedBox(
                  height: height,
                  width: width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              isDeviceScreenLarge() ? EdgeInsets.only(top: getPaddingTop(context) + h60) : EdgeInsets.only(top: getPaddingTop(context) + h40),
                          child: const LogoAndText(
                            size: h50,
                            fontSize: h18,
                            mainAxisAlignment: MainAxisAlignment.start,
                          ),
                        ),
                        kH30sizedBox,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: h20),
                          child: SizedBox(
                            width: width,
                            child: TopTitleAndSubtitle(
                              title: ksLogin.tr,
                              subTitle: "${ksPleaseLoginToContinue.tr}...",
                            ),
                          ),
                        ),
                        kH25sizedBox,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: h20),
                          child: CustomModifiedTextField(
                            errorText: _authenticationController.loginEmailErrorText.isEmpty ? null : _authenticationController.loginEmailErrorText.value,
                            controller: _authenticationController.loginEmailTextEditingController,
                            hint: ksEmailOrPhone.tr,
                            onChanged: (text) {
                              _authenticationController.checkCanLogin();
                              if (_authenticationController.loginEmailTextEditingController.text.trim() == '') {
                                _authenticationController.loginEmailErrorText.value = ksEmptyEmailErrorMessage.tr;
                              } else if (!_authenticationController.loginEmailTextEditingController.text.trim().isValidEmail) {
                                _authenticationController.loginEmailErrorText.value = ksInvalidEmailErrorMessage.tr;
                              } else {
                                _authenticationController.loginEmailErrorText.value = '';
                              }
                            },
                            onSubmit: (text) {},
                            inputAction: TextInputAction.next,
                            inputType: TextInputType.emailAddress,
                          ),
                        ),
                        kH8sizedBox,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: h20),
                          child: CustomModifiedTextField(
                            errorText: _authenticationController.loginPasswordErrorText.value,
                            controller: _authenticationController.loginPasswordTextEditingController,
                            hint: ksPassword.tr,
                            suffixIcon: _authenticationController.isLoginPasswordToggleObscure.value ? BipHip.closedEye : BipHip.openedEye,
                            onSuffixPress: () {
                              _authenticationController.isLoginPasswordToggleObscure.value = !_authenticationController.isLoginPasswordToggleObscure.value;
                            },
                            onChanged: (text) {
                              _authenticationController.checkCanLogin();
                              if (_authenticationController.loginPasswordTextEditingController.text.trim() == '') {
                                _authenticationController.loginPasswordErrorText.value = ksEmptyPasswordErrorMessage.tr;
                              } else if (_authenticationController.loginPasswordTextEditingController.text.length < kMinPasswordLength) {
                                _authenticationController.loginPasswordErrorText.value = ksPasswordLengthErrorMessage.tr;
                              } else {
                                _authenticationController.loginPasswordErrorText.value = '';
                              }
                            },
                            onSubmit: (text) {},
                            obscureText: _authenticationController.isLoginPasswordToggleObscure.value,
                            inputAction: TextInputAction.done,
                            inputType: TextInputType.visiblePassword,
                          ),
                        ),
                        kH16sizedBox,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: h20),
                          child: CheckBoxAndContainer(
                            isChecked: _authenticationController.isLoginRememberCheck,
                            onTapCheckBox: (v) {
                              _authenticationController.isLoginRememberCheck.value = !_authenticationController.isLoginRememberCheck.value;
                            },
                            onPressForgetButton: () {
                              _authenticationController.resetForgotPasswordScreen();
                              Get.toNamed(krForgotPassword);
                            },
                          ),
                        ),
                        kH16sizedBox,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: h20),
                          child: CustomElevatedButton(
                            label: ksLogin.tr,
                            onPressed: _authenticationController.canLogin.value
                                ? () async {
                                    await _authenticationController.userLogin();
                                  }
                                : null,
                            buttonWidth: width - 40,
                            textStyle:
                                _authenticationController.canLogin.value ? semiBold16TextStyle(cWhiteColor) : semiBold16TextStyle(cWhiteColor.withOpacity(.7)),
                          ),
                        ),
                        kH25sizedBox,
                        Column(
                          children: [
                            Text(
                              ksOrLoginWith.tr,
                              style: regular14TextStyle(cBlackColor),
                            ),
                            kH8sizedBox,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  style: kTextButtonStyle,
                                  child: Image.asset(
                                    kiFacebookImageUrl,
                                    height: 40,
                                    width: 40,
                                  ),
                                ),
                                kW8sizedBox,
                                TextButton(
                                  onPressed: () {},
                                  style: kTextButtonStyle,
                                  child: Image.asset(
                                    kiGoogleImageUrl,
                                    height: 40,
                                    width: 40,
                                  ),
                                ),
                                kW8sizedBox,
                                TextButton(
                                  onPressed: () {},
                                  style: kTextButtonStyle,
                                  child: Image.asset(
                                    kiTwitterImageUrl,
                                    height: 40,
                                    width: 40,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        kH12sizedBox,
                        LinkupTextRow(
                          prefix: ksDoNotHaveAnyAccount.tr,
                          suffix: ksRegisterNow.tr,
                          onPressed: () {
                            Get.offAllNamed(krRegister);
                          },
                        ),
                        kH40sizedBox,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (_authenticationController.isLoginLoading.value == true)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (_authenticationController.isLoginLoading.value) {
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
