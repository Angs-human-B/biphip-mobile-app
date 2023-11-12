import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/helpers/auth/registration_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/custom_circular_progress_bar.dart';
import 'package:bip_hip/widgets/auth/top_text_and_subtext.dart';

class SetEmail extends StatelessWidget {
  SetEmail({super.key});

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
          backgroundColor: cTransparentColor,
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
                        title: ksWhatEmail.tr,
                        subTitle: ksSendCodeToConfirm.tr,
                      ),
                      kH50sizedBox,
                      CustomModifiedTextField(
                        controller: authenticationController.registerEmailTextEditingController,
                        errorText: authenticationController.registerEmailError.value,
                        hint: ksEmail.tr,
                        textHintStyle: regular16TextStyle(cPlaceHolderColor2),
                        fillColor: cWhiteColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(k4BorderRadius),
                          borderSide: const BorderSide(width: 1, color: cLineColor2),
                        ),
                        onChanged: (text) {
                          registrationHelper.registerEmailOnChanged();
                        },
                        onSubmit: (text) {},
                        inputAction: TextInputAction.done,
                        inputType: TextInputType.emailAddress,
                      ),
                      kH24sizedBox,
                      CustomElevatedButton(
                        label: ksNext.tr,
                        onPressed: authenticationController.checkValidEmail.value
                            ? () async {
                                unfocus(context);
                                Get.toNamed(krSetNewPass);
                              }
                            : null,
                        buttonWidth: width - 40,
                        textStyle: authenticationController.checkValidEmail.value
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
