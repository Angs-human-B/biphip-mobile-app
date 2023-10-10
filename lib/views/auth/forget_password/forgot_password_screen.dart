import 'package:bip_hip/controllers/authentication_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/custom_circular_progress_bar.dart';
import 'package:bip_hip/widgets/common/utils/top_text_and_subtext.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

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
                    title: ksForgetPassword.tr,
                    onBack: () async {
                      Get.back();
                    },
                    action: const [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: CustomCircularProgressBar(
                          percent: .33,
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
                            title: ksTypeEmailOrPhone.tr,
                            subTitle: ksSendCodeToConfirm.tr,
                          ),
                          kH50sizedBox,
                          CustomModifiedTextField(
                            controller: _authenticationController.forgotPasswordEmailTextEditingController,
                            errorText: _authenticationController.forgotPasswordEmailError.value,
                            hint: ksEmail.tr,
                            onChanged: (text) {
                              _authenticationController.checkCanSendOTP();
                              if (_authenticationController.forgotPasswordEmailTextEditingController.text.trim() == '') {
                                _authenticationController.forgotPasswordEmailError.value = ksEmptyEmailErrorMessage.tr;
                              } else if (!_authenticationController.forgotPasswordEmailTextEditingController.text.trim().isValidEmail) {
                                _authenticationController.forgotPasswordEmailError.value = ksInvalidEmailErrorMessage.tr;
                              } else {
                                _authenticationController.forgotPasswordEmailError.value = '';
                              }
                            },
                            onSubmit: (text) {},
                            inputAction: TextInputAction.done,
                            inputType: TextInputType.emailAddress,
                          ),
                          kH24sizedBox,
                          CustomElevatedButton(
                            label: ksNext.tr,
                            onPressed: _authenticationController.canSendOTP.value
                                ? () async {
                                    await _authenticationController.forgetPassword();
                                  }
                                : null,
                            buttonWidth: width - 40,
                            textStyle: _authenticationController.canSendOTP.value
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
         
          if (_authenticationController.isForgetPasswordLoading.value == true)
                      Positioned(
                        child: CommonLoadingAnimation(
                          onWillPop: () async {
                            if (_authenticationController.isForgetPasswordLoading.value) {
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
