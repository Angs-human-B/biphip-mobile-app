import 'package:bip_hip/controllers/gallery_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class GalleryVideos extends StatelessWidget {
  GalleryVideos({super.key});
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
              title: ksVideos.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: kHorizontalPadding, top: k12Padding, bottom: k12Padding),
              child: Column(
                children: [
                  GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _galleryController.galleryVideos.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1.2,
                        crossAxisCount: 2,
                        mainAxisSpacing: k12Padding,
                      ),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Row(children: [
                              CommonGalleryVideoContainer(
                                title: _galleryController.galleryVideos[index]['title'],
                                subTitle: _galleryController.galleryVideos[index]['items'],
                                video1: _galleryController.galleryVideos[index]['video1'],
                                video2: _galleryController.galleryVideos[index]['video2'],
                                video3: _galleryController.galleryVideos[index]['video3'],
                                onPressed: () {
                                  Get.toNamed(krVideos);
                                },
                              ),
                            ]),
                          ],
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CommonGalleryVideoContainer extends StatelessWidget {
  const CommonGalleryVideoContainer({super.key, required this.title, required this.subTitle, required this.video1, this.video2, this.video3, this.onPressed});
  final String title;
  final String subTitle;
  final String video1;
  final String? video2;
  final String? video3;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Theme(
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
                            height: 92,
                            width: (video2 == null && video3 == null) ? (width - 52) / 2 : (width - 52) / 4,
                            child: Image.network(
                              video1,
                              fit: BoxFit.cover,
                              color: cBlackColor.withOpacity(0.5),
                              colorBlendMode: BlendMode.multiply,
                            ),
                          ),
                          (video2 != null || video3 != null)
                              ? const SizedBox(
                                  width: 1,
                                )
                              : const SizedBox(),
                          Column(
                            children: [
                              video2 != null
                                  ? SizedBox(
                                      height: video3 == null ? 92 : 45.5,
                                      width: (width - 52) / 4,
                                      child: Image.network(
                                        video2!,
                                        fit: BoxFit.cover,
                                        color: cBlackColor.withOpacity(0.5),
                                        colorBlendMode: BlendMode.multiply,
                                      ),
                                    )
                                  : const SizedBox(),
                              (video2 != null && video3 != null)
                                  ? const SizedBox(
                                      height: 1,
                                    )
                                  : const SizedBox(),
                              video3 != null
                                  ? SizedBox(
                                      height: video2 == null ? 92 : 45.5,
                                      width: (width - 52) / 4,
                                      child: Image.network(
                                        video3!,
                                        fit: BoxFit.cover,
                                        color: cBlackColor.withOpacity(0.5),
                                        colorBlendMode: BlendMode.multiply,
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
        ),
        Positioned(
          top: 30,
          left: (width - 52) / 6,
          child: const Icon(
            BipHip.play,
            color: cWhiteColor,
            size: kIconSize40,
          ),
        ),
      ],
    );
  }
}
