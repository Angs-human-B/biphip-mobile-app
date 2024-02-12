import 'package:bip_hip/controllers/menu/gallery_controller.dart';
import 'package:bip_hip/helpers/menu/gallery/gallery_photo_helper.dart';
import 'package:bip_hip/shimmers/menu/gallery/gallery_photo_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
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
      child: SafeArea(
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
                      // Get.toNamed(krAddKidBasicInfo);
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
                              // physics: const NeverScrollableScrollPhysics(),
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
                                                  content: GalleryPhotoActionContent(),
                                                  onPressCloseButton: () {
                                                    Get.back();
                                                  },
                                                  onPressRightButton: () async {
                                                    Get.back();
                                                  },
                                                  rightText: ksDone.tr,
                                                  rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                                                  title: ksAction.tr,
                                                  isRightButtonShow: true,
                                                  bottomSheetHeight: 140,
                                                );
                                              },
                                              onPressed: () {
                                                Get.to(()=> Photos(imageList: galleryController.imageDataList[index].imageList,imageListTitle: galleryController.imageDataList[index].title ?? ksNA,));
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
    );
  }
}

class GalleryPhotoActionContent extends StatelessWidget {
  GalleryPhotoActionContent({super.key});
  final GalleryController galleryController = Get.find<GalleryController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: galleryController.galleryPhotoActionList.length,
          itemBuilder: (BuildContext context, int index) {
            return Obx(
              () => Padding(
                padding: const EdgeInsets.only(bottom: k8Padding),
                child: CustomListTile(
                  leading: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: cNeutralColor,
                    ),
                    height: h28,
                    width: h28,
                    child: Icon(
                      galleryController.galleryPhotoActionList[index]['icon'],
                      color: cBlackColor,
                      size: isDeviceScreenLarge() ? h18 : h14,
                    ),
                  ),
                  title: galleryController.galleryPhotoActionList[index]['action'].toString().tr,
                  titleTextStyle: semiBold16TextStyle(cBlackColor),
                  subTitleTextStyle: regular14TextStyle(cBlackColor),
                  trailing: CustomRadioButton(
                    onChanged: () {
                      GalleryPhotoHelper().galleryPhotoActionOnChanged(index: index);
                    },
                    isSelected: (galleryController.galleryPhotoActionSelect.value == galleryController.galleryPhotoActionList[index]['action']),
                  ),
                  itemColor: GalleryPhotoHelper().galleryPhotoItemColor(index: index),
                  onPressed: () {
                    GalleryPhotoHelper().galleryPhotoOnPressed(index: index);
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
