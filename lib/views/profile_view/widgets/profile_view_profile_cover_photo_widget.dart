import 'package:bip_hip/utils/constants/imports.dart';

class ProfileViewProfileCoverPhotoWidget extends StatelessWidget {
  const ProfileViewProfileCoverPhotoWidget({super.key});

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
            Container(
              height: 150,
              width: width,
              decoration: const BoxDecoration(color: cBlackColor, border: Border(bottom: BorderSide(color: cLineColor))),
              child: Image.network(
                "https://img.freepik.com/free-photo/expressive-woman-posing-outdoor_344912-3083.jpg?w=1060&t=st=1719985023~exp=1719985623~hmac=97f953c3b700b57b9b8dd31deac0d8852cf8e417069a2ba4a21fe3909f78f388",
                // profileController.userData.value!.coverPhoto.toString(),
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                errorBuilder: (context, error, stackTrace) => imageErrorBuilderCover(context, error, stackTrace, BipHip.imageFile, kIconSize120),
                loadingBuilder: imageLoadingBuilder,
                frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                  return child;
                },
              ),
            ),
            Positioned(
              bottom: 0,
              left: 20,
              child: Stack(
                children: [
                  Container(
                    height: isDeviceScreenLarge() ? kProfileImageSize : (kProfileImageSize - h10),
                    width: isDeviceScreenLarge() ? kProfileImageSize : (kProfileImageSize - h10),
                    decoration: BoxDecoration(
                      color: cBlackColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: cWhiteColor.withAlpha(500), width: 2),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        "https://img.freepik.com/free-photo/expressive-woman-posing-outdoor_344912-3083.jpg?w=1060&t=st=1719985023~exp=1719985623~hmac=97f953c3b700b57b9b8dd31deac0d8852cf8e417069a2ba4a21fe3909f78f388",
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
                  // Positioned(
                  //   right: 6,
                  //   bottom: 10,
                  //   child: TextButton(
                  //     style: kTextButtonStyle,
                  //     onPressed: () {
                  //       profileHelper.profilePicUploadBottomSheet(context);
                  //     },
                  //     child: Container(
                  //       height: h28,
                  //       width: h28,
                  //       decoration: BoxDecoration(
                  //         color: cGreyBoxColor,
                  //         borderRadius: BorderRadius.circular(26),
                  //         border: Border.all(
                  //           color: cLineColor,
                  //         ),
                  //       ),
                  //       child: const Icon(
                  //         BipHip.camera,
                  //         color: cBlackColor,
                  //         size: kIconSize14,
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  // if (profileController.userData.value!.userPendent != null)
                  // Positioned(
                  //   right: 6,
                  //   top: 10,
                  //   child: Container(
                  //       height: h28,
                  //       width: h28,
                  //       decoration: BoxDecoration(
                  //         color: cTransparentColor,
                  //         borderRadius: BorderRadius.circular(26),
                  //       ),
                  //       child: Image.network(
                  //         // profileController.userData.value!.userPendent!.pendent!.icon.toString(),
                  //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR15-88ChPxiVt2Ir13quaHTLlJk1sW_X4YIBuL_zXPXNsM1S0rfYU5aQXhZA&s",
                  //         fit: BoxFit.cover,
                  //         filterQuality: FilterQuality.high,
                  //         errorBuilder: (context, error, stackTrace) => imageErrorBuilderCover(
                  //           context,
                  //           error,
                  //           stackTrace,
                  //           BipHip.badgesOutline,
                  //           kIconSize18,
                  //         ),
                  //         loadingBuilder: imageLoadingBuilder,
                  //       )),
                  // ),
                ],
              ),
            ),
            // Positioned(
            //   right: 16,
            //   bottom: 60,
            //   child: TextButton(
            //     style: kTextButtonStyle,
            //     onPressed: () {
            //       profileHelper.coverPhotoUploadBottomSheet(context);
            //     },
            //     child: Container(
            //       height: h28,
            //       width: h28,
            //       decoration: BoxDecoration(
            //         color: cGreyBoxColor,
            //         borderRadius: BorderRadius.circular(26),
            //         border: Border.all(
            //           color: cLineColor,
            //         ),
            //       ),
            //       child: const Icon(
            //         BipHip.camera,
            //         color: cBlackColor,
            //         size: kIconSize14,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}
