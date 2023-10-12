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
                //*First Tapable Container view
                if (_galleryController.tapAbleButtonState[0])
                  Padding(
                    padding: const EdgeInsets.only(left: kHorizontalPadding, top: k12Padding, bottom: k12Padding),
                    child: Column(
                      children: [
                        GridView.builder(
                            shrinkWrap: true,
                            itemCount: _galleryController.galleryYourPhotos.length,
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
                                      title: _galleryController.galleryYourPhotos[index]['title'],
                                      subTitle: _galleryController.galleryYourPhotos[index]['items'],
                                      image1: _galleryController.galleryYourPhotos[index]['image1'],
                                      image2: _galleryController.galleryYourPhotos[index]['image2'],
                                      image3: _galleryController.galleryYourPhotos[index]['image3'],
                                      onPressed: () {
                                        Get.toNamed(krPhotos);
                                      },
                                    ),
                                  ]),
                                ],
                              );
                            }),
                      ],
                    ),
                  ),
                //*Second Tapable Container view
                if (_galleryController.tapAbleButtonState[1])
                  SizedBox(
                    height: height - (kAppBarSize + MediaQuery.of(context).padding.top + 30), //* (height- 30) because tapable container height is 30
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: kHorizontalPadding, top: k12Padding, bottom: k12Padding),
                        child: GridView.builder(
                            shrinkWrap: true,
                            primary: false,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _galleryController.galleryAlbumPhotos.length,
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
                                      title: _galleryController.galleryAlbumPhotos[index]['title'],
                                      subTitle: _galleryController.galleryAlbumPhotos[index]['items'],
                                      image1: _galleryController.galleryAlbumPhotos[index]['image1'],
                                      image2: _galleryController.galleryAlbumPhotos[index]['image2'],
                                      image3: _galleryController.galleryAlbumPhotos[index]['image3'],
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
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(k8BorderRadius), topRight: Radius.circular(k8BorderRadius)),
                child: SizedBox(
                  width: (width - 50) / 2,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 94,
                        width: (image2 == null && image3 == null) ? (width - 52) / 2 : (width - 52) / 4,
                        child: Image.asset(
                          image1,
                          fit: BoxFit.cover,
                        ),
                      ),
                      (image2 != null || image3 != null)
                          ? const SizedBox(
                              width: 1,
                            )
                          : const SizedBox(),
                      Column(
                        children: [
                          image2 != null
                              ? SizedBox(
                                  height: image3 == null ? 94 : 46.5,
                                  width: (width - 52) / 4,
                                  child: Image.asset(
                                    image2!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const SizedBox(),
                          (image2 != null && image3 != null)
                              ? const SizedBox(
                                  height: 1,
                                )
                              : const SizedBox(),
                          image3 != null
                              ? SizedBox(
                                  height: image2 == null ? 94 : 46.5,
                                  width: (width - 52) / 4,
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
