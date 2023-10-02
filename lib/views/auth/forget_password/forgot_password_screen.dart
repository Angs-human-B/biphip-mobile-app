import 'package:bip_hip/controllers/authentication_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/top_text_and_subtext.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

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
                        title: ksTypeEmailOrPhone,
                        subTitle: ksSendCodeToConfirm,
                      ),
                      kH50sizedBox,
                      CustomModifiedTextField(
                        controller: _authenticationController.forgotPasswordEmailTextEditingController,
                        errorText: _authenticationController.forgotPasswordEmailError.value,
                        hint: ksEmail,
                        onChanged: (text) {
                          _authenticationController.checkCanSendOTP();
                          if (_authenticationController.forgotPasswordEmailTextEditingController.text.trim() == '') {
                            _authenticationController.forgotPasswordEmailError.value = ksEmptyEmailErrorMessage;
                          } else if (!_authenticationController.forgotPasswordEmailTextEditingController.text.trim().isValidEmail) {
                            _authenticationController.forgotPasswordEmailError.value = ksInvalidEmailErrorMessage;
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
                        label: ksNext,
                        onPressed: _authenticationController.canSendOTP.value
                            ? () async {
                                await _authenticationController.forgetPassword();
                              }
                            : null,
                        buttonWidth: width - 40,
                        textStyle:
                            _authenticationController.canSendOTP.value ? semiBold16TextStyle(cWhiteColor) : semiBold16TextStyle(cWhiteColor.withOpacity(.7)),
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
