import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/helpers/auth/registration_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/custom_circular_progress_bar.dart';
import 'package:bip_hip/widgets/common/utils/custom_container.dart';
import 'package:bip_hip/widgets/common/button/linkup_text.dart';
import 'package:bip_hip/widgets/auth/top_text_and_subtext.dart';

class Register extends StatelessWidget {
  Register({super.key});

  final AuthenticationController authenticationController = Get.find<AuthenticationController>();
  final RegistrationHelper registrationHelper = RegistrationHelper();

  @override
  Widget build(BuildContext context) {
    heightWidthKeyboardValue(context);
    return Container(
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(kiOnBoardingImageUrl), fit: BoxFit.cover)),
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              appBarColor: cTransparentColor,
              title: ksRegistration.tr,
              hasBackButton: false,
              onBack: () async {
                Get.back();
              },
              action: const [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: CustomCircularProgressBar(
                    percent: .16,
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
              child: Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                  child: Column(
                    children: [
                      kH24sizedBox,
                      if (authenticationController.isReferredRegistration.value)
                        const ReferLinkContainer(
                          referName: 'John Doe',
                        ),
                      kH24sizedBox,
                      TopTitleAndSubtitle(
                        title: ksWhatFullName.tr,
                        subTitle: ksWriteRealName.tr,
                      ),
                      kH50sizedBox,
                      CustomModifiedTextField(
                        controller: authenticationController.registerFirstNameTextEditingController,
                        errorText: authenticationController.firstNameError.value,
                        hint: ksFirstName.tr,
                        textHintStyle: regular16TextStyle(cPlaceHolderColor2),
                        fillColor: cWhiteColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(k4BorderRadius),
                          borderSide: const BorderSide(width: 1, color: cLineColor2),
                        ),
                        onChanged: (text) {
                          registrationHelper.registerFirstNameOnChange();
                        },
                        onSubmit: (text) {},
                        inputAction: TextInputAction.next,
                        inputType: TextInputType.name,
                      ),
                      kH4sizedBox,
                      CustomModifiedTextField(
                        controller: authenticationController.registerLastNameTextEditingController,
                        errorText: authenticationController.lastNameError.value,
                        hint: ksLastName.tr,
                        textHintStyle: regular16TextStyle(cPlaceHolderColor2),
                        fillColor: cWhiteColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(k4BorderRadius),
                          borderSide: const BorderSide(width: 1, color: cLineColor2),
                        ),
                        onChanged: (text) {
                          registrationHelper.registerLastNameOnChange();
                        },
                        onSubmit: (text) {},
                        inputAction: TextInputAction.done,
                        inputType: TextInputType.name,
                      ),
                      kH24sizedBox,
                      CustomElevatedButton(
                        label: ksNext.tr,
                        onPressed: authenticationController.checkValidName.value
                            ? () {
                                unfocus(context);
                                registrationHelper.onPressedNext();
                              }
                            : null,
                        buttonWidth: width - 40,
                        textStyle:
                            authenticationController.checkValidName.value ? semiBold16TextStyle(cWhiteColor) : semiBold16TextStyle(cWhiteColor.withOpacity(.7)),
                      ),
                      kH24sizedBox,
                      LinkupTextRow(
                        prefix: ksAlreadyHaveAccount.tr,
                        suffix: ksLogin.tr,
                        onPressed: () {
                          unfocus(context);
                          Get.toNamed(krLogin);
                        },
                      )
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

class ReferLinkContainer extends StatelessWidget {
  const ReferLinkContainer({super.key, required this.referName});

  final String referName;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                TextSpan(text: '${ksYouAreRegisteringWith.tr} ', style: regular14TextStyle(cBlackColor)),
                TextSpan(
                  text: referName,
                  style: semiBold14TextStyle(cBlackColor),
                ),
                TextSpan(
                  text: '\'s ${ksReferCodeSmall.tr}',
                  style: regular14TextStyle(cBlackColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
