import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/home_post_details.dart';
import 'package:bip_hip/views/home/home_post_details_screen.dart';
import 'package:bip_hip/views/home/widgets/common_photo_view.dart';
import 'package:bip_hip/views/home/widgets/common_shared_post_widget.dart';

class CommonPostDetailsWidget extends StatelessWidget {
  CommonPostDetailsWidget({
    super.key,
    required this.postIndex,
  });

  final int postIndex;
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (globalController.commonPostList[postIndex].title != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: k8Padding, horizontal: kHorizontalPadding),
            child: Text(
              globalController.commonPostList[postIndex].title!,
              overflow: TextOverflow.clip,
              style: semiBold14TextStyle(cBlackColor),
            ),
          ),
        if (globalController.commonPostList[postIndex].content != null)
          Obx(() => Padding(
                padding: EdgeInsets.only(
                    left: kHorizontalPadding,
                    right: kHorizontalPadding,
                    bottom: (globalController.commonPostList[postIndex].images.isNotEmpty) ? k16Padding : 0),
                child: RichText(
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.clip,
                  maxLines: (globalController.commonPostList[postIndex].content!.length > 256) ? 5 : null,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: globalController.commonPostList[postIndex].content!,
                        style: (globalController.commonPostList[postIndex].content!.length < 150 && globalController.commonPostList[postIndex].images.isEmpty)
                            ? regular20TextStyle(cBlackColor)
                            : regular14TextStyle(cBlackColor),
                      ),
                    ],
                  ),
                ),
              )),
        if (globalController.commonPostList[postIndex].images.isNotEmpty)
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
                        onPressed: () async {
                          if ((globalController.commonPostList[postIndex].content != null &&
                                  globalController.commonPostList[postIndex].content?.trim() != '') ||
                              globalController.commonPostList[postIndex].images.length > 1) {
                            Get.to(() => HomePostDetailsScreen(
                                  postIndex: postIndex,
                                ));
                          } else {
                            Get.to(() => CommonPhotoView(
                                  image: Environment.imageBaseUrl + globalController.commonPostList[postIndex].images[0].path.toString(),
                                  postIndex: postIndex,
                                ));
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                          height: globalController.commonPostList[postIndex].images.length < 2 ? 302 : 150,
                          width: globalController.commonPostList[postIndex].images.length > 3 ? (width - 42) / 2 : (width - 40),
                          child: ClipRRect(
                            borderRadius: k8CircularBorderRadius,
                            child: Image.network(
                              Environment.imageBaseUrl + globalController.commonPostList[postIndex].images[0].path.toString(),
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
                      if (globalController.commonPostList[postIndex].images.length > 3)
                        const SizedBox(
                          width: 2,
                        ),
                      if (globalController.commonPostList[postIndex].images.length > 3)
                        TextButton(
                          style: kTextButtonStyle,
                          onPressed: () {
                            Get.to(() => HomePostDetailsScreen(
                                  postIndex: postIndex,
                                ));
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                            height: 150,
                            width: (width - 42) / 2,
                            child: ClipRRect(
                              borderRadius: k8CircularBorderRadius,
                              child: Image.network(
                                Environment.imageBaseUrl + globalController.commonPostList[postIndex].images[1].path.toString(),
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
                  if (globalController.commonPostList[postIndex].images.length > 1)
                    const SizedBox(
                      height: 2,
                    ),
                  Row(
                    children: [
                      if (globalController.commonPostList[postIndex].images.length < 4 && globalController.commonPostList[postIndex].images.length > 1)
                        TextButton(
                          style: kTextButtonStyle,
                          onPressed: () {
                            Get.to(() => HomePostDetailsScreen(
                                  postIndex: postIndex,
                                ));
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                            height: 150,
                            width: globalController.commonPostList[postIndex].images.length < 3 ? (width - 40) : (width - 42) / 2,
                            child: ClipRRect(
                              borderRadius: k8CircularBorderRadius,
                              child: Image.network(
                                Environment.imageBaseUrl + globalController.commonPostList[postIndex].images[1].path.toString(),
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
                      if (globalController.commonPostList[postIndex].images.length < 4 && globalController.commonPostList[postIndex].images.length > 2)
                        const SizedBox(
                          width: 2,
                        ),
                      if (globalController.commonPostList[postIndex].images.length > 2)
                        TextButton(
                          style: kTextButtonStyle,
                          onPressed: () {
                            Get.to(() => HomePostDetailsScreen(
                                  postIndex: postIndex,
                                ));
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                            height: 150,
                            width: globalController.commonPostList[postIndex].images.length > 4 ? (width - 44) / 3 : (width - 42) / 2,
                            child: ClipRRect(
                              borderRadius: k8CircularBorderRadius,
                              child: Image.network(
                                Environment.imageBaseUrl + globalController.commonPostList[postIndex].images[2].path.toString(),
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
                      if (globalController.commonPostList[postIndex].images.length > 3)
                        const SizedBox(
                          width: 2,
                        ),
                      if (globalController.commonPostList[postIndex].images.length > 3)
                        TextButton(
                          style: kTextButtonStyle,
                          onPressed: () {
                            Get.to(() => HomePostDetailsScreen(
                                  postIndex: postIndex,
                                ));
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                            height: 150,
                            width: globalController.commonPostList[postIndex].images.length < 5 ? (width - 42) / 2 : (width - 44) / 3,
                            child: ClipRRect(
                              borderRadius: k8CircularBorderRadius,
                              child: Image.network(
                                Environment.imageBaseUrl + globalController.commonPostList[postIndex].images[3].path.toString(),
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
                      if (globalController.commonPostList[postIndex].images.length > 4)
                        const SizedBox(
                          width: 2,
                        ),
                      if (globalController.commonPostList[postIndex].images.length >= 5)
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            TextButton(
                              style: kTextButtonStyle,
                              onPressed: () {
                                Get.to(() => HomePostDetailsScreen(
                                      postIndex: postIndex,
                                    ));
                              },
                              child: Container(
                                decoration: BoxDecoration(borderRadius: k8CircularBorderRadius, color: cWhiteColor),
                                height: 150,
                                width: (width - 44) / 3,
                                child: ClipRRect(
                                  borderRadius: k8CircularBorderRadius,
                                  child: Image.network(
                                    Environment.imageBaseUrl + globalController.commonPostList[postIndex].images[4].path.toString(),
                                    color: globalController.commonPostList[postIndex].images.length > 5 ? cBlackColor.withOpacity(0.3) : null,
                                    colorBlendMode: globalController.commonPostList[postIndex].images.length > 5 ? BlendMode.multiply : null,
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
                            if (globalController.commonPostList[postIndex].images.length > 5)
                              Positioned(
                                child: TextButton(
                                  style: kTextButtonStyle,
                                  onPressed: () {
                                    Get.to(() => HomePostDetailsScreen(
                                          postIndex: postIndex,
                                        ));
                                  },
                                  child: Text(
                                    "${globalController.commonPostList[postIndex].images.length - 5} More",
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
        if (globalController.commonPostList[postIndex].sharePosts != null)
          Padding(
            padding: const EdgeInsets.only(left: kHorizontalPadding, right: kHorizontalPadding, top: k8Padding),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: k8CircularBorderRadius,
                  border: Border.all(color: cLineColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: CommonSharedPostWidget(
                    postIndex: postIndex,
                  ),
                )),
          ),

        PostDetailsBottomSection(
          postIndex: postIndex,
          refType: 3,
          isCommentShown: true,
          isSelfPost: true,
          commentCount: globalController.commonPostList[postIndex].comments.isEmpty ? 0 : globalController.commonPostList[postIndex].countComment!.value,
          shareCount: 0,
          giftCount: 0,
        ),
      ],
    );
  }
}
