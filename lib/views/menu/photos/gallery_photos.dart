import 'package:bip_hip/controllers/menu/gallery_controller.dart';
import 'package:bip_hip/helpers/menu/gallery/gallery_photo_helper.dart';
import 'package:bip_hip/shimmers/menu/gallery/gallery_photo_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/widgets/post_upper_container.dart';
import 'package:bip_hip/views/menu/photos/photos.dart';
import 'package:bip_hip/views/menu/photos/widgets/gallery_photo_container.dart';
import 'package:bip_hip/widgets/common/button/custom_tapable_container.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';

class GalleryPhotos extends StatelessWidget {
  GalleryPhotos({super.key});
  final GalleryController galleryController = Get.find<GalleryController>();
  final GalleryPhotoHelper galleryPhotoHelper = GalleryPhotoHelper();
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
                    title: ksPhotos.tr,
                    hasBackButton: true,
                    isCenterTitle: true,
                    onBack: () {
                      Get.back();
                    },
                    action: [
                      Padding(
                        padding: const EdgeInsets.only(right: k20Padding),
                        child: TextButton(
                          style: kTextButtonStyle,
                          onPressed: () {
                            galleryPhotoHelper.resetCreateAlbumData();
                            Get.toNamed(krCreateAlbum);
                          },
                          child: Text(
                            ksCreate.tr,
                            style: semiBold16TextStyle(cPrimaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                body: Obx(
                  () => Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                        child: TapAbleButtonContainer(
                          buttonText: galleryController.tapAbleButtonText,
                          buttonState: galleryController.tapAbleButtonState,
                          buttonPress: RxList([
                            galleryController.isAlbumListLoading.value
                                ? null
                                : () {
                                    galleryPhotoHelper.yourPhotosTapableButton();
                                    galleryController.toggleType(0);
                                  },
                            galleryController.isAlbumListLoading.value
                                ? null
                                : () {
                                    galleryPhotoHelper.albumsTapableButton();
                                    galleryController.toggleType(1);
                                  },
                          ]),
                        ),
                      ),
                      galleryController.isAlbumListLoading.value
                          ? const GalleryPhotoShimmer()
                          : galleryController.imageDataList.isEmpty
                              ? Expanded(
                                  child: Center(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: EmptyView(
                                        title: ksNoAlbumAvailable.tr,
                                      ),
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: k12Padding),
                                      child: GridView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: galleryController.imageDataList.length,
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisSpacing: k4Padding + k2Padding,
                                          crossAxisCount: 2,
                                        ),
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              Row(
                                                children: [
                                                  GalleryPhotoContainer(
                                                    title: galleryController.imageDataList[index].title ?? ksNA.tr,
                                                    subTitle: galleryController.imageDataList[index].totalImage.toString(),
                                                    image: galleryController.imageDataList[index].preview,
                                                    threeDotOnPressed: () {
                                                      galleryController.galleryPhotoActionSelect.value = '';
                                                      galleryController.galleryPhotoBottomSheetRightButtonState.value = false;
                                                      Get.find<GlobalController>().commonBottomSheet(
                                                        context: context,
                                                        isBottomSheetRightButtonActive: galleryController.galleryPhotoBottomSheetRightButtonState,
                                                        isScrollControlled: true,
                                                        content: GalleryPhotoActionContent(
                                                          defaultValue: galleryController.imageDataList[index].isDefault,
                                                          selectedIndex: index,
                                                        ),
                                                        onPressCloseButton: () {
                                                          Get.back();
                                                        },
                                                        onPressRightButton: () {},
                                                        rightText: ksDone.tr,
                                                        rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                                                        title: ksAction.tr,
                                                        isRightButtonShow: false,
                                                        bottomSheetHeight: galleryController.imageDataList[index].isDefault == 0 ? 180 : 120,
                                                      );
                                                    },
                                                    onPressed: () {
                                                      Get.to(() => Photos(
                                                            imageList: galleryController.imageDataList[index].imageList,
                                                            imageListTitle: galleryController.imageDataList[index].title ?? ksNA,
                                                          ));
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                    ],
                  ),
                ),
              ),
            ),
            if (galleryController.isDeleteAlbumLoading.value)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (galleryController.isDeleteAlbumLoading.value) {
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

class GalleryPhotoActionContent extends StatelessWidget {
  GalleryPhotoActionContent({super.key, this.defaultValue, this.selectedIndex});
  final int? defaultValue, selectedIndex;
  final GalleryController galleryController = Get.find<GalleryController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconWithTextRow(
          actionIcon: BipHip.downArrow,
          actionText: ksDownloadAlbum.tr,
          actionOnPressed: () {
            Get.back();
          },
        ),
        if (defaultValue == 0)
          IconWithTextRow(
            actionIcon: BipHip.editImageNew,
            actionText: ksEditAlbum.tr,
            actionOnPressed: () {
              Get.back();
              GalleryPhotoHelper().resetCreateAlbumData();
              galleryController.isEditAlbum.value = true;
              galleryController.selectedAlbumId.value = galleryController.imageDataList[selectedIndex!].id!;
              galleryController.createAlbumNameController.text = galleryController.imageDataList[selectedIndex!].title!;
              galleryController.previousAlbumName.value = galleryController.imageDataList[selectedIndex!].title!;
              galleryController.selectedPrivacyId.value = galleryController.imageDataList[selectedIndex!].privacy!;
              galleryController.temporaryprivacyId.value = galleryController.imageDataList[selectedIndex!].privacy!;
              galleryController.privacyId.value = galleryController.imageDataList[selectedIndex!].privacy!;
              galleryController.createAlbumSelectedPrivacy.value = Get.find<GlobalController>().privacyText(galleryController.privacyId.value);
              galleryController.createAlbumSelectedPrivacyIcon.value = Get.find<GlobalController>().privacyIcon(galleryController.privacyId.value);
              for (int i = 0; i < galleryController.imageDataList[selectedIndex!].imageList.length; i++) {
                if (galleryController.imageDataList[selectedIndex!].imageList[i].fullPath != null) {
                  galleryController.allMediaList.add(galleryController.imageDataList[selectedIndex!].imageList[i].fullPath);
                }
                galleryController.imageIdList.add(galleryController.imageDataList[selectedIndex!].imageList[i].id);
                galleryController.previousAlbumImageLength.value = galleryController.imageDataList[selectedIndex!].imageList.length;
                ll(galleryController.previousAlbumImageLength.value);
                galleryController.imageDescriptionTextEditingController
                    .add(TextEditingController(text: galleryController.imageDataList[selectedIndex!].imageList[i].description ?? ""));
                galleryController.imageLocationsList.add(galleryController.imageDataList[selectedIndex!].imageList[i].imageTakenLocation);
                galleryController.imageTimesList.add(galleryController.imageDataList[selectedIndex!].imageList[i].imageTakenTime);
                galleryController.imageTagIdList.add('1,58');
              }

              Get.toNamed(krCreateAlbum);
            },
          ),
        if (defaultValue == 0)
          IconWithTextRow(
            actionIcon: BipHip.deleteNew,
            actionText: ksDeleteAlbum.tr,
            actionOnPressed: () async {
              galleryController.selectedAlbumId.value = galleryController.imageDataList[selectedIndex!].id!;
              await galleryController.deleteAlbum(albumId: galleryController.selectedAlbumId.value);
            },
          ),
      ],
    );
  }
}

