import 'package:bip_hip/controllers/authentication_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/custom_app_bar.dart';
import 'package:bip_hip/widgets/common/custom_button.dart';
import 'package:bip_hip/widgets/common/top_text_and_subtext.dart';
import 'package:bip_hip/widgets/textfields/custom_textfield.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

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
              title: ksForgetPassword.tr,
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
                        title: 'Create New Password',
                        subTitle: 'Create a strong password to prevent unknown login of your personal account.',
                      ),
                      kH50sizedBox,
                      CustomModifiedTextField(
                        controller: _authenticationController.resetNewPasswordTextEditingController,
                        hint: "Type Password",
                        suffixIcon: _authenticationController.isResetNewPasswordToggleObscure.value ? BipHip.closedEye : BipHip.openedEye,
                        onSuffixPress: () {
                          _authenticationController.isResetNewPasswordToggleObscure.value = !_authenticationController.isResetNewPasswordToggleObscure.value;
                        },
                        onChanged: (text) {
                          _authenticationController.checkCanResetPassword();
                        },
                        onSubmit: (text) {},
                        obscureText: _authenticationController.isResetNewPasswordToggleObscure.value,
                        inputAction: TextInputAction.next,
                        inputType: TextInputType.visiblePassword,
                      ),
                      kH24sizedBox,
                      CustomModifiedTextField(
                        controller: _authenticationController.resetConfirmPasswordTextEditingController,
                        hint: "Confirm password",
                        suffixIcon: _authenticationController.isResetConfirmPasswordToggleObscure.value ? BipHip.closedEye : BipHip.openedEye,
                        onSuffixPress: () {
                          _authenticationController.isResetConfirmPasswordToggleObscure.value =
                              !_authenticationController.isResetConfirmPasswordToggleObscure.value;
                        },
                        onChanged: (text) {
                          _authenticationController.checkCanResetPassword();
                        },
                        onSubmit: (text) {},
                        obscureText: _authenticationController.isResetConfirmPasswordToggleObscure.value,
                        inputAction: TextInputAction.done,
                        inputType: TextInputType.visiblePassword,
                      ),
                      kH24sizedBox,
                      CustomElevatedButton(
                        label: ksNext,
                        onPressed: _authenticationController.canResetPassword.value
                            ? () {
                                Get.toNamed(krLogin);
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
