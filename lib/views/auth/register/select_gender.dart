import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/helpers/auth/registration_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/custom_circular_progress_bar.dart';
import 'package:bip_hip/widgets/common/button/custom_selection_button.dart';
import 'package:bip_hip/widgets/auth/top_text_and_subtext.dart';

class SelectGender extends StatelessWidget {
  SelectGender({super.key});

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
                    percent: 0.48,
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
                        title: ksWhatGender.tr,
                        subTitle: ksChangeGender.tr,
                      ),
                      kH50sizedBox,
                      CustomSelectionButton(
                        buttonColor: cWhiteColor,
                        borderColor: cLineColor2,
                        onPressed: () {
                          ll(Get.find<GlobalController>().isBottomSheetRightButtonActive);
                          registrationHelper.onPressedSelectGender(context);
                        },
                        text: authenticationController.gender.value,
                        hintText: ksSelectGender.tr,
                      ),
                      isDeviceScreenLarge() ? kH30sizedBox : kH24sizedBox,
                      CustomElevatedButton(
                        label: ksNext.tr,
                        onPressed: authenticationController.gender.value != ''
                            ? () {
                                Get.toNamed(krSetEmail);
                              }
                            : null,
                        buttonWidth: width - 40,
                        textStyle:
                            authenticationController.gender.value != '' ? semiBold16TextStyle(cWhiteColor) : semiBold16TextStyle(cWhiteColor.withOpacity(.7)),
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
