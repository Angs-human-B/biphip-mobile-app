import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/helpers/auth_helpers/login_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/auth/checkbox_and_container.dart';
import 'package:bip_hip/widgets/common/button/linkup_text.dart';
import 'package:bip_hip/widgets/auth/logo_and_text_widget.dart';
import 'package:bip_hip/widgets/auth/top_text_and_subtext.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final AuthenticationController _authenticationController = Get.find<AuthenticationController>();
  final LoginHelper _loginHelper = LoginHelper();

  @override
  Widget build(BuildContext context) {
    heightWidthKeyboardValue(context);
    return Container(
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(kiOnBoarding4xImageUrl), fit: BoxFit.cover)),
      child: Obx(
        () => Stack(
          children: [
            SafeArea(
              top: false,
              child: Scaffold(
                backgroundColor: cTransparentColor,
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
                            size: 80,
                            fontSize: h26,
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
                            textHintStyle: regular16TextStyle(cPlaceHolderColor2),
                            fillColor: cWhiteColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(k4BorderRadius),
                              borderSide: const BorderSide(width: 1, color: cLineColor2),
                            ),
                            onChanged: (text) {
                              _loginHelper.loginEmailEditorOnChanged();
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
                            textHintStyle: regular16TextStyle(cPlaceHolderColor2),
                            fillColor: cWhiteColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(k4BorderRadius),
                              borderSide: const BorderSide(width: 1, color: cLineColor2),
                            ),
                            suffixIcon: _authenticationController.isLoginPasswordToggleObscure.value ? BipHip.passwordHide : BipHip.passwordShow,
                            onSuffixPress: () {
                              _authenticationController.isLoginPasswordToggleObscure.value = !_authenticationController.isLoginPasswordToggleObscure.value;
                            },
                            onChanged: (text) {
                              _loginHelper.loginPasswordEditorOnChanger();
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
                                    unFocus(context);
                                    await _authenticationController.userLogin();
                                  }
                                : null,
                            buttonWidth: width - 40,
                            textStyle:
                                _authenticationController.canLogin.value ? semiBold16TextStyle(cWhiteColor) : semiBold16TextStyle(cWhiteColor.withOpacity(.7)),
                          ),
                        ),
                        kH25sizedBox,
                        Text(
                          ksOrLoginWith.tr,
                          style: regular14TextStyle(cBlackColor),
                        ),
                        kH8sizedBox,
                        const OtherLoginPlatform(),
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

class OtherLoginPlatform extends StatelessWidget {
  const OtherLoginPlatform({super.key, this.onPressedFacebook, this.onPressedTwitter, this.onPressedGoogle});

  final VoidCallback? onPressedFacebook, onPressedTwitter, onPressedGoogle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: onPressedFacebook,
          style: kTextButtonStyle,
          child: Image.asset(
            kiFacebookImageUrl,
            height: 40,
            width: 40,
          ),
        ),
        kW8sizedBox,
        TextButton(
          onPressed: onPressedGoogle,
          style: kTextButtonStyle,
          child: Image.asset(
            kiGoogleImageUrl,
            height: 40,
            width: 40,
          ),
        ),
        kW8sizedBox,
        TextButton(
          onPressed: onPressedTwitter,
          style: kTextButtonStyle,
          child: Image.asset(
            kiTwitterImageUrl,
            height: 40,
            width: 40,
          ),
        ),
      ],
    );
  }
}
