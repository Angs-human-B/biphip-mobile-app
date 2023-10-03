import 'dart:io';
import 'package:bip_hip/controllers/authentication_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/top_text_and_subtext.dart';

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
                            ),
                            child: Image.file(
                              _authenticationController.profileFile.value ?? File(''),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => ClipOval(
                                child: Image.asset(kiProfileDefaultImageUrl),
                              ),
                            ),
                          ),
                        ),
                        if (_authenticationController.isProfileImageChanged.value)
                          Positioned(
                            top: 5,
                            right: 5,
                            child: TextButton(
                              onPressed: () {
                                _authenticationController.resetProfileImage();
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
                      label: _authenticationController.isProfileImageChanged.value ? ksSavePhoto.tr : ksAddPhoto.tr,
                      onPressed: () {
                        if (!_authenticationController.isProfileImageChanged.value) {
                          _globalController.commonBottomSheet(
                              context: context,
                              onPressCloseButton: () {
                                Get.back();
                              },
                              onPressRightButton: () {},
                              rightText: '',
                              rightTextStyle: regular14TextStyle(cBiddingColor),
                              title: ksUploadPhoto.tr,
                              isRightButtonShow: false,
                              isScrollControlled: false,
                              bottomSheetHeight: 180,
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomElevatedButton(
                                    label: ksAddPhoto.tr,
                                    prefixIcon: BipHip.camera,
                                    prefixIconColor: cIconColor,
                                    suffixIconColor: cIconColor,
                                    onPressed: () async {
                                      ll(_authenticationController.isProfileImageChanged.value);
                                      await _globalController.selectImageSource(_authenticationController.isProfileImageChanged,
                                          _authenticationController.profileLink, _authenticationController.profileFile, 'camera', true);
                                    },
                                    buttonHeight: h32,
                                    buttonWidth: width - 40,
                                    buttonColor: cWhiteColor,
                                    borderColor: cLineColor,
                                    textStyle: semiBold14TextStyle(cBlackColor),
                                  ),
                                  kH16sizedBox,
                                  CustomElevatedButton(
                                    label: ksChooseFromGallery.tr,
                                    prefixIcon: BipHip.photo,
                                    prefixIconColor: cIconColor,
                                    suffixIconColor: cIconColor,
                                    onPressed: () async {
                                      await _globalController.selectImageSource(_authenticationController.isProfileImageChanged,
                                          _authenticationController.profileLink, _authenticationController.profileFile, 'gallery', true);
                                    },
                                    buttonHeight: h32,
                                    buttonWidth: width - 40,
                                    buttonColor: cWhiteColor,
                                    borderColor: cLineColor,
                                    textStyle: semiBold14TextStyle(cBlackColor),
                                  ),
                                ],
                              ));
                        } else {
                          _authenticationController.resetProfileImage();
                        }
                      },
                      buttonWidth: width - 40,
                      textStyle: semiBold16TextStyle(cWhiteColor),
                    ),
                    if (!_authenticationController.isProfileImageChanged.value) kH20sizedBox,
                    if (!_authenticationController.isProfileImageChanged.value)
                      CustomElevatedButton(
                        buttonWidth: width - 40,
                        buttonColor: cWhiteColor,
                        onPressed: () {
                          Get.offAllNamed(krMenu);
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
    );
  }
}
