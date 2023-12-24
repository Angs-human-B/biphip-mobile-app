import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/helpers/auth/registration_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/auth/top_text_and_subtext.dart';
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
                          kH48sizedBox,
                          TopTitleAndSubtitle(
                            title: ksAddProfilePhoto.tr,
                          ),
                          kH35sizedBox,
                          Expanded(
                            child: Stack(
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
                          ),
                          CustomElevatedButton(
                            label: authenticationController.isProfileImageChanged.value ? ksSavePhoto.tr : ksAddPhoto.tr,
                            onPressed: () async {
                              registrationHelper.savePhoto(context);
                            },
                            buttonWidth: width - 40,
                            textStyle: semiBold16TextStyle(cWhiteColor),
                          ),
                          if (!authenticationController.isProfileImageChanged.value)
                            Padding(
                              padding: const EdgeInsets.only(top: h8),
                              child: CustomElevatedButton(
                                buttonWidth: width - 40,
                                buttonColor: cTransparentColor,
                                onPressed: () async {
                                  Get.offAllNamed(krHome);
                                  registrationHelper.showConfettiWithCongratulationPopUp(context);
                                  await Get.find<HomeController>().getPostList();
                                },
                                label: ksSkip.tr,
                                textStyle: semiBold16TextStyle(cBlackColor),
                              ),
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
          confettiController: Get.find<AuthenticationController>().confettiController1,
          blastDirectionality: BlastDirectionality.explosive,
          numberOfParticles: 8,
          gravity: 0.8,
          createParticlePath: drawCustomConfetti1,
          colors: const [
            cOrangeColor,
            cRedColor,
          ],
        ),
        ConfettiWidget(
          confettiController: Get.find<AuthenticationController>().confettiController2,
          blastDirectionality: BlastDirectionality.explosive,
          numberOfParticles: 8,
          gravity: 0.8,
          createParticlePath: drawCustomConfetti2,
          colors: const [
            cOrangeColor,
            cRedColor,
          ],
        ),
        ConfettiWidget(
          confettiController: Get.find<AuthenticationController>().confettiController3,
          blastDirectionality: BlastDirectionality.explosive,
          numberOfParticles: 8,
          gravity: 0.8,
          createParticlePath: drawCustomConfetti3,
          colors: const [
            cOrangeColor,
            cRedColor,
          ],
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

Path drawCustomConfetti1(Size size) {
  final path = Path();
  path.moveTo(0, 10);
  path.quadraticBezierTo(5, 0, 15, 10);
  path.quadraticBezierTo(20, 20, 25, 10);
  path.quadraticBezierTo(30, 0, 35, 10);
  path.quadraticBezierTo(40, 20, 45, 10);
  path.lineTo(41, 6);
  path.quadraticBezierTo(40, 16, 35, 6);
  path.quadraticBezierTo(30, -4, 25, 6);
  path.quadraticBezierTo(20, 16, 15, 6);
  path.quadraticBezierTo(5, -4, 0, 6);
  path.lineTo(0, 10);
  path.close();
  return path;
}

Path drawCustomConfetti2(Size size) {
  final path = Path();
  path.moveTo(0, 10);
  path.quadraticBezierTo(15, 20, 30, 10);
  path.lineTo(25, 5);
  path.quadraticBezierTo(5, 15, -10, 5);
  path.lineTo(0, 10);
  path.close();
  return path;
}

Path drawCustomConfetti3(Size size) {
  final path = Path();
  path.moveTo(-8, 0);
  path.lineTo(-10, 5);
  path.quadraticBezierTo(0, 10, 10, 5);
  path.lineTo(8, 0);
  path.quadraticBezierTo(0, 5, -8, 0);
  path.close();
  return path;
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
        child: Container(
          width: width - 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(h10),
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  if (title != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: k16Padding),
                      child: Center(
                        child: Text(
                          title.toString(),
                          textAlign: TextAlign.center,
                          style: semiBold18TextStyle(cBlackColor),
                        ),
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
            ],
          ),
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
