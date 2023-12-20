import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/helpers/auth/registration_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/auth/top_text_and_subtext.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final AuthenticationController authenticationController = Get.find<AuthenticationController>();
  final RegistrationHelper registrationHelper = RegistrationHelper();

  @override
  Widget build(BuildContext context) {
    heightWidthKeyboardValue(context);
    return Container(
      decoration: const BoxDecoration(color: cWhiteColor, image: DecorationImage(image: AssetImage(kiOnBoardingImageUrl), fit: BoxFit.cover)),
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
                    appBarColor: cTransparentColor,
                    title: ksForgetPassword.tr,
                    onBack: () async {
                      Get.back();
                    },
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
                          kH24sizedBox,
                          kH24sizedBox,
                          TopTitleAndSubtitle(
                            title: ksTypeEmailOrPhone.tr,
                            subTitle: ksSendCodeToConfirm.tr,
                          ),
                          kH50sizedBox,
                          CustomModifiedTextField(
                            controller: authenticationController.forgotPasswordEmailTextEditingController,
                            errorText: authenticationController.forgotPasswordEmailError.value,
                            hint: ksEmail.tr,
                            textHintStyle: regular16TextStyle(cPlaceHolderColor2),
                            fillColor: cWhiteColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(k4BorderRadius),
                              borderSide: const BorderSide(width: 1, color: cLineColor2),
                            ),
                            onChanged: (text) {
                              registrationHelper.forgetPasswordEmailOnChanged();
                            },
                            onSubmit: (text) {},
                            inputAction: TextInputAction.done,
                            inputType: TextInputType.emailAddress,
                          ),
                          authenticationController.errorTextWiseResponsiveSizedBox(authenticationController.forgotPasswordEmailError.value),
                          CustomElevatedButton(
                            label: ksNext.tr,
                            onPressed: authenticationController.canSendOTP.value
                                ? () async {
                                    unfocus(context);
                                    await authenticationController.forgetPassword();
                                  }
                                : null,
                            buttonWidth: width - 40,
                            textStyle:
                                authenticationController.canSendOTP.value ? semiBold16TextStyle(cWhiteColor) : semiBold16TextStyle(cWhiteColor.withOpacity(.7)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (authenticationController.isForgetPasswordLoading.value == true)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (authenticationController.isForgetPasswordLoading.value) {
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
