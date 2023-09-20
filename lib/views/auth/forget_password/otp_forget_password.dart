import 'package:bip_hip/controllers/authentication_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/count_down.dart';
import 'package:bip_hip/widgets/common/custom_app_bar.dart';
import 'package:bip_hip/widgets/common/custom_button.dart';
import 'package:bip_hip/widgets/common/linkup_text.dart';
import 'package:bip_hip/widgets/common/top_text_and_subtext.dart';
import 'package:bip_hip/widgets/textfields/otp_textfield.dart';

class ForgetPasswordOTP extends StatelessWidget {
  ForgetPasswordOTP({super.key});

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
                        title: 'OTP Verification',
                        subTitle: 'Enter the verification code we just sent to your email',
                      ),
                      kH50sizedBox,
                      OtpTextField(
                        controller: _authenticationController.forgotPasswordOTPTextEditingController,
                        onChange: (value) {
                          _authenticationController.checkCanForgotPasswordOTPVerifyNow();
                        },
                      ),
                      kH24sizedBox,
                      CustomElevatedButton(
                        label: ksNext,
                        onPressed: _authenticationController.canForgotPasswordOTPVerifyNow.value
                            ? () {
                                Get.toNamed(krResetPass);
                                _authenticationController.resetForgotPasswordScreen();
                              }
                            : null,
                        buttonWidth: width - 40,
                        textStyle: _authenticationController.canForgotPasswordOTPVerifyNow.value
                            ? semiBold16TextStyle(cWhiteColor)
                            : semiBold16TextStyle(cWhiteColor.withOpacity(.7)),
                      ),
                      kH25sizedBox,
                      _authenticationController.isForgotPasswordOTPResendClick.value
                          ? LinkupTextRow(
                              prefix: ksResendCode,
                              suffix: ksResend.tr,
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                _authenticationController.isForgotPasswordOTPResendClick.value = false;
                              },
                            )
                          : CountDown(
                              seconds: 120,
                              onEnd: () {
                                _authenticationController.isOTPResendClick.value = true;
                              },
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
