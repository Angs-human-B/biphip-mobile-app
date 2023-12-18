import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/helpers/auth/registration_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/auth/top_text_and_subtext.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_svg/svg.dart';

class PictureUploadScreen extends StatelessWidget {
  PictureUploadScreen({super.key});

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
                            onPressed: () async {
                              registrationHelper.onPressedSavePhoto(context);
                              if (authenticationController.isProfileImageChanged.value) {
                                authenticationController.confettiController.play();
                                RegistrationHelper().congratulationsAlertDialog(
                                  context: context,
                                  content: const StarContent(),
                                );
                                await Future.delayed(const Duration(milliseconds: 1500));
                                authenticationController.confettiController.stop();
                              }
                            },
                            buttonWidth: width - 40,
                            textStyle: semiBold16TextStyle(cWhiteColor),
                          ),
                          if (!authenticationController.isProfileImageChanged.value) kH8sizedBox,
                          if (!authenticationController.isProfileImageChanged.value)
                            CustomElevatedButton(
                              buttonWidth: width - 40,
                              buttonColor: cTransparentColor,
                              onPressed: () async {
                                Get.offAllNamed(krHome);
                                authenticationController.confettiController.play();
                                RegistrationHelper().congratulationsAlertDialog(
                                  context: context,
                                  content: const StarContent(),
                                );
                                await Future.delayed(const Duration(milliseconds: 1500));
                                authenticationController.confettiController.stop();
                                await Get.find<HomeController>().getPostList();
                              },
                              label: ksSkip.tr,
                              textStyle: semiBold16TextStyle(cBlackColor),
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

class StarContent extends StatelessWidget {
  const StarContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        ConfettiWidget(
          confettiController: Get.find<AuthenticationController>().confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: true,
          emissionFrequency: 0.20,
          numberOfParticles: 10,
          gravity: 0.6,
        ),
        Stack(
          children: [
            SvgPicture.asset(kiRegistrationBonusSvgUrl),
            Positioned(
              left: 80,
              top: 110,
              child: Text(
                '100',
                style: semiBold20TextStyle(cLawnGreenColor).copyWith(
                  fontSize: h60,
                  shadows: [
                    const Shadow(
                      color: cOrangeColor,
                      offset: Offset(2.5, 2.5),
                      blurRadius: 0,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        kH4sizedBox,
        Text(
          ksYouCouldSeeTheStar.tr,
          style: regular14TextStyle(cBlackColor),
        ),
        kH4sizedBox,
        Text(
          ksYouCanUseItAnywhere.tr,
          style: regular14TextStyle(cBlackColor),
        ),
      ],
    );
  }
}

class CommonAlertDialog extends StatelessWidget {
  const CommonAlertDialog({
    this.title,
    required this.addContent,
    this.hasCloseBtn = false,
    this.hasDivider = true,
    this.actions,
    this.onClose,
    this.horizontalContentPadding,
    this.verticalContentPadding,
    Key? key,
  }) : super(key: key);

  final String? title;
  final Widget? addContent;
  final bool hasCloseBtn, hasDivider;
  final List<Widget>? actions;
  final Function()? onClose;
  final double? horizontalContentPadding;
  final double? verticalContentPadding;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: cWhiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(h10),
      ),
      elevation: 0,
      titlePadding: EdgeInsets.zero,
      title: ClipRRect(
        borderRadius: BorderRadius.circular(h10),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                if (title != null)
                  Center(
                    child: Text(
                      title.toString(),
                      textAlign: TextAlign.center,
                      style: semiBold16TextStyle(cBlackColor),
                    ),
                  ),
                if (hasCloseBtn)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: CustomIconButton(
                      hasBorder: false,
                      onPress: onClose,
                      icon: BipHip.circleCross,
                      size: height > kSmallDeviceSizeLimit ? kIconSize20 : kIconSize16,
                    ),
                  ),
              ],
            ),
            const CustomDivider(
              thickness: 0.3,
            )
          ],
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: horizontalContentPadding ?? k16Padding,
        vertical: verticalContentPadding ?? k10Padding,
      ),
      insetPadding: const EdgeInsets.all(k20Padding),
      content: addContent,
      actions: actions,
    );
  }
}
