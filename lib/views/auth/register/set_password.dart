import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/helpers/auth/registration_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/custom_circular_progress_bar.dart';
import 'package:bip_hip/widgets/auth/top_text_and_subtext.dart';

class SetPassword extends StatelessWidget {
  SetPassword({super.key});

  final FocusNode confirmPasswordFocusNode = FocusNode();
  final AuthenticationController authenticationController = Get.find<AuthenticationController>();
  final RegistrationHelper registrationHelper = RegistrationHelper();

  @override
  Widget build(BuildContext context) {
    heightWidthKeyboardValue(context);
    return Container(
      // color: cWhiteColor,
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(kiOnBoardingImageUrl), fit: BoxFit.cover)),
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
                            title: ksCreatePassword.tr,
                            subTitle: ksCreateStrongPassword.tr,
                          ),
                          kH50sizedBox,
                          CustomModifiedTextField(
                            controller: authenticationController.registerPasswordTextEditingController,
                            errorText: authenticationController.registerPasswordError.value,
                            hint: ksPassword.tr,
                            textHintStyle: regular16TextStyle(cPlaceHolderColor2),
                            fillColor: cWhiteColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(k4BorderRadius),
                              borderSide: const BorderSide(width: 1, color: cLineColor2),
                            ),
                            suffixIcon: authenticationController.isRegisterPasswordToggleObscure.value ? BipHip.passwordHide : Icons.visibility_outlined,
                            onSuffixPress: () {
                              authenticationController.isRegisterPasswordToggleObscure.value = !authenticationController.isRegisterPasswordToggleObscure.value;
                            },
                            onChanged: (text) {
                              registrationHelper.passwordOnChanged();
                            },
                            onSubmit: (text) {
                              FocusScope.of(context).requestFocus(confirmPasswordFocusNode);
                            },
                            obscureText: authenticationController.isRegisterPasswordToggleObscure.value,
                            inputAction: TextInputAction.next,
                            inputType: TextInputType.visiblePassword,
                          ),
                          kH4sizedBox,
                          CustomModifiedTextField(
                            controller: authenticationController.registerConfirmPasswordTextEditingController,
                            focusNode: confirmPasswordFocusNode,
                            errorText: authenticationController.registerConfirmPasswordError.value,
                            hint: ksConfirmPassword.tr,
                            textHintStyle: regular16TextStyle(cPlaceHolderColor2),
                            fillColor: cWhiteColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(k4BorderRadius),
                              borderSide: const BorderSide(width: 1, color: cLineColor2),
                            ),
                            suffixIcon: authenticationController.isRegisterConfirmPasswordToggleObscure.value ? BipHip.passwordHide : Icons.visibility_outlined,
                            onSuffixPress: () {
                              authenticationController.isRegisterConfirmPasswordToggleObscure.value =
                                  !authenticationController.isRegisterConfirmPasswordToggleObscure.value;
                            },
                            onChanged: (text) {
                              registrationHelper.confirmPasswordOnChanged();
                            },
                            onSubmit: (text) {
                              FocusScope.of(context).unfocus();
                            },
                            obscureText: authenticationController.isRegisterConfirmPasswordToggleObscure.value,
                            inputAction: TextInputAction.done,
                            inputType: TextInputType.visiblePassword,
                          ),
                          kH24sizedBox,
                          CustomElevatedButton(
                            label: ksNext.tr,
                            onPressed: authenticationController.checkValidPassword.value
                                ? () async {
                                    unfocus(context);
                                    await authenticationController.userRegister();
                                  }
                                : null,
                            buttonWidth: width - 40,
                            textStyle: authenticationController.checkValidPassword.value
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
            if (authenticationController.isRegisterLoading.value == true)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (authenticationController.isRegisterLoading.value) {
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
