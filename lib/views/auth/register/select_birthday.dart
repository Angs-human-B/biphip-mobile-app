import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/auth/registration_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/custom_circular_progress_bar.dart';
import 'package:bip_hip/widgets/common/button/custom_selection_button.dart';
import 'package:bip_hip/widgets/auth/top_text_and_subtext.dart';

class SelectBirthday extends StatelessWidget {
  SelectBirthday({super.key});

  final AuthenticationController authenticationController = Get.find<AuthenticationController>();
  final ProfileController profileController = Get.find<ProfileController>();
  final RegistrationHelper registrationHelper = RegistrationHelper();

  @override
  Widget build(BuildContext context) {
    heightWidthKeyboardValue(context);

    return Container(
      // color: cWhiteColor,
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(kiOnBoardingImageUrl), fit: BoxFit.cover)),
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              appBarColor: cTransparentColor,
              title: profileController.isRouteFromAboutInfo.value ? ksEditBirthday.tr : ksRegistration.tr,
              onBack: () async {
                Get.back();
              },
              action: [
                if (!profileController.isRouteFromAboutInfo.value)
                  const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: CustomCircularProgressBar(
                      percent: 0.32,
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
                      if (!profileController.isRouteFromAboutInfo.value) kH24sizedBox,
                      if (!profileController.isRouteFromAboutInfo.value) kH24sizedBox,
                      TopTitleAndSubtitle(
                        title: !profileController.isRouteFromAboutInfo.value ? ksWhatBirthday.tr : '',
                        subTitle: !profileController.isRouteFromAboutInfo.value ? ksChangeBirthday.tr : ksChangeYourBirthdayFromHere.tr,
                      ),
                      profileController.isRouteFromAboutInfo.value ? kH20sizedBox : kH50sizedBox,
                      CustomSelectionButton(
                        buttonColor: cWhiteColor,
                        borderColor: cLineColor2,
                        onPressed: () {
                          registrationHelper.onPressedSelectBirthday(context);
                        },
                        text: authenticationController.birthDay.value != '' ? authenticationController.birthDay.value : '',
                        hintText: ksSelectDOB.tr,
                      ),
                      isDeviceScreenLarge() ? kH30sizedBox : kH24sizedBox,
                      CustomElevatedButton(
                        label: profileController.isRouteFromAboutInfo.value ? ksSave.tr : ksNext.tr,
                        onPressed: authenticationController.birthDay.value != ''
                            ? () async {
                                registrationHelper.onPressedConfirmBirthday();
                              }
                            : null,
                        buttonWidth: width - 40,
                        textStyle:
                            authenticationController.birthDay.value != '' ? semiBold16TextStyle(cWhiteColor) : semiBold16TextStyle(cWhiteColor.withOpacity(.7)),
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
