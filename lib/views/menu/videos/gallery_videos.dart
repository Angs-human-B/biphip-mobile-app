import 'package:bip_hip/controllers/menu/gallery_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/videos/gallery_video_widgets/gallery_video_container.dart';

class GalleryVideos extends StatelessWidget {
  GalleryVideos({super.key});
  final GalleryController galleryController = Get.find<GalleryController>();
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
                      itemCount: galleryController.galleryVideos.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1.2,
                        crossAxisCount: 2,
                        mainAxisSpacing: k12Padding,
                      ),
                      itemBuilder: (context, index) {
                        return Row(children: [
                          GalleryVideoContainer(
                            title: galleryController.galleryVideos[index]['title'],
                            subTitle: galleryController.galleryVideos[index]['items'],
                            video1: galleryController.galleryVideos[index]['video1'],
                            video2: galleryController.galleryVideos[index]['video2'],
                            video3: galleryController.galleryVideos[index]['video3'],
                            onPressed: () {
                              Get.toNamed(krVideos);
                            },
                          ),
                        ]);
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
