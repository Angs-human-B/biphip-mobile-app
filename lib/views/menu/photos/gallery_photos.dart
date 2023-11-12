import 'package:bip_hip/controllers/menu/gallery_controller.dart';
import 'package:bip_hip/helpers/menu/gallery/gallery_photo_helper.dart';
import 'package:bip_hip/shimmer/menu/gallery/gallery_photo_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/photos/photo_widgets/gallery_photo_container.dart';
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
                              galleryPhotoHelper.galleryPhotoFirstTapableButton();
                              galleryController.toggleType(0);
                            },
                      galleryController.isAlbumListLoading.value
                          ? null
                          : () {
                              galleryPhotoHelper.galleryPhotoSecondTapableButton();
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
                              physics: const NeverScrollableScrollPhysics(),
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
                                          Row(children: [
                                            GalleryPhotoContainer(
                                              title: galleryController.imageDataList[index].title ?? ksNA.tr,
                                              subTitle: galleryController.imageDataList[index].totalImage.toString(),
                                              image: galleryController.imageDataList[index].preview,
                                              onPressed: () {
                                                galleryController.selectedImageList = galleryController.imageDataList[index].imageList;
                                                galleryController.selectedTitle.value = galleryController.imageDataList[index].title ?? ksNA;
                                                Get.toNamed(krPhotos);
                                              },
                                            ),
                                          ]),
                                        ],
                                      );
                                    }),
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
