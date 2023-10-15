import 'package:bip_hip/controllers/gallery_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_tapable_container.dart';

class GalleryPhotos extends StatelessWidget {
  GalleryPhotos({super.key});
  final GalleryController _galleryController = Get.find<GalleryController>();
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
                            () {
                              _galleryController.imageDataList.clear();
                              for (var album in _galleryController.albumData.value!.imageAlbums!.data) {
                                if (album.title.toLowerCase() == 'profile picture' || album.title.toLowerCase() == 'cover photo') {
                                  _galleryController.imageDataList.add(album);
                                }
                              }

                              _galleryController.toggleType(0);
                            },
                            () {
                              _galleryController.imageDataList.clear();
                              for (var album in _galleryController.albumData.value!.imageAlbums!.data) {
                                if (album.title.toLowerCase() != 'profile picture' && album.title.toLowerCase() != 'cover photo') {
                                  _galleryController.imageDataList.add(album);
                                }
                              }

                              _galleryController.toggleType(1);
                            },
                          ]),
                        ),
                      ),
                      //*First Tapable Container view
                      if (_galleryController.tapAbleButtonState[0])
                        //    for(int index= 0; index< _galleryController.imageDataList.length;index++)
                        //   if(_galleryController.imageDataList[index].title.toString().toLowerCase() == 'profile picture' ||
                        // _galleryController.imageDataList[index].title.toString().toLowerCase() == 'cover photo')
                        //                   final filteredData = _galleryController.imageDataList.where((item) =>
                        //     item.title.toString().toLowerCase() == 'profile picture' ||
                        //     item.title.toString().toLowerCase() == 'cover photo'
                        // ).toList();

                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(left: kHorizontalPadding, top: k12Padding, bottom: k12Padding),
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: _galleryController.imageDataList.length,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 1.2,
                                    mainAxisSpacing: k12Padding,
                                    crossAxisCount: 2,
                                  ),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Row(children: [
                                          CommonGalleryPhotoContainer(
                                            title: _galleryController.imageDataList[index].title,
                                            subTitle: _galleryController.imageDataList[index].totalImage.toString(),
                                            image: _galleryController.imageDataList[index].preview,
                                            onPressed: () {
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

                      //*Second Tapable Container view
                      if (_galleryController.tapAbleButtonState[1])
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(left: kHorizontalPadding, top: k12Padding, bottom: k12Padding),
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: _galleryController.imageDataList.length,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 1.2,
                                    mainAxisSpacing: k12Padding,
                                    crossAxisCount: 2,
                                  ),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Row(children: [
                                          CommonGalleryPhotoContainer(
                                            title: _galleryController.imageDataList[index].title,
                                            subTitle: _galleryController.imageDataList[index].totalImage.toString(),
                                            image: _galleryController.imageDataList[index].preview,
                                            onPressed: () {
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
            if (_galleryController.isAlbumListLoading.value == true)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (_galleryController.isAlbumListLoading.value) {
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

class CommonGalleryPhotoContainer extends StatelessWidget {
  const CommonGalleryPhotoContainer({super.key, required this.title, required this.subTitle, this.onPressed, required this.image});
  final String title;
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(k8BorderRadius), topRight: Radius.circular(k8BorderRadius)),
                child: SizedBox(
                  width: (width - 50) / 2,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 94,
                        width: (image.length < 2) ? (width - 52) / 2 : (width - 52) / 4,
                        child: Image.network(
                          Environment.imageBaseUrl + image[0], //image1
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return SizedBox(
                              height: 94,
                              width: (width - 52) / 4,
                              child: Image.asset(
                                kiDummyImage3ImageUrl,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
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
                              height: image.length > 2 ? 46.5 : 94,
                              width: (width - 52) / 4,
                              child: Image.network(
                                Environment.imageBaseUrl + image[1], //image2!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          if (image.length > 2)
                            const SizedBox(
                              height: 1,
                            ),
                          if (image.length > 2)
                            SizedBox(
                              height: image.length > 2 ? 46.5 : 94,
                              width: (width - 52) / 4,
                              child: Image.network(
                                Environment.imageBaseUrl + image[2], //image3!,
                                fit: BoxFit.cover,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ]),
            Container(
              width: (width - 50) / 2,
              decoration: BoxDecoration(
                color: cWhiteColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                border: Border.all(width: 1, color: cLineColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kH8sizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: k4Padding),
                        child: Text(
                          title,
                          style: semiBold14TextStyle(cBlackColor),
                        ),
                      ),
                      const Icon(
                        BipHip.system,
                        size: kIconSize14,
                        color: cIconColor,
                      ),
                    ],
                  ),
                  kH4sizedBox,
                  Padding(
                    padding: const EdgeInsets.only(left: k4Padding),
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
    );
  }
}
