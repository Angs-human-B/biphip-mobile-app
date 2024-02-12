import 'package:bip_hip/controllers/menu/gallery_controller.dart';
import 'package:bip_hip/helpers/menu/gallery/gallery_photo_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/widgets/common_photo_view.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Photos extends StatelessWidget {
  Photos({super.key, required this.imageList, this.imageListTitle});
  final List imageList;
  final String? imageListTitle;
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
              title: imageListTitle,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: SizedBox(
            height: height - kAppBarSize,
            width: width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: k8Padding, vertical: k8Padding),
              child: imageList.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Container(
                          alignment: Alignment.center,
                          child: EmptyView(
                            title: ksNoImageAvailable.tr,
                          ),
                        ),
                      ),
                    )
                  : GridView.custom(
                      physics: const AlwaysScrollableScrollPhysics(),
                      gridDelegate: SliverQuiltedGridDelegate(
                        crossAxisCount: 3,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        repeatPattern: QuiltedGridRepeatPattern.inverted,
                        pattern: const [
                          QuiltedGridTile(1, 1),
                          QuiltedGridTile(1, 1),
                          QuiltedGridTile(1, 1),
                          QuiltedGridTile(2, 3),
                          QuiltedGridTile(1, 1),
                          QuiltedGridTile(1, 1),
                          QuiltedGridTile(1, 1),
                          QuiltedGridTile(2, 2),
                          QuiltedGridTile(1, 1),
                          QuiltedGridTile(1, 1),
                          QuiltedGridTile(1, 1),
                          QuiltedGridTile(1, 1),
                          QuiltedGridTile(1, 1),
                        ],
                      ),
                      childrenDelegate: SliverChildBuilderDelegate(
                        childCount: imageList.length,
                        (context, index) {
                          String imageUrl = imageList[index].fullPath.toString();
                          return InkWell(
                            onTap: () async {
                              galleryController.imageId.value = imageList[index].id!;
                              ll(galleryController.imageId.value.toString());
                              await galleryController.getImageDetails();
                              // Get.toNamed(krPhotoDetails);
                              Get.to(() => CommonPhotoView(
                                    image: galleryController.imageDetailsData.value!.image!.fullPath.toString(),
                                    description: galleryController.imageDetailsData.value!.image!.description,
                                    onPressed: () {
                                      galleryController.photoActionSelect.value = '';
                                      Get.find<GlobalController>().blankBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        content: PhotoActionContent(),
                                        bottomSheetHeight: isDeviceScreenLarge() ? height * 0.4 : height * 0.4,
                                      );
                                    },
                                  ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: cLineColor),
                                borderRadius: k8CircularBorderRadius,
                              ),
                              child: ClipRRect(
                                borderRadius: k8CircularBorderRadius,
                                child: Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => const Icon(
                                    BipHip.imageFile,
                                    size: kIconSize70,
                                    color: cIconColor,
                                  ),
                                  loadingBuilder: imageLoadingBuilder,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class PhotoActionContent extends StatelessWidget {
  PhotoActionContent({super.key});
  final GalleryController galleryController = Get.find<GalleryController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: galleryController.photoActionList.length,
          separatorBuilder: (context, index) => kH8sizedBox,
          itemBuilder: (BuildContext context, int index) {
            return Obx(
              () => Padding(
                padding: const EdgeInsets.only(left: kHorizontalPadding),
                child: CustomListTile(
                  leading: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: cNeutralColor,
                    ),
                    height: h28,
                    width: h28,
                    child: Icon(
                      galleryController.photoActionList[index]['icon'],
                      color: cBlackColor,
                      size: kIconSize16,
                    ),
                  ),
                  title: galleryController.photoActionList[index]['action'].toString().tr,
                  titleTextStyle: semiBold16TextStyle(cBlackColor),
                  subTitleTextStyle: regular14TextStyle(cBlackColor),
                  itemColor: GalleryPhotoHelper().photoItemColor(index: index),
                  onPressed: () {
                    GalleryPhotoHelper().photoOnPressed(index: index);
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
