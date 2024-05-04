import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/post/like_section_widget.dart';

class KidPhotoView extends StatelessWidget {
  KidPhotoView({
    super.key,
  });
  final KidsController kidsController = Get.find<KidsController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cBlackColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: cBlackColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              appBarColor: cBlackColor,
              hasBackButton: true,
              iconColor: cWhiteColor,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: Obx(() => Stack(
                      children: [
                        SizedBox(
                          height: height - kAppBarSize,
                          width: width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: width,
                                height: kidsController.isKidProfilePhoto.value ? height * 0.6 : height * 0.4,
                                child: Image.network(
                                  kidsController.kidPreviewPhoto.value,
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
                  ],
                ),
              ),
              Positioned(
                bottom: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                  child: Column(
                    children: [
                      Container(
                        color: cWhiteColor,
                        height: 1,
                        width: width - 40,
                      ),
                      //  LikeSectionWidget(
                      //   sectionColor: cWhiteColor,
                      //   isGiftShown: false,
                      // ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      ),
    );
  }
}
