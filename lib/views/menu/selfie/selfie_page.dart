import 'dart:ui';

import 'package:bip_hip/controllers/home/selfie_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class SelfiePage extends StatelessWidget {
  SelfiePage({super.key});
  final SelfieController selfieController = Get.find<SelfieController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: cWhiteColor,
        body: Column(
          children: [
            Stack(
              children: [
                if (selfieController.isSelfieImageChanged.value)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(k8BorderRadius),
                    child: Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(
                                selfieController.selfieImageFile.value,
                              ),
                              fit: BoxFit.cover)),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                        child: Container(
                          width: width - 40,
                          // height: 140,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(selfieController.selfieImageFile.value),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  left: 20,
                  top: 50,
                  child: SizedBox(
                    width: width - 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomIconButton(
                          onPress: () {
                            Get.back();
                          },
                          icon: BipHip.cross,
                          iconColor: cWhiteColor,
                          size: kIconSize24,
                        ),
                        Text(
                          ksText.tr,
                          style: regular16TextStyle(cWhiteColor),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  bottom: 20,
                  child: Column(
                    children: [
                      CustomIconButton(
                        onPress: () {},
                        icon: BipHip.downCircleArrowNew,
                        iconColor: cWhiteColor,
                        size: kIconSize20,
                      ),
                      Text(
                        ksSave,
                        style: regular12TextStyle(cWhiteColor),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 60,
                  bottom: 20,
                  child: Column(
                    children: [
                      CustomIconButton(
                        onPress: () {},
                        icon: BipHip.world,
                        iconColor: cWhiteColor,
                        size: kIconSize20,
                      ),
                      Text(
                        ksPrivacy.tr,
                        style: regular12TextStyle(cWhiteColor),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 20,
                  bottom: 20,
                  child: CustomElevatedButton(
                    buttonWidth: 90,
                    buttonHeight: h40,
                    buttonColor: cPrimaryColor,
                    label: ksShare.tr,
                    textStyle: semiBold16TextStyle(cWhiteColor),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
