import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/post/like_section_widget.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class CommonPhotoView extends StatelessWidget {
  const CommonPhotoView({super.key, required this.image, this.postIndex = 0, this.onPressed, this.description});
  final String image;
  final int postIndex;
  final String? description;
  final VoidCallback? onPressed;
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
              action: [
                Padding(
                  padding: const EdgeInsets.only(right: k8Padding),
                  child: CustomIconButton(
                    onPress: onPressed,
                    icon: BipHip.system,
                    iconColor: cWhiteColor,
                    size: kIconSize20,
                  ),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Stack(
              children: [
                SizedBox(
                  height: height - kAppBarSize - MediaQuery.of(context).padding.top,
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: SizedBox(
                          width: width,
                          height: height * 0.6,
                          child: Image.network(
                            image,
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
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          description ?? '',
                          style: semiBold14TextStyle(cWhiteColor),
                        ),
                        kH16sizedBox,
                        Container(
                          color: cWhiteColor,
                          height: 1,
                          width: width - 40,
                        ),
                        LikeSectionWidget(
                          postIndex: postIndex,
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
      ),
    );
  }
}

class GalleryWidget extends StatelessWidget {
  GalleryWidget({super.key, required this.urlImages, required this.index, this.imageDescriptions}) : pageController = PageController(initialPage: index);
  final List<String> urlImages;
  final int index;
  final String? imageDescriptions;
  final PageController pageController;
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
              PhotoViewGallery.builder(
                pageController: pageController,
                itemCount: urlImages.length,
                builder: (context, index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(urlImages[index]),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.contained * 5,
                  );
                },
              ),
              Positioned(
                bottom: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                  child: Column(children: [
                    Container(
                      color: cWhiteColor,
                      height: 1,
                      width: width - 40,
                    ),
                    const LikeSectionWidget(
                      sectionColor: cWhiteColor,
                      isGiftShown: false,
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
