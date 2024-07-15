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
          itemCount: profileViewController.imageAlbumList.length,
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
                      title: profileViewController.imageAlbumList[index].title ?? ksNA.tr,
                      subTitle: profileViewController.imageAlbumList[index].totalImage.toString(),
                      image: profileViewController.imageAlbumList[index].preview!,
                      isThreeDotButtonShow: false,
                      onPressed: () async{
                        await 
                        Get.toNamed(krPhotos);
                        // Get.to(() => Photos(
                        //       imageList: profileViewController.imageAlbumList[index].imageList[0].f,
                        //       imageListTitle: profileViewController.imageAlbumList[index].title ?? ksNA,
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
