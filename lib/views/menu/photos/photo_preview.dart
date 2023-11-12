import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/profile_helpers/profile_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class PhotoPreview extends StatelessWidget {
  PhotoPreview({super.key});

  final ProfileController profileController = Get.find<ProfileController>();
  final ProfileHelper profileHelper = ProfileHelper();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Obx(
        () => Stack(
          children: [
            SafeArea(
              top: false,
              child: Scaffold(
                backgroundColor: cWhiteColor,
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(kAppBarSize),
                  //* info:: appBar
                  child: CustomAppBar(
                    appBarColor: cWhiteColor,
                    title: profileController.isProfilePicEditor.value ? ksPreviewProfilePicture.tr : ksPreviewCoverPicture.tr,
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
                              profileHelper.resetImage();
                            },
                            child: Text(
                              ksDiscard.tr,
                              style: regular14TextStyle(cRedColor),
                            )),
                      )
                    ],
                  ),
                ),
                body: SizedBox(
                  height: height - kAppBarSize - MediaQuery.of(context).padding.top,
                  width: width,
                  child: SingleChildScrollView(
                    child: Obx(
                      () => Column(
                        children: [
                          kH10sizedBox,
                          profileController.isProfilePicEditor.value
                              ? Container(
                                  width: width,
                                  color: cBlackColor,
                                  child: Container(
                                      height: width,
                                      width: width,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle),
                                      child: ClipOval(
                                        child: Image.file(
                                          profileController.profileImageFile.value,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) => ClipOval(
                                            child: Image.asset(
                                              kiProfileDefaultImageUrl,
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
                                        profileController.coverImageFile.value,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) => const Icon(
                                          BipHip.imageFile,
                                          size: kIconSize120,
                                          color: cIconColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          kH24sizedBox,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ksShareYourUpdateToNewsFeed.tr,
                                  style: regular18TextStyle(cBlackColor),
                                ),
                                Checkbox(
                                  value: profileController.isSharedToNewFeed.value,
                                  onChanged: (value) {
                                    profileController.isSharedToNewFeed.value = !profileController.isSharedToNewFeed.value;
                                  },
                                )
                              ],
                            ),
                          ),
                          // const Spacer(),
                          kH24sizedBox,
                          CustomElevatedButton(
                            buttonWidth: width - 40,
                            buttonHeight: h32,
                            label: ksSave.tr,
                            onPressed: () async {
                              if (profileController.isProfilePicEditor.value) {
                                profileController.newProfileImageFile.value = profileController.profileImageFile.value;
                                await profileController.uploadProfileAndCover(profileController.newProfileImageFile.value, 'profile');
                              } else {
                                profileController.newCoverImageFile.value = profileController.coverImageFile.value;
                                await profileController.uploadProfileAndCover(profileController.newCoverImageFile.value, 'cover');
                              }
                            },
                          ),
                          kHBottomSizedBox
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (profileController.isImageUploadPageLoading.value == true)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (profileController.isImageUploadPageLoading.value) {
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
