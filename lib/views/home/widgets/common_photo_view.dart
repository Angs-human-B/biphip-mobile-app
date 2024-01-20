import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/post/like_section_widget.dart';

class CommonPhotoView extends StatelessWidget {
  CommonPhotoView({super.key, required this.image});
  final String image;
  final HomeController homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              systemUiOverlayStyle: SystemUiOverlayStyle.light,
              appBarColor: Colors.black,
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
                      height: height * 0.7,
                      child: Image.network(
                        image,
                        // fit: BoxFit.contain,
                        fit: BoxFit.contain,
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
                      const LikeSectionWidget(
                        sectionColor: cWhiteColor,
                        isGiftShown: false,
                      ),
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
