import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/helpers/menu/kids/kid_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class KidPhotoPreview extends StatelessWidget {
  KidPhotoPreview({super.key});

  final KidsController kidsController = Get.find<KidsController>();
  final KidHelper kidHelper = KidHelper();

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
                    title: kidsController.isKidProfilePicEditor.value ? ksPreviewProfilePicture.tr : ksPreviewCoverPicture.tr,
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
                              kidHelper.resetKidImage();
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
                          kidsController.isKidProfilePicEditor.value
                              ? Container(
                                  width: width,
                                  color: cBlackColor,
                                  child: Container(
                                      height: width,
                                      width: width,
                                      decoration: const BoxDecoration(shape: BoxShape.circle),
                                      child: ClipOval(
                                        child: Image.file(
                                          kidsController.profileImageFile.value,
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
                                        kidsController.coverImageFile.value,
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
                                  value: kidsController.isSharedToNewFeed.value,
                                  onChanged: (value) {
                                    kidsController.isSharedToNewFeed.value = !kidsController.isSharedToNewFeed.value;
                                  },
                                )
                              ],
                            ),
                          ),
                          kH24sizedBox,
                          CustomElevatedButton(
                            buttonWidth: width - 40,
                            buttonHeight: h32,
                            label: ksSave.tr,
                            onPressed: () async {
                              if (kidsController.isKidProfilePicEditor.value) {
                                kidsController.newProfileImageFile.value = kidsController.profileImageFile.value;
                                await kidsController.uploadKidProfileAndCover(kidsController.newProfileImageFile.value, 'profile'); //!Api call
                              } else {
                                kidsController.newCoverImageFile.value = kidsController.coverImageFile.value;
                                await kidsController.uploadKidProfileAndCover(kidsController.newCoverImageFile.value, 'cover'); //!APi call
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
            // if (profileController.isImageUploadPageLoading.value == true)//!Condition for loading
            //   Positioned(
            //     child: CommonLoadingAnimation(
            //       onWillPop: () async {
            //         if (profileController.isImageUploadPageLoading.value) {
            //           return false;
            //         }
            //         return true;
            //       },
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
