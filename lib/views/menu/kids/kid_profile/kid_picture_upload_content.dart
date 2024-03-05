import 'dart:io';
import 'package:bip_hip/utils/constants/imports.dart';

class KidPictureUploadContent extends StatelessWidget {
  KidPictureUploadContent(
      {super.key, required this.isImageChanged, required this.imageFile, required this.imagePath, this.viewPhoto, this.isViewOptionEnabled});

  final GlobalController globalController = Get.find<GlobalController>();
  final RxBool isImageChanged;
  final Rx<File> imageFile;
  final RxString imagePath;
  final String? viewPhoto;
  final RxBool? isViewOptionEnabled;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isViewOptionEnabled!.value && viewPhoto != null)
              Padding(
                padding: const EdgeInsets.only(bottom: k16Padding),
                child: CustomElevatedButton(
                  label: viewPhoto!,
                  prefixIcon: BipHip.view,
                  prefixIconColor: cIconColor,
                  suffixIconColor: cIconColor,
                  onPressed: () {
                    Get.back();
                    // Get.toNamed(krViewPhoto);//!Change the route properly
                  },
                  buttonHeight: h32,
                  buttonWidth: width - 40,
              buttonColor: cWhiteColor,
              borderColor: cLineColor,
              textStyle: semiBold14TextStyle(cBlackColor),
            ),
          ),
        CustomElevatedButton(
          label: ksAddPhoto.tr,
          prefixIcon: BipHip.camera,
          prefixIconColor: cIconColor,
          suffixIconColor: cIconColor,
          onPressed: () async {
            var status = await globalController.selectImageSource(isImageChanged, imagePath, imageFile, 'camera');
            if (status) {
              // Get.toNamed(krPhotoPreview);//!Change route
            }
          },
          buttonHeight: h32,
          buttonWidth: width - 40,
          buttonColor: cWhiteColor,
          borderColor: cLineColor,
          textStyle: semiBold14TextStyle(cBlackColor),
        ),
        kH16sizedBox,
        CustomElevatedButton(
          label: ksChooseFromGallery.tr,
          prefixIcon: BipHip.photo,
          prefixIconColor: cIconColor,
          suffixIconColor: cIconColor,
          onPressed: () async {
            var status = await globalController.selectImageSource(isImageChanged, imagePath, imageFile, 'gallery');
            if (status) {
              // Get.toNamed(krPhotoPreview);//!chnage route
            }
          },
          buttonHeight: h32,
          buttonWidth: width - 40,
          buttonColor: cWhiteColor,
          borderColor: cLineColor,
          textStyle: semiBold14TextStyle(cBlackColor),
        ),
      ],
    ),
    );
  }
}
