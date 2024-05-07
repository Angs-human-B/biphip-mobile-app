import 'package:bip_hip/controllers/menu/gallery_controller.dart';
import 'package:bip_hip/helpers/menu/gallery/gallery_photo_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class CreateAlbumtMediaSection extends StatelessWidget {
  CreateAlbumtMediaSection({super.key});
  final GalleryController galleryController = Get.find<GalleryController>();
  final GalleryPhotoHelper galleryPhotoHelper = GalleryPhotoHelper();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        color: cWhiteColor,
        height: 302,
        width: width - 40,
        child: Column(
          children: [
            Stack(
              children: [
                TextButton(
                  style: kTextButtonStyle,
                  onPressed: () {
                    if (galleryController.allMediaList.length > 1) {
                      Get.toNamed(krCreateAlbumUploadImageList);
                    }
                  },
                  child: Container(
                    color: cWhiteColor,
                    height: galleryController.allMediaList.length < 2 ? 302 : 150,
                    width: width - 40,
                    child: galleryController.allMediaList[0] is String
                        ? Image.network(
                            galleryController.allMediaList[0],
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            galleryController.allMediaList[0].value,
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: TextButton(
                    style: kTextButtonStyle,
                    onPressed: () {
                      galleryPhotoHelper.removeMedia(0);
                      galleryController.imageDescriptionTextEditingController[0].clear();
                      galleryController.imageLocationsList.removeAt(0);
                      galleryController.imageTimesList.removeAt(0);
                      galleryController.imageTagIdList.removeAt(0);
                    },
                    child: const Icon(
                      BipHip.circleCrossNew,
                      color: cWhiteColor,
                    ),
                  ),
                ),
              ],
            ),
            if (galleryController.allMediaList.length > 1)
              const SizedBox(
                height: 2,
              ),
            Row(
              children: [
                if (galleryController.allMediaList.length > 1)
                  Stack(
                    children: [
                      TextButton(
                        style: kTextButtonStyle,
                        onPressed: () {
                          Get.toNamed(krCreateAlbumUploadImageList);
                        },
                        child: Container(
                          color: cWhiteColor,
                          height: 150,
                          width: galleryController.allMediaList.length < 3 ? (width - 40) : (width - 42) / 2,
                          child: galleryController.allMediaList[1] is String
                              ? Image.network(
                                  galleryController.allMediaList[1],
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  galleryController.allMediaList[1].value,
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 5,
                        child: TextButton(
                          style: kTextButtonStyle,
                          onPressed: () {
                            galleryPhotoHelper.removeMedia(1);
                            galleryController.imageDescriptionTextEditingController[1].clear();
                            galleryController.imageLocationsList.removeAt(1);
                            galleryController.imageTimesList.removeAt(1);
                            galleryController.imageTagIdList.removeAt(1);
                          },
                          child: const Icon(
                            BipHip.circleCrossNew,
                            color: cWhiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                if (galleryController.allMediaList.length > 2)
                  const SizedBox(
                    width: 2,
                  ),
                if (galleryController.allMediaList.length > 2)
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      TextButton(
                        style: kTextButtonStyle,
                        onPressed: () {
                          Get.toNamed(krCreateAlbumUploadImageList);
                        },
                        child: Container(
                          color: cWhiteColor,
                          height: 150,
                          width: (width - 42) / 2,
                          child: galleryController.allMediaList[2] is String
                              ? Image.network(
                                  galleryController.allMediaList[2],
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  galleryController.allMediaList[2].value,
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.cover,
                                  color: cBlackColor.withOpacity(0.3),
                                  colorBlendMode: BlendMode.multiply,
                                ),
                        ),
                      ),
                      if (galleryController.allMediaList.length == 3)
                        Positioned(
                          top: 5,
                          right: 5,
                          child: TextButton(
                            style: kTextButtonStyle,
                            onPressed: () {
                              galleryPhotoHelper.removeMedia(2);
                            },
                            child: const Icon(
                              BipHip.circleCrossNew,
                              color: cWhiteColor,
                            ),
                          ),
                        ),
                      if (galleryController.allMediaList.length > 3)
                        Positioned(
                          child: TextButton(
                            style: kTextButtonStyle,
                            onPressed: () {
                              Get.toNamed(krCreateAlbumUploadImageList);
                            },
                            child: Text(
                              "${galleryController.allMediaList.length - 2} ${ksMore.tr}",
                              style: semiBold16TextStyle(cWhiteColor),
                            ),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
