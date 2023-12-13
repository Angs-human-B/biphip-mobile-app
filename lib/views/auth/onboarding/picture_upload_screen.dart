import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/helpers/auth/registration_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/auth/top_text_and_subtext.dart';

class PictureUploadScreen extends StatelessWidget {
  PictureUploadScreen({super.key});

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
                    hasBackButton: false,
                    onBack: () {},
                  ),
                ),
                backgroundColor: cTransparentColor,
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
                          TopTitleAndSubtitle(
                            title: ksAddProfilePhoto.tr,
                          ),
                          kH35sizedBox,
                          Stack(
                            children: [
                              ClipOval(
                                child: Container(
                                  height: h134,
                                  width: h134,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: cBlackColor,
                                  ),
                                  child: Image.file(
                                    authenticationController.profileFile.value,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => const Icon(
                                      BipHip.user,
                                      size: kIconSize70,
                                      color: cIconColor,
                                    ),
                                  ),
                                ),
                              ),
                              if (authenticationController.isProfileImageChanged.value)
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: TextButton(
                                    onPressed: () {
                                      authenticationController.resetProfileImage();
                                    },
                                    style: kTextButtonStyle,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: cWhiteColor,
                                      ),
                                      child: const Icon(
                                        BipHip.circleCrossNew,
                                        color: cRedColor,
                                        size: kIconSize30,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const Spacer(),
                          CustomElevatedButton(
                            label: authenticationController.isProfileImageChanged.value ? ksSavePhoto.tr : ksAddPhoto.tr,
                            onPressed: () {
                              registrationHelper.onPressedSavePhoto(context);
                              Get.find<HomeController>().congratulationsAlertDialog(
                                  context: context,
                                  content: Column(
                                    children: [
                                      Image.asset(kiProfileDefaultImageUrl),
                                    ],
                                  ));
                            },
                            buttonWidth: width - 40,
                            textStyle: semiBold16TextStyle(cWhiteColor),
                          ),
                          if (!authenticationController.isProfileImageChanged.value) kH20sizedBox,
                          if (!authenticationController.isProfileImageChanged.value)
                            CustomElevatedButton(
                              buttonWidth: width - 40,
                              buttonColor: cWhiteColor,
                              onPressed: () async {
                                Get.offAllNamed(krHome);
                                Get.find<HomeController>().congratulationsAlertDialog(
                                    context: context,
                                    content: Column(
                                      children: [
                                        Image.asset(kiProfileDefaultImageUrl),
                                      ],
                                    ));
                                // await Get.find<HomeController>().getPostList();
                              },
                              label: ksSkip.tr,
                              textStyle: semiBold16TextStyle(cPrimaryColor),
                            ),
                          kHBottomSizedBox
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (authenticationController.isImageUploadLoading.value)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (authenticationController.isImageUploadLoading.value) {
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
