import 'package:bip_hip/controllers/authentication_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

import 'package:bip_hip/widgets/common/custom_app_bar.dart';
import 'package:bip_hip/widgets/common/custom_button.dart';

import 'package:bip_hip/widgets/common/top_text_and_subtext.dart';

class SelectProfessionScreen extends StatelessWidget {
  SelectProfessionScreen({super.key});

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
              hasBackButton: false,
              onBack: () {},
              action: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: CustomTextButton(onPressed: () {}, text: ksSkip, textStyle: regular14TextStyle(cPrimaryColor)),
                )
              ],
            ),
          ),
          backgroundColor: cWhiteColor,
          body: SizedBox(
            height: height,
            width: width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: Obx(
                () => Column(
                  children: [
                    kH24sizedBox,
                    kH24sizedBox,
                    const TopTitleAndSubtitle(
                      title: 'OTP Verification',
                      subTitle: 'Enter the verification code we just sent to your number at +880195XXXXXXX34',
                    ),
                    kH16sizedBox,
                    Spacer(),
                    CustomElevatedButton(
                      label: ksNext,
                      onPressed: _authenticationController.canOTPVerifyNow.value
                          ? () {
                              // Get.toNamed(krBirthday);
                            }
                          : null,
                      buttonWidth: width - 40,
                      textStyle:
                          _authenticationController.canOTPVerifyNow.value ? semiBold16TextStyle(cWhiteColor) : semiBold16TextStyle(cWhiteColor.withOpacity(.7)),
                    ),
                    kHBottomSizedBox
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
