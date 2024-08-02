import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:bip_hip/helpers/profile_view/profile_view_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile_view/widgets/profile_view_photo_view.dart';

class ProfileViewProfileCoverPhotoWidget extends StatelessWidget {
  ProfileViewProfileCoverPhotoWidget({super.key});
  final ProfileViewController profileViewController = Get.find<ProfileViewController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: 225,
              color: cWhiteColor,
            ),
            InkWell(
              onTap: () {
                Get.to(() => ProfileViewCommonPhotoView(
                      image: ProfileViewHelper().getUserKidStoreCoverPhoto(type: profileViewController.profileViewType.value),
                    ));
              },
              child: Container(
                height: 150,
                width: width,
                decoration: const BoxDecoration(color: cBlackColor, border: Border(bottom: BorderSide(color: cLineColor))),
                child: Image.network(
                  ProfileViewHelper().getUserKidStoreCoverPhoto(type: profileViewController.profileViewType.value),
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  errorBuilder: (context, error, stackTrace) => imageErrorBuilderCover(context, error, stackTrace, BipHip.imageFile, kIconSize120),
                  loadingBuilder: imageLoadingBuilder,
                  frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                    return child;
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 20,
              child: Stack(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => ProfileViewCommonPhotoView(
                            image: ProfileViewHelper().getUserKidStoreProfilePicture(type: profileViewController.profileViewType.value),
                          ));
                    },
                    child: Container(
                      height: isDeviceScreenLarge() ? kProfileImageSize : (kProfileImageSize - h10),
                      width: isDeviceScreenLarge() ? kProfileImageSize : (kProfileImageSize - h10),
                      decoration: BoxDecoration(
                        color: cBlackColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: cWhiteColor.withAlpha(500), width: 2),
                      ),
                      child: ClipOval(
                        child: Image.network(
                          ProfileViewHelper().getUserKidStoreProfilePicture(type: profileViewController.profileViewType.value),
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                          errorBuilder: (context, error, stackTrace) => imageErrorBuilderCover(
                            context,
                            error,
                            stackTrace,
                            BipHip.user,
                            kIconSize70,
                          ),
                          loadingBuilder: imageLoadingBuilder,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
