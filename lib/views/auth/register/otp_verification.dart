import 'package:bip_hip/controllers/authentication_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/count_down.dart';
import 'package:bip_hip/widgets/common/utils/custom_circular_progress_bar.dart';
import 'package:bip_hip/widgets/common/button/linkup_text.dart';
import 'package:bip_hip/widgets/common/utils/top_text_and_subtext.dart';
import 'package:bip_hip/widgets/common/textfields/otp_textfield.dart';

class OTPVerifyScreen extends StatelessWidget {
  OTPVerifyScreen({super.key});

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
            child: Obx(
              () => CustomAppBar(
                title: _authenticationController.parentRoute.value == "register" ? ksRegistration.tr : ksForgetPassword.tr,
                onBack: () async {
                  Get.back();
                },
                action: (_authenticationController.parentRoute.value == "register" || _authenticationController.parentRoute.value == "forget-password")
                    ? [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: CustomCircularProgressBar(
                            percent: _authenticationController.parentRoute.value == "register" ? 1.0 : .66,
                          ),
                        ),
                      ]
                    : null,
              ),
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
                        title: ksOTPVerification.tr,
                        subTitle: ksEnterCode.tr,
                      ),
                      kH50sizedBox,
                      OtpTextField(
                        controller: _authenticationController.otpTextEditingController,
                        onChange: (value) {
                          _authenticationController.checkCanOTPVerifyNow();
                        },
                      ),
                      kH24sizedBox,
                      CustomElevatedButton(
                        label: ksNext.tr,
                        onPressed: _authenticationController.canOTPVerifyNow.value
                            ? () async {
                                if (_authenticationController.parentRoute.value == "login") {
                                  await _authenticationController.signUpVerify();
                                } else if (_authenticationController.parentRoute.value == "register") {
                                  await _authenticationController.signUpVerify();
                                } else {
                                  await _authenticationController.forgetPasswordVerify();
                                }
                              }
                            : null,
                        buttonWidth: width - 40,
                        textStyle: _authenticationController.canOTPVerifyNow.value
                            ? semiBold16TextStyle(cWhiteColor)
                            : semiBold16TextStyle(cWhiteColor.withOpacity(.7)),
                      ),
                      kH25sizedBox,
                      _authenticationController.isOTPResendClick.value
                          ? LinkupTextRow(
                              prefix: ksResendCode.tr,
                              suffix: ksResend.tr,
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                await _authenticationController.resendOTP();
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
