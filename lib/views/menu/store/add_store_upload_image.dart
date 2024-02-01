import 'package:bip_hip/controllers/menu/store_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/kids/add_kid_basic_info.dart';
import 'package:bip_hip/views/menu/kids/add_kid_upload_image.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';

class AddStoreUploadImage extends StatelessWidget {
  AddStoreUploadImage({super.key});
  final StoreController storeController = Get.find<StoreController>();
  final GlobalController globalController = Get.find<GlobalController>();
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
              title: ksAddStore.tr,
              hasBackButton: false,
              leadingWidth: 80,
              leadingWidget: Center(
                child: InkWell(
                  onTap: () {
                    unFocus(context);
                    Get.back();
                  },
                  child: Text(
                    ksPrevious.tr,
                    style: semiBold14TextStyle(cPrimaryColor),
                  ),
                ),
              ),
              isCenterTitle: true,
              onBack: null,
            ),
          ),
          body: Column(
            children: [
              const CustomDivider(
                thickness: 1,
              ),
              KidTopTitleSubtitleAndCircularProgressBar(
                title: ksUploadImages.tr,
                subTitle: ksUploadProfileAndCoverPhoto.tr,
                circularCenterText: ks5of5.tr,
                percent: 1,
              ),
              kH16sizedBox,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: CustomDivider(
                  thickness: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding).copyWith(top: k16Padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => KidProfileAndCoverPhotoUpload(
                        title: ksProfilePicture,
                        subTitle: ksMaximumPhotoSize,
                        profileCoverPhoto: storeController.isStoreProfileImageChanged.value ? storeController.storeProfileImageFile.value : null,
                        removePictureOnPressed: () {
                          storeController.resetStoreProfilePictureData();
                        },
                        onPressed: () {
                          unFocus(context);
                          globalController.commonBottomSheet(
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
                              content: StoreProfilePictureUploadContent());
                        },
                      ),
                    ),
                    kH16sizedBox,
                    Obx(() => KidProfileAndCoverPhotoUpload(
                          title: ksCoverPhoto,
                          subTitle: ksMaximumPhotoSize,
                          profileCoverPhoto: storeController.isStoreCoverImageChanged.value ? storeController.storeCoverImageFile.value : null,
                          removePictureOnPressed: () {
                            storeController.resetStoreCoverPhotoData();
                          },
                          onPressed: () {
                            unFocus(context);
                            globalController.commonBottomSheet(
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
                                content: StoreCoverPhotoUploadContent());
                          },
                        )),
                  ],
                ),
              ),
              const Spacer(),
              CustomElevatedButton(
                buttonWidth: width - 40,
                buttonHeight: h40,
                label: ksComplete.tr,
                onPressed: () {
                  unFocus(context);
                  Get.offNamedUntil(krStore, ModalRoute.withName(krMenu));
                },
                textStyle: semiBold16TextStyle(cWhiteColor),
              ),
              kH20sizedBox,
            ],
          ),
        ),
      ),
    );
  }
}

class StoreProfilePictureUploadContent extends StatelessWidget {
  StoreProfilePictureUploadContent({super.key});
  final StoreController storeController = Get.find<StoreController>();
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomElevatedButton(
          label: ksAddPhoto.tr,
          prefixIcon: BipHip.camera,
          prefixIconColor: cIconColor,
          suffixIconColor: cIconColor,
          onPressed: () async {
            await globalController.selectImageSource(
                storeController.isStoreProfileImageChanged, storeController.storeProfileImageLink, storeController.storeProfileImageFile, 'camera', true);
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
            await globalController.selectImageSource(
                storeController.isStoreProfileImageChanged, storeController.storeProfileImageLink, storeController.storeProfileImageFile, 'gallery', true);
          },
          buttonHeight: h32,
          buttonWidth: width - 40,
          buttonColor: cWhiteColor,
          borderColor: cLineColor,
          textStyle: semiBold14TextStyle(cBlackColor),
        ),
      ],
    );
  }
}

class StoreCoverPhotoUploadContent extends StatelessWidget {
  StoreCoverPhotoUploadContent({super.key});
  final StoreController storeController = Get.find<StoreController>();
  final GlobalController globalController = Get.find<GlobalController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomElevatedButton(
          label: ksAddPhoto.tr,
          prefixIcon: BipHip.camera,
          prefixIconColor: cIconColor,
          suffixIconColor: cIconColor,
          onPressed: () async {
            await globalController.selectImageSource(
                storeController.isStoreCoverImageChanged, storeController.storeCoverImageLink, storeController.storeCoverImageFile, 'camera', true);
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
            await globalController.selectImageSource(
                storeController.isStoreCoverImageChanged, storeController.storeCoverImageLink, storeController.storeCoverImageFile, 'gallery', true);
          },
          buttonHeight: h32,
          buttonWidth: width - 40,
          buttonColor: cWhiteColor,
          borderColor: cLineColor,
          textStyle: semiBold14TextStyle(cBlackColor),
        ),
      ],
    );
  }
}
