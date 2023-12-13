import 'dart:math';

import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/helpers/auth/registration_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/auth/top_text_and_subtext.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
                            onPressed: () async {
                              registrationHelper.onPressedSavePhoto(context);
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
                                authenticationController.confettiController.play();
                                RegistrationHelper().congratulationsAlertDialog(
                                  context: context,
                                  content: const StarContent(),
                                );
                                await Future.delayed(const Duration(milliseconds: 3000));
                                authenticationController.confettiController.stop();
                                await Get.find<HomeController>().getPostList();
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

class StarContent extends StatelessWidget {
  const StarContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(k12BorderRadius),
              color: const Color(0xFF59FCCB),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ConfettiWidget(
                  confettiController: Get.find<AuthenticationController>().confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: true,
                  emissionFrequency: 0.20,
                  numberOfParticles: 20,
                  gravity: 0.1,
                ),
                RatingBar(
                  initialRating: 3,
                  itemCount: 3,
                  direction: Axis.horizontal,
                  glow: true,
                  glowColor: cAmberColor,
                  ratingWidget: RatingWidget(
                    full: const Icon(
                      Icons.star,
                      color: cAmberColor,
                      size: h20,
                    ),
                    half: const Icon(
                      Icons.star_half_outlined,
                      color: cAmberColor,
                    ),
                    empty: const Icon(
                      Icons.star,
                      color: cAmberColor,
                    ),
                  ),
                  onRatingUpdate: (value) {},
                ),
                Text(
                  ksYouGotBonus.tr,
                  style: semiBold14TextStyle(cBlackColor),
                ),
                const Text(
                  '100',
                  style: TextStyle(fontSize: 60, color: cLawnGreenColor),
                ),
                Transform.rotate(
                  angle: -pi / 12,
                  child: Text(
                    ksStar,
                    style: semiBold20TextStyle(cWhiteColor),
                  ),
                ),
              ],
            ),
          ),
          kH16sizedBox,
          Text(
            ksYouCouldSeeTheStar.tr,
            style: regular12TextStyle(cBlackColor),
          ),
          kH4sizedBox,
          Text(
            ksYouCanUseItAnywhere.tr,
            style: regular12TextStyle(cBlackColor),
          ),
        ],
      ),
    );
  }
}
