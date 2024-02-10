import 'package:bip_hip/controllers/menu/gallery_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class CreateAlbum extends StatelessWidget {
  CreateAlbum({super.key});
  final GalleryController galleryController = Get.find<GalleryController>();

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
              title: ksCreateAlbum.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
              action: [
                Padding(
                  padding: const EdgeInsets.only(right: k20Padding),
                  child: TextButton(
                    style: kTextButtonStyle,
                    onPressed: () {},
                    child: Text(
                      ksPost.tr,
                      style: semiBold16TextStyle(cPrimaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Column(
              children: [
                kH16sizedBox,
                CustomModifiedTextField(
                  controller: galleryController.createAlbumNameController,
                  hint: ksAlbumNamw.tr,
                  onChanged: (text) {},
                  onSubmit: (text) {},
                  inputAction: TextInputAction.done,
                  inputType: TextInputType.text,
                  maxLength: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
