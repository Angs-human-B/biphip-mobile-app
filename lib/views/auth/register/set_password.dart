import 'package:bip_hip/controllers/authentication_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/custom_app_bar.dart';
import 'package:bip_hip/widgets/common/custom_button.dart';
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
              title: ksRegisterNow.tr,
              onBack: () async {
                Get.back();
              },
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
                        hint: "Password",
                        suffixIcon: _authenticationController.isRegisterPasswordToggleObscure.value ? BipHip.closedEye : BipHip.openedEye,
                        onSuffixPress: () {
                          _authenticationController.isRegisterPasswordToggleObscure.value = !_authenticationController.isRegisterPasswordToggleObscure.value;
                        },
                        onChanged: (text) {
                          _authenticationController.checkPassword();
                        },
                        onSubmit: (text) {},
                        obscureText: _authenticationController.isRegisterPasswordToggleObscure.value,
                        inputAction: TextInputAction.next,
                        inputType: TextInputType.visiblePassword,
                      ),
                      kH24sizedBox,
                      CustomModifiedTextField(
                        controller: _authenticationController.registerConfirmPasswordTextEditingController,
                        hint: "Confirm password",
                        suffixIcon: _authenticationController.isRegisterConfirmPasswordToggleObscure.value ? BipHip.closedEye : BipHip.openedEye,
                        onSuffixPress: () {
                          _authenticationController.isRegisterConfirmPasswordToggleObscure.value =
                              !_authenticationController.isRegisterConfirmPasswordToggleObscure.value;
                        },
                        onChanged: (text) {
                          _authenticationController.checkPassword();
                        },
                        onSubmit: (text) {},
                        obscureText: _authenticationController.isRegisterConfirmPasswordToggleObscure.value,
                        inputAction: TextInputAction.done,
                        inputType: TextInputType.visiblePassword,
                      ),
                      CustomElevatedButton(
                        label: ksNext,
                        onPressed: _authenticationController.checkValidPassword.value
                            ? () {
                                // Get.toNamed(krBirthday);
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
