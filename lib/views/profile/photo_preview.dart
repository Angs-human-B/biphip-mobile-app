import 'package:bip_hip/controllers/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class PhotoPreview extends StatelessWidget {
  PhotoPreview({super.key});

  final ProfileController _profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: cWhiteColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              appBarColor: cWhiteColor,
              title: _profileController.isProfilePicEditor.value ? 'Preview profile picture'.tr : 'Preview cover picture'.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
              action: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: TextButton(
                      style: kTextButtonStyle,
                      onPressed: () {
                        Get.back();
                        _profileController.resetImage();
                      },
                      child: Text(
                        'Discard',
                        style: regular14TextStyle(cRedColor),
                      )),
                )
              ],
            ),
          ),
          body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: SizedBox(
              height: height - kAppBarSize,
              width: width,
              child: Obx(
                () => Column(
                  children: [
                    kH20sizedBox,
                    _profileController.isProfilePicEditor.value
                        ? Container(
                            width: width,
                            color: cBlackColor,
                            child: Container(
                                height: width,
                                width: width,
                                decoration: const BoxDecoration(
                                    // borderRadius: BorderRadius.circular(width / 2),
                                    shape: BoxShape.circle),
                                child: ClipOval(
                                  child: Image.file(
                                    _profileController.profileImageFile.value,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => ClipOval(
                                      child: Image.asset(
                                        'assets/images/profileDefault.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                )),
                          )
                        : Container(
                            width: width,
                            height: 250,
                            color: cBlackColor,
                            child: Center(
                              child: SizedBox(
                                  height: 150,
                                  width: width,
                                  child: Image.file(
                                    _profileController.coverImageFile.value,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Image.asset(
                                      'assets/images/coverPic.png',
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            ),
                          ),
                    kH24sizedBox,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Share your update to news feed',
                            style: regular18TextStyle(cBlackColor),
                          ),
                          Checkbox(
                              value: _profileController.isSharedToNewFeed.value,
                              onChanged: (value) {
                                _profileController.isSharedToNewFeed.value = !_profileController.isSharedToNewFeed.value;
                              })
                        ],
                      ),
                    ),
                    const Spacer(),
                    CustomElevatedButton(
                        buttonWidth: width - 40,
                        buttonHeight: h32,
                        label: 'Save',
                        onPressed: () {
                          if (_profileController.isProfilePicEditor.value) {
                            _profileController.newProfileImageFile.value = _profileController.profileImageFile.value;
                          } else {
                            _profileController.newCoverImageFile.value = _profileController.coverImageFile.value;
                          }
                          _profileController.resetImage();
                          Get.back();
                        }),
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
