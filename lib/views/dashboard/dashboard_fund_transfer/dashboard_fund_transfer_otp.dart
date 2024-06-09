import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/auth/count_down.dart';
import 'package:bip_hip/widgets/common/button/linkup_text.dart';
import 'package:bip_hip/widgets/common/textfields/otp_textfield.dart';

class DashboardFundTransferOtp extends StatelessWidget {
  DashboardFundTransferOtp({super.key});
  final DashboardController dashboardController = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    heightWidthKeyboardValue(context);
    return Container(
      color: cWhiteColor,
      child: Stack(
        children: [
          SafeArea(
            top: false,
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kAppBarSize),
                //* info:: appBar
                child: CustomAppBar(
                  appBarColor: cTransparentColor,
                  title: ksOTPVerification.tr,
                  onBack: () async {
                    Get.back();
                  },
                ),
              ),
              backgroundColor: cTransparentColor,
              body: Obx(
                () => SizedBox(
                  height: height,
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                    child: Column(
                      children: [
                        kH20sizedBox,
                        // TopTitleAndSubtitle(
                        //   title: ksOTPVerification.tr,
                        //   subTitle: ksEnterCode.tr,
                        // ),
                        // Text(
                        //   "Enter the verification code. We just sent a code to your email address",
                        //   style: regular14TextStyle(cSmallBodyTextColor),
                        // ),
                        RichText(
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                          text: TextSpan(
                            children: [
                              TextSpan(text: '${ksEnterTheVerificationCode.tr} ', style: regular14TextStyle(cSmallBodyTextColor)),
                              TextSpan(
                                text: "sa*******ai@***.com",
                                style: semiBold14TextStyle(cSmallBodyTextColor),
                              ),
                            ],
                          ),
                        ),
                        kH50sizedBox,
                        OtpTextField(
                          controller: dashboardController.dashboardOtpTextEditingController,
                          onChange: (value) {
                            dashboardController.checkCanOTPVerifyNow();
                          },
                        ),
                        // kH16sizedBox,
                        const Spacer(),
                        CustomElevatedButton(
                          label: ksConfirm.tr,
                          onPressed: dashboardController.canOTPVerifyNow.value
                              ? () {
                                  // registrationHelper.onPressedVerifyOTP();
                                  Get.toNamed(krDashboardPage);
                                }
                              : null,
                          buttonWidth: width - 40,
                          textStyle:
                              dashboardController.canOTPVerifyNow.value ? semiBold16TextStyle(cWhiteColor) : semiBold16TextStyle(cWhiteColor.withOpacity(.7)),
                        ),
                        kH12sizedBox,
                        dashboardController.isOTPResendClick.value
                            ? LinkupTextRow(
                                prefix: ksResendCode.tr,
                                suffix: ksResend.tr,
                                onPressed: () async {
                                  unfocus(context);
                                  // await authenticationController.resendOTP();
                                },
                              )
                            : CountDown(
                                seconds: 120,
                                onEnd: () {
                                  dashboardController.isOTPResendClick.value = true;
                                },
                              ),
                        kH20sizedBox,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // if (dashboardController.isOTPLoading.value == true)
            //   Positioned(
            //     child: CommonLoadingAnimation(
            //       onWillPop: () async {
            //         if (authenticationController.isOTPLoading.value) {
            //           return false;
            //         }
            //         return true;
            //       },
            //     ),
          ),
        ],
      ),
    );
  }
}
