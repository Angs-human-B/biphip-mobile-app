import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/photos/widgets/gallery_photo_container.dart';
import 'package:bip_hip/widgets/common/button/custom_tapable_container.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProfileViewPhotoTab extends StatelessWidget {
  ProfileViewPhotoTab({super.key});
  final ProfileViewController profileViewController = Get.find<ProfileViewController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: (height * 0.42) - (kAppBarSize + MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Column(
            children: [
              TapAbleButtonContainer(
                buttonText: profileViewController.photoTapAbleButtonText,
                buttonState: profileViewController.photoTapAbleButtonState,
                buttonPress: RxList([
                  () {
                    // galleryPhotoHelper.yourPhotosTapableButton();
                    profileViewController.photoToggleType(0);
                  },
                  () {
                    // galleryPhotoHelper.albumsTapableButton();
                    profileViewController.photoToggleType(1);
                  },
                ]),
              ),
              kH16sizedBox,
              if (profileViewController.photoTapAbleButtonState[0] == true) ProfileViewAllPhotoGridView(),
              if (profileViewController.photoTapAbleButtonState[1] == true) ProfileViewGalleryPhoto(),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileViewGalleryPhoto extends StatelessWidget {
  ProfileViewGalleryPhoto({super.key});
  final ProfileViewController profileViewController = Get.find<ProfileViewController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: profileViewController.photoAlbumList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: k4Padding + k2Padding,
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Row(
                  children: [
                    GalleryPhotoContainer(
                      title: profileViewController.photoAlbumList[index]["title"] ?? ksNA.tr,
                      subTitle: profileViewController.photoAlbumList[index]["subTitle"].toString(),
                      image: profileViewController.photoAlbumList[index]["image"],
                      // threeDotOnPressed: () {
                      //   // galleryController.galleryPhotoActionSelect.value = '';
                      //   // galleryController.galleryPhotoBottomSheetRightButtonState.value = false;
                      //   Get.find<GlobalController>().commonBottomSheet(
                      //     context: context,
                      //     isBottomSheetRightButtonActive: galleryController.galleryPhotoBottomSheetRightButtonState,
                      //     isScrollControlled: true,
                      //     content: GalleryPhotoActionContent(
                      //       defaultValue: galleryController.imageDataList[index].isDefault,
                      //       selectedIndex: index,
                      //     ),
                      //     onPressCloseButton: () {
                      //       Get.back();
                      //     },
                      //     onPressRightButton: () {},
                      //     rightText: ksDone.tr,
                      //     rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                      //     title: ksAction.tr,
                      //     isRightButtonShow: false,
                      //     bottomSheetHeight: galleryController.imageDataList[index].isDefault == 0 ? 180 : 120,
                      //   );
                      // },

                      onPressed: () {
                        //!Route needed(after api call route the photos page)
                        // Get.to(() => Photos(
                        //       imageList: galleryController.imageDataList[index].imageList,
                        //       imageListTitle: galleryController.imageDataList[index].title ?? ksNA,
                        //       albumIndex: index,
                        //     ));
                        // Get.to(() => Photos(
                        //       imageList: profileViewController.photoAlbumList[index]["image"],
                        //       imageListTitle: profileViewController.photoAlbumList[index]["title"],
                        //       albumIndex: index,
                        //     ));
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ProfileViewAllPhotoGridView extends StatelessWidget {
  ProfileViewAllPhotoGridView({super.key});
  final ProfileViewController profileViewController = Get.find<ProfileViewController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                childCount: profileViewController.allPhotoList.length,
                (context, index) {
                  String imageUrl = profileViewController.allPhotoList[index];
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
    );
  }
}
