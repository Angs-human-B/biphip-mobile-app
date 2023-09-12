import 'package:bip_hip/controllers/authentication_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/utils/icons/bip_hip_icons.dart';
import 'package:bip_hip/widgets/common/checkbox_and_container.dart';
import 'package:bip_hip/widgets/common/custom_button.dart';
import 'package:bip_hip/widgets/common/linkup_text.dart';
import 'package:bip_hip/widgets/common/logo_and_text_widget.dart';
import 'package:bip_hip/widgets/common/top_text_and_subtext.dart';
import 'package:bip_hip/widgets/textfields/custom_textfield.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final AuthenticationController _authenticationController = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    heightWidthKeyboardValue(context);
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: cWhiteColor,
          body: SizedBox(
            height: height,
            width: width,
            child: SingleChildScrollView(
              child: Obx(
                () => Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: getPaddingTop(context) + h60),
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
                        child: const TopTitleAndSubtitle(
                          title: "Login",
                          subTitle: "Please login to continue...",
                        ),
                      ),
                    ),
                    kH25sizedBox,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: h20),
                      child: CustomModifiedTextField(
                        controller: _authenticationController.loginEmailTextEditingController,
                        hint: "Email or Phone number",
                        onChanged: (text) {
                          _authenticationController.checkCanLogin();
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
                        controller: _authenticationController.loginPasswordTextEditingController,
                        hint: "Password",
                        suffixIcon: _authenticationController.isLoginPasswordToggleObscure.value ? BipHip.closedEye : BipHip.openedEye,
                        onSuffixPress: () {
                          _authenticationController.isLoginPasswordToggleObscure.value = !_authenticationController.isLoginPasswordToggleObscure.value;
                        },
                        onChanged: (text) {
                          _authenticationController.checkCanLogin();
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
                          Get.toNamed(krForgotPassword);
                        },
                      ),
                    ),
                    kH16sizedBox,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: h20),
                      child: CustomElevatedButton(
                        label: 'Login',
                        onPressed: _authenticationController.canLogin.value ? () {} : null,
                        buttonWidth: width - 40,
                        textStyle:
                            _authenticationController.canLogin.value ? semiBold16TextStyle(cWhiteColor) : semiBold16TextStyle(cWhiteColor.withOpacity(.7)),
                      ),
                    ),
                    kH25sizedBox,
                    Column(
                      children: [
                        Text(
                          "Or login with",
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
                      prefix: "Don't have an account?",
                      suffix: "Register Now",
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
      ),
    );
  }
}
