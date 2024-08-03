import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/helpers/auth/registration_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/auth/count_down.dart';
import 'package:bip_hip/widgets/common/utils/custom_circular_progress_bar.dart';
import 'package:bip_hip/widgets/common/button/linkup_text.dart';
import 'package:bip_hip/widgets/auth/top_text_and_subtext.dart';
import 'package:bip_hip/widgets/common/textfields/otp_textfield.dart';

class OTPVerifyScreen extends StatelessWidget {
  OTPVerifyScreen({super.key});

  final AuthenticationController authenticationController = Get.find<AuthenticationController>();
  final RegistrationHelper registrationHelper = RegistrationHelper();

  @override
  Widget build(BuildContext context) {
    heightWidthKeyboardValue(context);
    return Container(
      decoration: const BoxDecoration(color: cWhiteColor,image: DecorationImage(image: AssetImage(kiOnBoardingImageUrl), fit: BoxFit.cover)),
      child: Obx(
        () => Stack(
          children: [
            SafeArea(
              top: false,
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(kAppBarSize),
                  //* info:: appBar
                  child: Obx(
                    () => CustomAppBar(
                      appBarColor: cTransparentColor,
                      title: authenticationController.parentRoute.value == "register" ? ksRegistration.tr : ksForgetPassword.tr,
                      onBack: () async {
                        Get.back();
                      },
                      action: (authenticationController.parentRoute.value == "register")
                          ? [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: CustomCircularProgressBar(
                                  percent: authenticationController.parentRoute.value == "register" ? 1.0 : .66,
                                ),
                              ),
                            ]
                          : null,
                    ),
                  ),
                ),
                backgroundColor: cTransparentColor,
                body: SizedBox(
                  height: height,
                  width: width,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: Column(
                        children: [
                          kH48sizedBox,
                          TopTitleAndSubtitle(
                            title: ksOTPVerification.tr,
                            subTitle: ksEnterCode.tr,
                          ),
                          kH50sizedBox,
                          OtpTextField(
                            controller: authenticationController.otpTextEditingController,
                            onChange: (value) {
                              registrationHelper.checkCanOTPVerifyNow();
                            },
                          ),
                          kH16sizedBox,
                          CustomElevatedButton(
                            label: ksNext.tr,
                            onPressed: authenticationController.canOTPVerifyNow.value
                                ? () {
                                    registrationHelper.onPressedVerifyOTP();
                                  }
                                : null,
                            buttonWidth: width - 40,
                            textStyle: authenticationController.canOTPVerifyNow.value
                                ? semiBold16TextStyle(cWhiteColor)
                                : semiBold16TextStyle(cWhiteColor.withOpacity(.7)),
                          ),
                          kH28sizedBox,
                          authenticationController.isOTPResendClick.value
                              ? LinkupTextRow(
                                  prefix: ksResendCode.tr,
                                  suffix: ksResend.tr,
                                  onPressed: () async {
                                    unfocus(context);
                                    await authenticationController.resendOTP();
                                  },
                                )
                              : CountDown(
                                  seconds: 120,
                                  onEnd: () {
                                    authenticationController.isOTPResendClick.value = true;
                                  },
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (authenticationController.isOTPLoading.value == true)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (authenticationController.isOTPLoading.value) {
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
