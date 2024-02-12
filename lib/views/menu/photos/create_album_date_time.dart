import 'package:bip_hip/controllers/menu/gallery_controller.dart';
import 'package:bip_hip/helpers/menu/gallery/gallery_photo_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_selection_button.dart';

class CreateAlbumDateTime extends StatelessWidget {
  CreateAlbumDateTime({super.key});
  final GalleryController galleryController = Get.find<GalleryController>();
  final GalleryPhotoHelper galleryPhotoHelper = GalleryPhotoHelper();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: cWhiteColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              appBarColor: cWhiteColor,
              title: ksAddDateAndTime.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: Obx(() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kH16sizedBox,
                    Text(
                      ksWhenTakenImage.tr,
                      style: semiBold14TextStyle(cBlackColor),
                    ),
                    kH16sizedBox,
                    CustomSelectionButton(
                      buttonHeight: h60,
                      onPressed: () async {
                        unFocus(context);
                        galleryPhotoHelper.createAlbumDateButtonOnPressed(context);
                      },
                      text: galleryController.createAlbumDate.value != "" ? galleryController.createAlbumDate.value : "",
                      hintText: ksDate.tr,
                    ),
                    kH16sizedBox,
                    CustomSelectionButton(
                      buttonHeight: h60,
                      onPressed: () async {
                        unFocus(context);
                        if (galleryController.createAlbumDate.value == '') {
                          Get.find<GlobalController>().showSnackBar(title: ksWarning.tr, message: ksPickDateFirst.tr, color: cRedColor);
                        } else {
                          galleryPhotoHelper.createAlbumTimeButtonOnPressed(context);
                        }
                      },
                      text: galleryController.createAlbumTime.value != "" ? galleryController.createAlbumTime.value : "",
                      hintText: ksTime.tr,
                    ),
                    const Spacer(),
                    Obx(() => CustomElevatedButton(
                        buttonWidth: width - 40,
                        label: ksSave.tr,
                        onPressed: galleryController.isDateTimeSaveButtonEnable.value
                            ? () {
                                Get.back();
                              }
                            : null)),
                    kH20sizedBox,
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
