import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile_view/widgets/profile_view_all_photo_gridview.dart';
import 'package:bip_hip/views/profile_view/widgets/profile_view_gallery_photos.dart';
import 'package:bip_hip/widgets/common/button/custom_tapable_container.dart';

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