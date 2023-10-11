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
                      () {
                        _galleryController.toggleType(0);
                      },
                      () {
                        _galleryController.toggleType(1);
                      },
                    ]),
                  ),
                ),
                if (_galleryController.tapAbleButtonState[0])
                  Padding(
                    padding: const EdgeInsets.only(top: k12Padding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CommonGalleryPhotoContainer(
                          title: ksProfile,
                          subTitle: ks18Items,
                          image1: kiDummyImage1ImageUrl,
                          image2: kiDummyImage2ImageUrl,
                          image3: kiDummyImage3ImageUrl,
                          onPressed: () {
                            Get.toNamed(krPhotos);
                          },
                        ),
                        CommonGalleryPhotoContainer(
                          title: ksCovers,
                          subTitle: ks18Items,
                          image1: kiDummyImage1ImageUrl,
                          image2: kiDummyImage2ImageUrl,
                          image3: kiDummyImage3ImageUrl,
                          onPressed: () {
                            Get.toNamed(krPhotos);
                          },
                        ),
                      ],
                    ),
                  ),
                if (_galleryController.tapAbleButtonState[1])
                  Expanded(
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: k12Padding),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  CommonGalleryPhotoContainer(
                                    title: ksUntitled,
                                    subTitle: ks18Items,
                                    image1: kiDummyImage1ImageUrl,
                                    image2: kiDummyImage2ImageUrl,
                                    image3: kiDummyImage3ImageUrl,
                                    onPressed: () {
                                      Get.toNamed(krPhotos);
                                    },
                                  ),
                                  CommonGalleryPhotoContainer(
                                    title: ksPoetry,
                                    subTitle: ks18Items,
                                    image1: kiDummyImage1ImageUrl,
                                    image2: kiDummyImage2ImageUrl,
                                    image3: kiDummyImage3ImageUrl,
                                    onPressed: () {
                                      Get.toNamed(krPhotos);
                                    },
                                  ),
                                ],
                              ),
                              kH12sizedBox,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  CommonGalleryPhotoContainer(
                                    title: ksPhotography,
                                    subTitle: ks18Items,
                                    image1: kiDummyImage1ImageUrl,
                                    image2: kiDummyImage2ImageUrl,
                                    image3: kiDummyImage3ImageUrl,
                                    onPressed: () {
                                      Get.toNamed(krPhotos);
                                    },
                                  ),
                                  CommonGalleryPhotoContainer(
                                    title: ksPainting,
                                    subTitle: ks18Items,
                                    image1: kiDummyImage1ImageUrl,
                                    image2: kiDummyImage2ImageUrl,
                                    image3: kiDummyImage3ImageUrl,
                                    onPressed: () {
                                      Get.toNamed(krPhotos);
                                    },
                                  ),
                                ],
                              ),
                              kH12sizedBox,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  CommonGalleryPhotoContainer(
                                    title: ksStoryTelling,
                                    subTitle: ks18Items,
                                    image1: kiDummyImage1ImageUrl,
                                    image2: kiDummyImage2ImageUrl,
                                    image3: kiDummyImage3ImageUrl,
                                    onPressed: () {
                                      Get.toNamed(krPhotos);
                                    },
                                  ),
                                  CommonGalleryPhotoContainer(
                                    title: ksKids,
                                    subTitle: ks18Items,
                                    image1: kiDummyImage1ImageUrl,
                                    image2: kiDummyImage2ImageUrl,
                                    image3: kiDummyImage3ImageUrl,
                                    onPressed: () {
                                      Get.toNamed(krPhotos);
                                    },
                                  ),
                                ],
                              ),
                              kH12sizedBox,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  CommonGalleryPhotoContainer(
                                    title: ksSelling,
                                    subTitle: ks18Items,
                                    image1: kiDummyImage1ImageUrl,
                                    image2: kiDummyImage2ImageUrl,
                                    image3: kiDummyImage3ImageUrl,
                                    onPressed: () {
                                      Get.toNamed(krPhotos);
                                    },
                                  ),
                                  CommonGalleryPhotoContainer(
                                    title: ksNews,
                                    subTitle: ks18Items,
                                    image1: kiDummyImage1ImageUrl,
                                    image2: kiDummyImage2ImageUrl,
                                    image3: kiDummyImage3ImageUrl,
                                    onPressed: () {
                                      Get.toNamed(krPhotos);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
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
  const CommonGalleryPhotoContainer({super.key, required this.title, required this.subTitle, required this.image1, this.image2, this.image3, this.onPressed});
  final String title;
  final String subTitle;
  final String image1;
  final String? image2;
  final String? image3;
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
                borderRadius: BorderRadius.circular(k8BorderRadius),
                child: SizedBox(
                  height: 100,
                  width: (width - 50) / 2,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 100,
                        width: (image2 == null && image3 == null) ? (width - 50) / 2 : (width - 50) / 4,
                        child: Image.asset(
                          image1,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        children: [
                          image2 != null
                              ? SizedBox(
                                  height: image3 == null ? 100 : 50,
                                  width: (width - 50) / 4,
                                  child: Image.asset(
                                    image2!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const SizedBox(),
                          image3 != null
                              ? SizedBox(
                                  height: image2 == null ? 100 : 50,
                                  width: (width - 50) / 4,
                                  child: Image.asset(
                                    image3!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ]),
            kH4sizedBox,
            SizedBox(
              width: (width - 50) / 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: semiBold14TextStyle(cBlackColor),
                  ),
                  const Icon(
                    BipHip.system,
                    size: kIconSize14,
                    color: cIconColor,
                  ),
                ],
              ),
            ),
            kH4sizedBox,
            Text(
              subTitle,
              style: regular12TextStyle(cSmallBodyTextColor),
            ),
          ],
        ),
      ),
    );
  }
}
