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
            () => SizedBox(
              width: width,
              height: height,
              child: SingleChildScrollView(
                child: Column(
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
                    kH12sizedBox,
                    if (_galleryController.tapAbleButtonState[0])
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CommonGalleryPhotoContainer(
                            title: ksProfile,
                            subTitle: ks18Items,
                            image1: kiDummyImage1ImageUrl,
                            image2: kiDummyImage2ImageUrl,
                            image3: kiDummyImage3ImageUrl,
                          ),
                          CommonGalleryPhotoContainer(
                            title: ksCovers,
                            subTitle: ks18Items,
                            image1: kiDummyImage1ImageUrl,
                            image2: kiDummyImage2ImageUrl,
                            image3: kiDummyImage3ImageUrl,
                          ),
                        ],
                      ),
                    if (_galleryController.tapAbleButtonState[1])
                      SizedBox(
                        width: width,
                        height: height,
                        child: const Column(
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
                                ),
                                CommonGalleryPhotoContainer(
                                  title: ksPoetry,
                                  subTitle: ks18Items,
                                  image1: kiDummyImage1ImageUrl,
                                  image2: kiDummyImage2ImageUrl,
                                  image3: kiDummyImage3ImageUrl,
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
                                ),
                                CommonGalleryPhotoContainer(
                                  title: ksPainting,
                                  subTitle: ks18Items,
                                  image1: kiDummyImage1ImageUrl,
                                  image2: kiDummyImage2ImageUrl,
                                  image3: kiDummyImage3ImageUrl,
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
                                ),
                                CommonGalleryPhotoContainer(
                                  title: ksKids,
                                  subTitle: ks18Items,
                                  image1: kiDummyImage1ImageUrl,
                                  image2: kiDummyImage2ImageUrl,
                                  image3: kiDummyImage3ImageUrl,
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
                                ),
                                CommonGalleryPhotoContainer(
                                  title: ksNews,
                                  subTitle: ks18Items,
                                  image1: kiDummyImage1ImageUrl,
                                  image2: kiDummyImage2ImageUrl,
                                  image3: kiDummyImage3ImageUrl,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CommonGalleryPhotoContainer extends StatelessWidget {
  const CommonGalleryPhotoContainer({super.key, required this.title, required this.subTitle, required this.image1, required this.image2, required this.image3});
  final String title;
  final String subTitle;
  final String image1;
  final String image2;
  final String image3;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: (width - 50) / 2,
          child: Row(children: [
            SizedBox(
              height: 100,
              width: (width - 50) / 2,
              child: Row(
                children: [
                  SizedBox(
                    height: 100,
                    width: (width - 50) / 4,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(k8BorderRadius), topLeft: Radius.circular(k8BorderRadius)),
                      child: Image.asset(
                        image1,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 50,
                        width: (width - 50) / 4,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(topRight: Radius.circular(k8BorderRadius)),
                          child: Image.asset(
                            image2,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: (width - 50) / 4,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(bottomRight: Radius.circular(k8BorderRadius)),
                          child: Image.asset(
                            image3,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
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
    );
  }
}
