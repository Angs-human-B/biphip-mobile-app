import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:bip_hip/helpers/profile_view/profile_view_helper.dart';
import 'package:bip_hip/shimmers/menu/gallery/gallery_photo_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProfileViewAllPhotoGridView extends StatelessWidget {
  ProfileViewAllPhotoGridView({super.key});
  final ProfileViewController profileViewController = Get.find<ProfileViewController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => profileViewController.isAllImageListLoading.value
          ? const GalleryPhotoShimmer()
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
