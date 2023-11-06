import 'package:bip_hip/controllers/menu/gallery_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_tapable_container.dart';

class GalleryPhotos extends StatelessWidget {
  GalleryPhotos({super.key});
  final GalleryController _galleryController = Get.find<GalleryController>();
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
                              _galleryController.imageDataList.clear();
                              for (var album in _galleryController.albumData.value!.imageAlbums!.data) {
                                if (album.title!.toLowerCase() == 'profile picture' || album.title!.toLowerCase() == 'cover photo') {
                                  _galleryController.imageDataList.add(album);
                                }
                              }

                              _galleryController.toggleType(0);
                            },
                      _galleryController.isAlbumListLoading.value
                          ? null
                          : () {
                              _galleryController.imageDataList.clear();
                              for (var album in _galleryController.albumData.value!.imageAlbums!.data) {
                                if (album.title!.toLowerCase() != 'profile picture' && album.title!.toLowerCase() != 'cover photo') {
                                  _galleryController.imageDataList.add(album);
                                }
                              }

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
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: k12Padding),
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: _galleryController.imageDataList.length,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      // childAspectRatio: 1.1,
                                      mainAxisSpacing: k12Padding,
                                      crossAxisSpacing: k4Padding + k2Padding,
                                      crossAxisCount: 2,
                                    ),
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Row(children: [
                                            CommonGalleryPhotoContainer(
                                              title: _galleryController.imageDataList[index].title ?? ksNA.tr,
                                              subTitle: _galleryController.imageDataList[index].totalImage.toString(),
                                              image: _galleryController.imageDataList[index].preview,
                                              onPressed: () {
                                                // _galleryController.selectedImageList = [];
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

class CommonGalleryPhotoContainer extends StatelessWidget {
  const CommonGalleryPhotoContainer({super.key, this.title, required this.subTitle, this.onPressed, required this.image});
  final String? title;
  final String subTitle;
  final List image;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: cTransparentColor,
        highlightColor: cTransparentColor,
      ),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: cLineColor),
            borderRadius: k8CircularBorderRadius,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              image.isEmpty
                  ? SizedBox(
                      width: (width - 60) / 2,
                      height: 101,
                      child: const Icon(
                        BipHip.imageFile,
                        size: kIconSize70,
                        color: cIconColor,
                      ),
                    )
                  : Row(children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(k8BorderRadius), topRight: Radius.circular(k8BorderRadius)),
                        child: SizedBox(
                          width: (width - 50) / 2,
                          child: Row(
                            children: [
                              SizedBox(
                                height: 101,
                                width: (image.length < 2) ? (width - 50) / 2 : (width - 52) / 4,
                                child: Image.network(
                                  Environment.imageBaseUrl + image[0],
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => const Icon(
                                    BipHip.imageFile,
                                    size: kIconSize70,
                                    color: cIconColor,
                                  ),
                                  loadingBuilder: imageLoadingBuilder,
                                ),
                              ),
                              (image.length > 1)
                                  ? const SizedBox(
                                      width: 1,
                                    )
                                  : const SizedBox(),
                              Column(
                                children: [
                                  if (image.length > 1)
                                    SizedBox(
                                      height: image.length > 2 ? 50 : 101,
                                      width: (width - 52) / 4,
                                      child: Image.network(
                                        Environment.imageBaseUrl + image[1],
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) => const Icon(
                                          BipHip.imageFile,
                                          size: kIconSize70,
                                          color: cIconColor,
                                        ),
                                        loadingBuilder: imageLoadingBuilder,
                                      ),
                                    ),
                                  if (image.length > 2)
                                    const SizedBox(
                                      height: 1,
                                    ),
                                  if (image.length > 2)
                                    SizedBox(
                                      height: image.length > 2 ? 50 : 101,
                                      width: (width - 52) / 4,
                                      child: Image.network(
                                        Environment.imageBaseUrl + image[2],
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) => const Icon(
                                          BipHip.imageFile,
                                          size: kIconSize70,
                                          color: cIconColor,
                                        ),
                                        loadingBuilder: imageLoadingBuilder,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
              SizedBox(
                width: (width - 50) / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kH8sizedBox,
                    Padding(
                      padding: const EdgeInsets.only(left: k4Padding + k2Padding),
                      child: Text(
                        title!,
                        style: semiBold14TextStyle(cBlackColor),
                      ),
                    ),
                    kH4sizedBox,
                    Padding(
                      padding: const EdgeInsets.only(left: k4Padding + k2Padding),
                      child: Text(
                        subTitle,
                        style: regular12TextStyle(cSmallBodyTextColor),
                      ),
                    ),
                    kH4sizedBox,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GalleryPhotoShimmer extends StatelessWidget {
  const GalleryPhotoShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kH12sizedBox,
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 20,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: k10Padding,
                  mainAxisSpacing: k4Padding,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: k8CircularBorderRadius,
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: k8CircularBorderRadius,
                            child: ShimmerCommon(
                              widget: Container(
                                color: cWhiteColor,
                                height: 100,
                                width: ((width - 52) / 2),
                              ),
                            ),
                          ),
                          kH8sizedBox,
                          ShimmerCommon(
                            widget: Container(
                              decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                              height: 12,
                              width: 80,
                            ),
                          ),
                          kH4sizedBox,
                          ShimmerCommon(
                            widget: Container(
                              decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                              height: 12,
                              width: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({super.key, required this.title, this.height});
  final String title;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Center(
        child: Text(
          title,
          style: semiBold16TextStyle(cPlaceHolderColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
