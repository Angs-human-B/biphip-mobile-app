import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:bip_hip/helpers/profile_view/profile_view_helper.dart';
import 'package:bip_hip/shimmers/menu/gallery/gallery_photo_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/photos/photos.dart';
import 'package:bip_hip/views/menu/photos/widgets/gallery_photo_container.dart';

class ProfileViewGalleryPhoto extends StatelessWidget {
  ProfileViewGalleryPhoto({super.key});
  final ProfileViewController profileViewController = Get.find<ProfileViewController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => profileViewController.isImageAlbumListLoading.value
          ? const GalleryPhotoShimmer()
          : Expanded(
              child: SingleChildScrollView(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: ProfileViewHelper().getUserKidOrStoreAlbumListLength(type: profileViewController.profileViewType.value),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: k4Padding + k2Padding,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    final item = ProfileViewHelper().getUserKidOrStoreAlbumList(type: profileViewController.profileViewType.value);
                    return Column(
                      children: [
                        Row(
                          children: [
                            GalleryPhotoContainer(
                              title: item[index].title ?? ksNA.tr,
                              subTitle: item[index].totalImage.toString(),
                              image: item[index].preview!,
                              isThreeDotButtonShow: false,
                              onPressed: () async {
                                Get.to(() => Photos(
                                      imageList: item[index].imageList,
                                      imageListTitle: item[index].title ?? ksNA,
                                      albumIndex: index,
                                    ));
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
    );
  }
}
