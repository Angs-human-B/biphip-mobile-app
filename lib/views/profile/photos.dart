import 'package:bip_hip/controllers/gallery_controller.dart';
import 'package:bip_hip/controllers/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile/profile_widgets/gallery_photos.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Photos extends StatelessWidget {
  Photos({super.key});

  final ProfileController _profileController = Get.find<ProfileController>();
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
              title: _galleryController.selectedTitle.value,
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
              child: _galleryController.selectedImageList.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Container(
                          alignment: Alignment.center,
                          child: const EmptyView(
                            title: ksNoImageAvailable,
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
                        childCount: _galleryController.selectedImageList.length,
                        (context, index) {
                          // var item = _galleryController.selectedImageList[index];
                          String imageUrl = _galleryController.selectedImageList[index].fullPath;
                          return InkWell(
                            // onTap: () {
                            //   _profileController.photoLink.value = item;
                            //   Get.toNamed(krPhotoDetails);
                            // },
                            onTap: null,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: cLineColor),
                                borderRadius: k8CircularBorderRadius,
                              ),
                              child: ClipRRect(
                                borderRadius: k8CircularBorderRadius,
                                child: Image.network(
                                  Environment.imageBaseUrl + imageUrl,
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
