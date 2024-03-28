import 'package:bip_hip/controllers/menu/store_controller.dart';
import 'package:bip_hip/helpers/menu/store/store_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class StorePhotoPreview extends StatelessWidget {
  StorePhotoPreview({super.key});

  final StoreController storeController = Get.find<StoreController>();
  final StoreHelper storeHelper = StoreHelper();

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
                    title: storeController.isStoreProfilePicEditor.value ? ksPreviewProfilePicture.tr : ksPreviewCoverPicture.tr,
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
                              storeHelper.resetStoreImage();
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
                          storeController.isStoreProfilePicEditor.value
                              ? Container(
                                  width: width,
                                  color: cBlackColor,
                                  child: Container(
                                      height: width,
                                      width: width,
                                      decoration: const BoxDecoration(shape: BoxShape.circle),
                                      child: ClipOval(
                                        child: Image.file(
                                          storeController.profileImageFile.value,
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
                                        storeController.coverImageFile.value,
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
                                  value: storeController.isSharedToNewFeed.value,
                                  onChanged: (value) {
                                    storeController.isSharedToNewFeed.value = !storeController.isSharedToNewFeed.value;
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
                              if (storeController.isStoreProfilePicEditor.value) {
                                storeController.newProfileImageFile.value = storeController.profileImageFile.value;
                                await storeController.uploadStoreProfileAndCover(storeController.newProfileImageFile.value, 'profile'); 
                              } else {
                                storeController.newCoverImageFile.value = storeController.coverImageFile.value;
                                await storeController.uploadStoreProfileAndCover(storeController.newCoverImageFile.value, 'cover'); 
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
            if (storeController.isImageUploadPageLoading.value == true)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (storeController.isImageUploadPageLoading.value) {
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
