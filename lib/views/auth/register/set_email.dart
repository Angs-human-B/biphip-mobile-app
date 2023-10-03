import 'package:bip_hip/controllers/authentication_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/custom_circular_progress_bar.dart';
import 'package:bip_hip/widgets/common/utils/top_text_and_subtext.dart';

class SetEmail extends StatelessWidget {
  SetEmail({super.key});

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
              title: ksRegistration.tr,
              onBack: () async {
                Get.back();
              },
              action: const [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: CustomCircularProgressBar(
                    percent: 0.64,
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
                child: Obx(
                  () => Column(
                    children: [
                      kH24sizedBox,
                      kH24sizedBox,
                      const TopTitleAndSubtitle(
                        title: ksWhatEmail,
                        subTitle: ksSendCodeToConfirm,
                      ),
                      kH50sizedBox,
                      CustomModifiedTextField(
                        controller: _authenticationController.registerEmailTextEditingController,
                        errorText: _authenticationController.registerEmailError.value,
                        hint: ksEmail,
                        onChanged: (text) {
                          _authenticationController.checkEmail();
                          if (_authenticationController.registerEmailTextEditingController.text.trim() == '') {
                            _authenticationController.registerEmailError.value = ksEmptyEmailErrorMessage;
                          } else if (!_authenticationController.registerEmailTextEditingController.text.trim().isValidEmail) {
                            _authenticationController.registerEmailError.value = ksInvalidEmailErrorMessage;
                          } else {
                            _authenticationController.registerEmailError.value = '';
                          }
                        },
                        onSubmit: (text) {},
                        inputAction: TextInputAction.done,
                        inputType: TextInputType.emailAddress,
                      ),
                      kH24sizedBox,
                      CustomElevatedButton(
                        label: ksNext,
                        onPressed: _authenticationController.checkValidEmail.value
                            ? () {
                                Get.toNamed(krSetNewPass);
                              }
                            : null,
                        buttonWidth: width - 40,
                        textStyle: _authenticationController.checkValidEmail.value
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
