import 'package:bip_hip/controllers/authentication_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/custom_app_bar.dart';
import 'package:bip_hip/widgets/common/custom_button.dart';
import 'package:bip_hip/widgets/common/custom_container.dart';
import 'package:bip_hip/widgets/common/linkup_text.dart';
import 'package:bip_hip/widgets/common/top_text_and_subtext.dart';
import 'package:bip_hip/widgets/textfields/custom_textfield.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Register extends StatelessWidget {
  Register({super.key});

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
              title: ksRegisterNow.tr,
              hasBackButton: false,
              onBack: () async {
                Get.back();
              },
              action: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircularPercentIndicator(
                    animateFromLastPercent: false,
                    radius: 10.0,
                    lineWidth: 2.0,
                    animation: true,
                    percent: .16,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: cPrimaryColor,
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
              child: Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                  child: Column(
                    children: [
                      kH24sizedBox,
                      if (_authenticationController.isReferredRegistration.value)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                          child: CustomTintContainer(
                            width: width,
                            borderRadius: k100CircularBorderRadius,
                            widget: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: k16Padding, vertical: k12Padding),
                              child: RichText(
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.clip,
                                text: TextSpan(
                                  children: [
                                    TextSpan(text: 'You are registering with ', style: regular14TextStyle(cBlackColor)),
                                    //TODO: Referal name here
                                    TextSpan(
                                      text: 'John Doe',
                                      style: semiBold14TextStyle(cBlackColor),
                                    ),
                                    TextSpan(
                                      text: '\'s referral link',
                                      style: regular14TextStyle(cBlackColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      kH24sizedBox,
                      const TopTitleAndSubtitle(
                        title: 'What\'s your full name?',
                        subTitle: 'Writing your real name will help others to find you.',
                      ),
                      kH50sizedBox,
                      CustomModifiedTextField(
                        controller: _authenticationController.registerFirstNameTextEditingController,
                        hint: "First Name",
                        onChanged: (text) {
                          _authenticationController.checkCanLogin();
                        },
                        onSubmit: (text) {},
                        inputAction: TextInputAction.next,
                        inputType: TextInputType.name,
                      ),
                      kH24sizedBox,
                      CustomModifiedTextField(
                        controller: _authenticationController.registerLastNameTextEditingController,
                        hint: "Last Name",
                        onChanged: (text) {
                          _authenticationController.checkName();
                        },
                        onSubmit: (text) {},
                        inputAction: TextInputAction.done,
                        inputType: TextInputType.name,
                      ),
                      kH24sizedBox,
                      CustomElevatedButton(
                        label: ksNext,
                        onPressed: _authenticationController.checkValidName.value
                            ? () {
                                Get.toNamed(krSelectBirthday);
                              }
                            : null,
                        buttonWidth: width - 40,
                        textStyle: _authenticationController.checkValidName.value
                            ? semiBold16TextStyle(cWhiteColor)
                            : semiBold16TextStyle(cWhiteColor.withOpacity(.7)),
                      ),
                      kH24sizedBox,
                      LinkupTextRow(
                          prefix: "Already have an account?",
                          suffix: 'Login',
                          onPressed: () {
                            Get.toNamed(krLogin);
                          })
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
