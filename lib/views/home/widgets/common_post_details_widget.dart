import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/widgets/common_post_widget.dart';

class CommonPostDetailsWidget extends StatelessWidget {
  CommonPostDetailsWidget({
    super.key,
    required this.isTextualPost,
    this.category,
    this.title,
    this.postText,
    required this.mediaList,
    required this.isCommentShown,
    required this.showBottomSection,
  });
  final bool isTextualPost, isCommentShown, showBottomSection;
  final String? category, title, postText;
  final List mediaList;
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isTextualPost)
          Obx(() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: RichText(
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.clip,
                  maxLines: (homeController.seeMore.value && postText!.length > 256) ? 5 : null,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: postText!,
                        style: regular14TextStyle(cBlackColor),
                      ),
                    ],
                  ),
                ),
              )),
        if (postText!.length > 256)
          Obx(() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: TextButton(
                  style: kTextButtonStyle,
                  onPressed: () {
                    homeController.seeMore.value = !homeController.seeMore.value;
                  },
                  child: Text(
                    homeController.seeMore.value ? ksSeeMore.tr : ksShowLess.tr,
                    style: semiBold14TextStyle(cPrimaryColor),
                  ),
                ),
              )),
        kH16sizedBox,
        if (mediaList.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: kHorizontalPadding, right: kHorizontalPadding, bottom: k12Padding),
            child: Container(
              color: cWhiteColor,
              height: 302,
              width: width - 40,
              child: Column(
                children: [
                  Row(
                    children: [
                      TextButton(
                        style: kTextButtonStyle,
                        onPressed: () {
                          Get.toNamed(krHomePostDetailsScreen);
                        },
                        child: Container(
                          decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                          height: mediaList.length < 2 ? 302 : 150,
                          width: mediaList.length > 3 ? (width - 42) / 2 : (width - 40),
                          child: ClipRRect(
                            borderRadius: k8CircularBorderRadius,
                            child: Image.network(
                              Environment.imageBaseUrl + mediaList[0].path.toString(),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const Icon(
                                BipHip.imageFile,
                                size: kIconSize120,
                                color: cIconColor,
                              ),
                              loadingBuilder: imageLoadingBuilder,
                              frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                                return child;
                              },
                            ),
                          ),
                        ),
                      ),
                      if (mediaList.length > 3)
                        const SizedBox(
                          width: 2,
                        ),
                      if (mediaList.length > 3)
                        TextButton(
                          style: kTextButtonStyle,
                          onPressed: () {
                            Get.toNamed(krHomePostDetailsScreen);
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                            height: 150,
                            width: (width - 42) / 2,
                            child: ClipRRect(
                              borderRadius: k8CircularBorderRadius,
                              child: Image.network(
                                Environment.imageBaseUrl + mediaList[1].path.toString(),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => const Icon(
                                  BipHip.imageFile,
                                  size: kIconSize120,
                                  color: cIconColor,
                                ),
                                loadingBuilder: imageLoadingBuilder,
                                frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                                  return child;
                                },
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (mediaList.length > 1)
                    const SizedBox(
                      height: 2,
                    ),
                  Row(
                    children: [
                      if (mediaList.length < 4 && mediaList.length > 1)
                        TextButton(
                          style: kTextButtonStyle,
                          onPressed: () {
                            Get.toNamed(krHomePostDetailsScreen);
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                            height: 150,
                            width: mediaList.length < 3 ? (width - 40) : (width - 42) / 2,
                            child: ClipRRect(
                              borderRadius: k8CircularBorderRadius,
                              child: Image.network(
                                Environment.imageBaseUrl + mediaList[1].path.toString(),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => const Icon(
                                  BipHip.imageFile,
                                  size: kIconSize120,
                                  color: cIconColor,
                                ),
                                loadingBuilder: imageLoadingBuilder,
                                frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                                  return child;
                                },
                              ),
                            ),
                          ),
                        ),
                      if (mediaList.length < 4 && mediaList.length > 2)
                        const SizedBox(
                          width: 2,
                        ),
                      if (mediaList.length > 2)
                        TextButton(
                          style: kTextButtonStyle,
                          onPressed: () {
                            Get.toNamed(krHomePostDetailsScreen);
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                            height: 150,
                            width: mediaList.length > 4 ? (width - 44) / 3 : (width - 42) / 2,
                            child: ClipRRect(
                              borderRadius: k8CircularBorderRadius,
                              child: Image.network(
                                Environment.imageBaseUrl + mediaList[2].path.toString(),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => const Icon(
                                  BipHip.imageFile,
                                  size: kIconSize120,
                                  color: cIconColor,
                                ),
                                loadingBuilder: imageLoadingBuilder,
                                frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                                  return child;
                                },
                              ),
                            ),
                          ),
                        ),
                      if (mediaList.length > 3)
                        const SizedBox(
                          width: 2,
                        ),
                      if (mediaList.length > 3)
                        TextButton(
                          style: kTextButtonStyle,
                          onPressed: () {
                            Get.toNamed(krHomePostDetailsScreen);
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                            height: 150,
                            width: mediaList.length < 5 ? (width - 42) / 2 : (width - 44) / 3,
                            child: ClipRRect(
                              borderRadius: k8CircularBorderRadius,
                              child: Image.network(
                                Environment.imageBaseUrl + mediaList[3].path.toString(),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => const Icon(
                                  BipHip.imageFile,
                                  size: kIconSize120,
                                  color: cIconColor,
                                ),
                                loadingBuilder: imageLoadingBuilder,
                                frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                                  return child;
                                },
                              ),
                            ),
                          ),
                        ),
                      if (mediaList.length > 4)
                        const SizedBox(
                          width: 2,
                        ),
                      if (mediaList.length >= 5)
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            TextButton(
                              style: kTextButtonStyle,
                              onPressed: () {
                                Get.toNamed(krHomePostDetailsScreen);
                              },
                              child: Container(
                                decoration: BoxDecoration(borderRadius: k8CircularBorderRadius, color: cWhiteColor),
                                height: 150,
                                width: (width - 44) / 3,
                                child: ClipRRect(
                                  borderRadius: k8CircularBorderRadius,
                                  child: Image.network(
                                    Environment.imageBaseUrl + mediaList[4].path.toString(),
                                    color: mediaList.length > 5 ? cBlackColor.withOpacity(0.3) : null,
                                    colorBlendMode: mediaList.length > 5 ? BlendMode.multiply : null,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => const Icon(
                                      BipHip.imageFile,
                                      size: kIconSize120,
                                      color: cIconColor,
                                    ),
                                    loadingBuilder: imageLoadingBuilder,
                                    frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                                      return child;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            if (mediaList.length > 5)
                              Positioned(
                                child: TextButton(
                                  style: kTextButtonStyle,
                                  onPressed: () {
                                    // Get.toNamed(krUploadedImageListPage);
                                    Get.toNamed(krHomePostDetailsScreen);
                                  },
                                  child: Text(
                                    "${mediaList.length - 5} More",
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
          ),
        if (showBottomSection)
          PostBottomSection(
            isCommentShown: isCommentShown,
            isSelfPost: true,
            commentCount: 0,
            shareCount: 0,
            giftCount: 0,
          ),
      ],
    );
  }
}
