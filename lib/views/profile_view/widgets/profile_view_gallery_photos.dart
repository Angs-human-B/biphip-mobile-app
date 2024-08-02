import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:bip_hip/helpers/profile_view/profile_view_helper.dart';
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
          ? const AlbumPhotoShimmer()
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

class AlbumPhotoShimmer extends StatelessWidget {
  const AlbumPhotoShimmer({super.key});

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
                crossAxisCount: 2,
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
                              height: 100,
                              width: ((width - 52) / 2),
                            ),
                          ),
                        ),
                        kH8sizedBox,
                        ShimmerCommon(
                          widget: Container(
                            decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                            height: 12,
                            width: 80,
                          ),
                        ),
                        kH4sizedBox,
                        ShimmerCommon(
                          widget: Container(
                            decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius),
                            height: 12,
                            width: 20,
                          ),
                        ),
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
