import 'package:bip_hip/controllers/menu/gallery_controller.dart';
import 'package:bip_hip/helpers/menu/gallery/gallery_photo_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class CreateAlbumUpperSection extends StatelessWidget {
  CreateAlbumUpperSection({super.key});
  final GalleryController galleryController = Get.find<GalleryController>();
  final GalleryPhotoHelper galleryPhotoHelper = GalleryPhotoHelper();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                width: h45,
                child: Row(
                  children: [
                    Container(
                      height: h45,
                      width: h45,
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: cBlackColor),
                      child: ClipOval(
                        child: Image.network(
                          Get.find<GlobalController>().userImage.value.toString(),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => imageErrorBuilderCover(context, error, stackTrace, BipHip.user, kIconSize20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          kW8sizedBox,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => Padding(
                          padding: EdgeInsets.only(
                              top: (galleryController.taggedFriends.isEmpty || galleryController.addLocationValue.value == '') ? k12Padding : 2.0),
                          child: RichText(
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.clip,
                            maxLines: 3,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: Get.find<GlobalController>().userName.value.toString(),
                                  style: semiBold16TextStyle(cBlackColor),
                                ),
                                if (galleryController.taggedFriends.isNotEmpty)
                                  TextSpan(
                                    text: ' ${ksIsWithSmall.tr} ',
                                    style: regular16TextStyle(cBlackColor),
                                  ),
                                if (galleryController.taggedFriends.isNotEmpty)
                                  WidgetSpan(
                                      child: InkWell(
                                    onTap: () {
                                      galleryPhotoHelper.taggedFriendBottomSheet(context);
                                    },
                                    child: Text(
                                      '${galleryController.taggedFriends[0].fullName} ',
                                      style: semiBold16TextStyle(cBlackColor),
                                    ),
                                  )),
                                if (galleryController.taggedFriends.isNotEmpty && galleryController.taggedFriends.length == 2)
                                  WidgetSpan(
                                    child: InkWell(
                                      onTap: () {
                                        galleryPhotoHelper.taggedFriendBottomSheet(context);
                                      },
                                      child: Text(
                                        '& ${galleryController.taggedFriends[1].fullName}',
                                        style: semiBold16TextStyle(cBlackColor),
                                      ),
                                    ),
                                  ),
                                if (galleryController.taggedFriends.isNotEmpty && galleryController.taggedFriends.length > 2)
                                  WidgetSpan(
                                    child: InkWell(
                                      onTap: () {
                                        galleryPhotoHelper.taggedFriendBottomSheet(context);
                                      },
                                      child: Text(
                                        '& ${galleryController.taggedFriends.length - 1} others',
                                        style: semiBold16TextStyle(cBlackColor),
                                      ),
                                    ),
                                  ),
                                if (galleryController.addLocationValue.value != '')
                                  TextSpan(
                                    text: ' ${ksAt.tr} ',
                                    style: regular16TextStyle(cBlackColor),
                                  ),
                                if (galleryController.addLocationValue.value != '')
                                  WidgetSpan(
                                      child: InkWell(
                                    onTap: () {
                                      Get.toNamed(krCreateAlbumLocation);
                                    },
                                    child: Text(
                                      galleryController.addLocationValue.value,
                                      style: semiBold16TextStyle(cBlackColor),
                                    ),
                                  )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                kH4sizedBox,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
