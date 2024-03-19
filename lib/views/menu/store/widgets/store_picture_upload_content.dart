import 'dart:io';
import 'package:bip_hip/controllers/menu/store_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class StorePictureUploadContent extends StatelessWidget {
  StorePictureUploadContent({super.key, required this.isImageChanged, required this.imageFile, required this.imagePath, this.viewPhoto});

  final GlobalController globalController = Get.find<GlobalController>();
  final RxBool isImageChanged;
  final Rx<File> imageFile;
  final RxString imagePath;
  final String? viewPhoto;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (Get.find<StoreController>().storeViewOptionEnabled.value && viewPhoto != null)
          Padding(
            padding: const EdgeInsets.only(bottom: k16Padding),
            child: CustomElevatedButton(
              label: viewPhoto!,
              prefixIcon: BipHip.view,
              prefixIconColor: cIconColor,
              suffixIconColor: cIconColor,
              onPressed: () {
                Get.back();
                Get.toNamed(krViewPhoto);
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
              Get.toNamed(krStorePhotoPreview);
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
              Get.toNamed(krStorePhotoPreview);
            }
          },
          buttonHeight: h32,
          buttonWidth: width - 40,
          buttonColor: cWhiteColor,
          borderColor: cLineColor,
          textStyle: semiBold14TextStyle(cBlackColor),
        ),
      ],
    );
  }
}
