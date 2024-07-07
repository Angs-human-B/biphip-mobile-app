import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/photos/widgets/gallery_photo_container.dart';

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

