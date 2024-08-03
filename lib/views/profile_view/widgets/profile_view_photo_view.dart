import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/post/like_section_widget.dart';

class ProfileViewCommonPhotoView extends StatelessWidget {
  const ProfileViewCommonPhotoView({super.key, this.image});
  final String? image;

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
          body: Stack(
            children: [
              SizedBox(
                height: height - kAppBarSize,
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width,
                      height: height * 0.6,
                      child: Image.network(
                        image ?? "",
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
                      LikeSectionWidget(isGiftShown: true, postIndex: 0),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
