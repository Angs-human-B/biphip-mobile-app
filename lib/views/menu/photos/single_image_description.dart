import 'package:bip_hip/controllers/menu/gallery_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class SingleImageDescription extends StatelessWidget {
  SingleImageDescription({super.key, this.image});
  final GalleryController galleryController = Get.find<GalleryController>();
  final String? image;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        unFocus(context);
        Get.back();
        return true;
      },
      child: Container(
        color: cWhiteColor,
        child: SafeArea(
          top: false,
          child: Scaffold(
            backgroundColor: cWhiteColor,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kAppBarSize),
              child: CustomAppBar(
                appBarColor: cWhiteColor,
                title: ksImage.tr,
                hasBackButton: true,
                isCenterTitle: true,
                onBack: () {
                  unFocus(context);
                  Get.back();
                },
                action: [
                  Obx(() => Padding(
                        padding: const EdgeInsets.only(right: h16),
                        child: TextButton(
                          style: kTextButtonStyle,
                          onPressed: galleryController.isImageDescriptionSaveButtonEnable.value
                              ? () async {
                                  await galleryController.imageDescriptionUpdate();
                                }
                              : null,
                          child: Text(
                            ksSave.tr,
                            style: medium14TextStyle(galleryController.isImageDescriptionSaveButtonEnable.value ? cPrimaryColor : cPlaceHolderColor),
                          ),
                        ),
                      ))
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: k4Padding,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(k8BorderRadius),
                      child: Container(
                        color: cWhiteColor,
                        height: 150,
                        width: width - 40,
                        child: Image.network(
                          image!,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                          errorBuilder: (context, error, stackTrace) => const Icon(
                            BipHip.imageFile,
                            size: kIconSize100,
                            color: cIconColor,
                          ),
                          loadingBuilder: imageLoadingBuilder,
                        ),
                      ),
                    ),
                  ),
                  kH12sizedBox,
                  CustomModifiedTextField(
                    controller: galleryController.imageDescriptionUpdateController,
                    maxLength: 1000,
                    maxLines: 100,
                    minLines: 1,
                    isFilled: false,
                    fillColor: cWhiteColor,
                    inputAction: TextInputAction.newline,
                    inputType: TextInputType.multiline,
                    hint: ksAddACaption.tr,
                    contentPadding: const EdgeInsets.symmetric(vertical: k12Padding),
                    textHintStyle: regular14TextStyle(cPlaceHolderColor),
                    textInputStyle: regular14TextStyle(cBlackColor),
                    onChanged: (v) {
                      if (galleryController.imageDescriptionUpdateController.text.toString().trim() == '') {
                        galleryController.isImageDescriptionSaveButtonEnable.value = false;
                      } else {
                        galleryController.isImageDescriptionSaveButtonEnable.value = true;
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
