import 'package:bip_hip/controllers/menu/gallery_controller.dart';
import 'package:bip_hip/helpers/gallery_photo_helpers/gallery_photo_helper.dart';
import 'package:bip_hip/shimmer_views/gallery_photo/gallery_photo_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/photos/photo_widgets/gallery_photo_container.dart';
import 'package:bip_hip/widgets/common/button/custom_tapable_container.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';

class GalleryPhotos extends StatelessWidget {
  GalleryPhotos({super.key});
  final GalleryController _galleryController = Get.find<GalleryController>();
  final GalleryPhotoHelper _galleryPhotoHelper = GalleryPhotoHelper();
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
                    buttonText: _galleryController.tapAbleButtonText,
                    buttonState: _galleryController.tapAbleButtonState,
                    buttonPress: RxList([
                      _galleryController.isAlbumListLoading.value
                          ? null
                          : () {
                              _galleryPhotoHelper.galleryPhotoFirstTapableButton();
                              _galleryController.toggleType(0);
                            },
                      _galleryController.isAlbumListLoading.value
                          ? null
                          : () {
                              _galleryPhotoHelper.galleryPhotoSecondTapableButton();
                              _galleryController.toggleType(1);
                            },
                    ]),
                  ),
                ),
                _galleryController.isAlbumListLoading.value
                    ? const GalleryPhotoShimmer()
                    : _galleryController.imageDataList.isEmpty
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
                                    itemCount: _galleryController.imageDataList.length,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: k4Padding + k2Padding,
                                      crossAxisCount: 2,
                                    ),
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Row(children: [
                                            GalleryPhotoContainer(
                                              title: _galleryController.imageDataList[index].title ?? ksNA.tr,
                                              subTitle: _galleryController.imageDataList[index].totalImage.toString(),
                                              image: _galleryController.imageDataList[index].preview,
                                              onPressed: () {
                                                _galleryController.selectedImageList = _galleryController.imageDataList[index].imageList;
                                                _galleryController.selectedTitle.value = _galleryController.imageDataList[index].title ?? ksNA;
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
