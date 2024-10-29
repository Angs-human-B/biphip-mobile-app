import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:bip_hip/helpers/profile_view/profile_view_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProfileViewAllPhotoGridView extends StatelessWidget {
  ProfileViewAllPhotoGridView({super.key});
  final ProfileViewController profileViewController = Get.find<ProfileViewController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => profileViewController.isAllImageListLoading.value
          ? const ProfileViewPhotoShimmer()
          : (profileViewController.allPhotoList.isEmpty || profileViewController.kidAllImageList.isEmpty || profileViewController.storeAllImageList.isEmpty)
              ? Container(
                  width: width - 40,
                  height: height * 0.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(k8BorderRadius),
                    border: Border.all(width: 1, color: cLineColor),
                  ),
                  child: EmptyView(title: ksNoImageAvailable.tr))
              : Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GridView.custom(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
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
                            childCount: ProfileViewHelper().getUserKidOrStoreAllImageListLength(type: profileViewController.profileViewType.value),
                            (context, index) {
                              // var item = ProfileViewHelper().getUserKidOrStoreAllImageList(type: profileViewController.profileViewType.value);
                              // String imageUrl = profileViewController.allImageList[index].fullPath ?? "";
                              String imageUrl =
                                  ProfileViewHelper().getUserKidOrStoreAllImageListSingleImage(type: profileViewController.profileViewType.value, index: index);
                              return InkWell(
                                onTap: () async {
                                  // galleryController.imageId.value = imageList[index].id!;
                                  // await galleryController.getImageDetails();
                                  // galleryController.imageData.value?.description = null;
                                  // Get.find<PostReactionController>().isRouteFromHomePage.value = false;
                                  // Get.to(() => GalleryWidget(
                                  //     urlImages: RxList(galleryController.imageDataList[albumIndex].imageList), imageIndex: index, postIndex: albumIndex));
                                  // Get.to(() => GalleryWidget(
                                  //       urlImages: item,
                                  //       imageIndex: index,
                                  //       postIndex: 0,
                                  //     ));
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
                      ],
                    ),
                  ),
                ),
    );
  }
}

class ProfileViewPhotoShimmer extends StatelessWidget {
  const ProfileViewPhotoShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kH12sizedBox,
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 20,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
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
                              height: 90,
                              width: ((width - 63) / 3),
                            ),
                          ),
                        ),
                        // kH8sizedBox,
                        // ShimmerCommon(
                        //   widget: Container(
                        //     decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                        //     height: 12,
                        //     width: 80,
                        //   ),
                        // ),
                        // kH4sizedBox,
                        // ShimmerCommon(
                        //   widget: Container(
                        //     decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                        //     height: 12,
                        //     width: 20,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
