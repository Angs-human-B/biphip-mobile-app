import 'package:bip_hip/controllers/authentication_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/custom_app_bar.dart';
import 'package:bip_hip/widgets/common/custom_button.dart';
import 'package:bip_hip/widgets/common/custom_circular_progress_bar.dart';
import 'package:bip_hip/widgets/common/top_text_and_subtext.dart';
import 'package:bip_hip/widgets/textfields/custom_textfield.dart';

class SetPassword extends StatelessWidget {
  SetPassword({super.key});

  final AuthenticationController _authenticationController = Get.find<AuthenticationController>();

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
                child: Obx(
                  () => Column(
                    children: [
                      kH24sizedBox,
                      kH24sizedBox,
                      const TopTitleAndSubtitle(
                        title: 'Create Password',
                        subTitle: 'Create a strong password to prevent unknown login of your personal account.',
                      ),
                      kH50sizedBox,
                      CustomModifiedTextField(
                        controller: _authenticationController.registerPasswordTextEditingController,
                        errorText: _authenticationController.registerPasswordError.value,
                        hint: "Password",
                        suffixIcon: _authenticationController.isRegisterPasswordToggleObscure.value ? BipHip.closedEye : BipHip.openedEye,
                        onSuffixPress: () {
                          _authenticationController.isRegisterPasswordToggleObscure.value = !_authenticationController.isRegisterPasswordToggleObscure.value;
                        },
                        onChanged: (text) {
                          _authenticationController.checkPassword();
                          if (_authenticationController.registerPasswordTextEditingController.text.trim() == '') {
                            _authenticationController.registerPasswordError.value = 'Password can\'t be empty';
                          } else if (_authenticationController.registerPasswordTextEditingController.text.length < kMinPasswordLength) {
                            _authenticationController.registerPasswordError.value = 'Password can\'t be less then 8 characters';
                          } else {
                            _authenticationController.registerPasswordError.value = '';
                          }
                        },
                        onSubmit: (text) {},
                        obscureText: _authenticationController.isRegisterPasswordToggleObscure.value,
                        inputAction: TextInputAction.next,
                        inputType: TextInputType.visiblePassword,
                      ),
                      kH24sizedBox,
                      CustomModifiedTextField(
                        controller: _authenticationController.registerConfirmPasswordTextEditingController,
                        errorText: _authenticationController.registerConfirmPasswordError.value,
                        hint: "Confirm password",
                        suffixIcon: _authenticationController.isRegisterConfirmPasswordToggleObscure.value ? BipHip.closedEye : BipHip.openedEye,
                        onSuffixPress: () {
                          _authenticationController.isRegisterConfirmPasswordToggleObscure.value =
                              !_authenticationController.isRegisterConfirmPasswordToggleObscure.value;
                        },
                        onChanged: (text) {
                          _authenticationController.checkPassword();
                          if (_authenticationController.registerConfirmPasswordTextEditingController.text.trim() == '') {
                            _authenticationController.registerConfirmPasswordError.value = 'Confirm password can\'t be empty';
                          } else if (_authenticationController.registerConfirmPasswordTextEditingController.text !=
                              _authenticationController.registerPasswordTextEditingController.text) {
                            _authenticationController.registerConfirmPasswordError.value = 'Password doesn\'t match';
                          } else {
                            _authenticationController.registerConfirmPasswordError.value = '';
                          }
                        },
                        onSubmit: (text) {},
                        obscureText: _authenticationController.isRegisterConfirmPasswordToggleObscure.value,
                        inputAction: TextInputAction.done,
                        inputType: TextInputType.visiblePassword,
                      ),
                      kH24sizedBox,
                      CustomElevatedButton(
                        label: ksNext,
                        onPressed: _authenticationController.checkValidPassword.value
                            ? () {
                                Get.toNamed(krOTP);
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
      ),
    );
  }
}
