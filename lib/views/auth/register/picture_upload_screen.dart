import 'dart:io';

import 'package:bip_hip/controllers/authentication_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/custom_app_bar.dart';
import 'package:bip_hip/widgets/common/custom_button.dart';
import 'package:bip_hip/widgets/common/top_text_and_subtext.dart';

class PictureUploadScreen extends StatelessWidget {
  PictureUploadScreen({super.key});

  final AuthenticationController _authenticationController = Get.find<AuthenticationController>();
  final GlobalController _globalController = Get.find<GlobalController>();

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
              hasBackButton: false,
              onBack: () {},
            ),
          ),
          backgroundColor: cWhiteColor,
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
                    const TopTitleAndSubtitle(
                      title: 'Add a profile photo to let your friends and family find you',
                    ),
                    kH35sizedBox,
                    ClipOval(
                      child: Container(
                        height: h134,
                        width: h134,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.file(
                          _authenticationController.profileFile.value ?? File(''),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => ClipOval(
                            child: Image.asset('assets/images/profileDefault.png'),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    CustomElevatedButton(
                      label: _authenticationController.isProfileImageChanged.value ? 'Save photo' : 'Add Photo',
                      onPressed: () {
                        showModalBottomSheet(
                          backgroundColor: cWhiteColor,
                          context: context,
                          builder: (context) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                kH35sizedBox,
                                CustomElevatedButton(
                                  label: 'Add photo',
                                  prefixIcon: BipHip.camera,
                                  labelIconColor: cIconColor,
                                  onPressed: () async {
                                    ll(_authenticationController.isProfileImageChanged.value);
                                    await _globalController.selectImageSource(_authenticationController.isProfileImageChanged,
                                        _authenticationController.profileLink, _authenticationController.profileFile, 'camera');
                                  },
                                  buttonHeight: h32,
                                  buttonWidth: width - 40,
                                  buttonColor: cWhiteColor,
                                  borderColor: cLineColor,
                                  textStyle: semiBold14TextStyle(cBlackColor),
                                ),
                                kH16sizedBox,
                                CustomElevatedButton(
                                  label: 'Choose from gallery',
                                  prefixIcon: BipHip.photo,
                                  labelIconColor: cIconColor,
                                  onPressed: () async {
                                    await _globalController.selectImageSource(_authenticationController.isProfileImageChanged,
                                        _authenticationController.profileLink, _authenticationController.profileFile, 'gallery');
                                  },
                                  buttonHeight: h32,
                                  buttonWidth: width - 40,
                                  buttonColor: cWhiteColor,
                                  borderColor: cLineColor,
                                  textStyle: semiBold14TextStyle(cBlackColor),
                                ),
                                kHBottomSizedBox
                              ],
                            );
                          },
                        );
                      },
                      buttonWidth: width - 40,
                      textStyle: semiBold16TextStyle(cWhiteColor),
                    ),
                    if (!_authenticationController.isProfileImageChanged.value) kH20sizedBox,
                    if (!_authenticationController.isProfileImageChanged.value)
                      CustomTextButton(onPressed: () {}, text: ksSkip, textStyle: semiBold16TextStyle(cBlackColor)),
                    kHBottomSizedBox
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
