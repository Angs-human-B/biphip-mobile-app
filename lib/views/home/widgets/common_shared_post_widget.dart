import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/home_post_details_screen.dart';
import 'package:bip_hip/views/home/widgets/common_photo_view.dart';
import 'package:bip_hip/views/home/widgets/post_upper_container.dart';
import 'package:timer_count_down/timer_count_down.dart';

class CommonSharedPostWidget extends StatelessWidget {
  CommonSharedPostWidget({
    super.key,
    required this.postIndex,
    this.postUpperContainerOnPressed,
  });
  final int postIndex;
  final VoidCallback? postUpperContainerOnPressed;
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kH10sizedBox,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: SharePostUpperContainer(
            postIndex: postIndex,
            postUpperContainerOnPressed: postUpperContainerOnPressed,
          ),
        ),
        kH8sizedBox,
        if ((globalController.commonPostList[postIndex].sharePosts?.postCategory?.name == 'News' ||
                globalController.commonPostList[postIndex].sharePosts?.postCategory?.name == 'Selling') &&
            globalController.commonPostList[postIndex].sharePosts?.title != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: k8Padding, horizontal: kHorizontalPadding),
            child: Text(
              globalController.commonPostList[postIndex].sharePosts?.title!,
              overflow: TextOverflow.clip,
              style: semiBold14TextStyle(cBlackColor),
            ),
          ),
        if (globalController.getProductCondition(globalController.commonPostList[postIndex].sharePosts?.sellPostConditionId) != null &&
            globalController.getProductCategory(globalController.commonPostList[postIndex].sharePosts?.sellPostCategoryId) != null &&
            globalController.commonPostList[postIndex].sharePosts?.postCategory?.name == 'Selling')
          Padding(
            padding: const EdgeInsets.only(bottom: k8Padding, left: kHorizontalPadding, right: kHorizontalPadding),
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text:
                      '${globalController.getProductCategory(globalController.commonPostList[postIndex].sharePosts?.sellPostCategoryId)} ${ksCondition.tr.toLowerCase()}: ',
                  style: semiBold14TextStyle(cSmallBodyTextColor),
                ),
                TextSpan(
                  text: '${globalController.getProductCondition(globalController.commonPostList[postIndex].sharePosts?.sellPostConditionId)}',
                  style: semiBold14TextStyle(cBlackColor),
                ),
              ]),
            ),
          ),
        //! check if it is selling post
        if (globalController.commonPostList[postIndex].sharePosts?.postCategory?.name == 'Selling')
          Padding(
            padding: const EdgeInsets.only(bottom: k8Padding, left: kHorizontalPadding, right: kHorizontalPadding),
            child: RichText(
              text: TextSpan(
                children: [
                  const WidgetSpan(
                    child: Padding(
                      padding: EdgeInsets.only(right: k4Padding),
                      child: Icon(
                        BipHip.info,
                        color: cIconColor,
                        size: kIconSize16,
                      ),
                    ),
                  ),
                  TextSpan(
                    text: '${ksDuration.tr}: ',
                    style: semiBold14TextStyle(cSmallBodyTextColor),
                  ),
                  WidgetSpan(
                    child: Countdown(
                      seconds: Get.find<HomeController>().getBiddingDuration(DateTime.parse('2024-01-04 20:18:04Z')),
                      build: (BuildContext context, double time) {
                        int hours = (time ~/ 3600).toInt();
                        int minutes = ((time % 3600) ~/ 60).toInt();
                        int seconds = (time % 60).toInt();
                        return Text(
                          '${hours}h: ${minutes}m: $seconds sec',
                          style: semiBold14TextStyle(cRedColor),
                        );
                      },
                      interval: const Duration(milliseconds: 100),
                      onFinished: () {},
                    ),
                  )
                ],
              ),
            ),
          ),
        if (globalController.commonPostList[postIndex].sharePosts?.postCategory?.name == 'Selling')
          Padding(
            padding: const EdgeInsets.only(bottom: k8Padding, left: kHorizontalPadding, right: kHorizontalPadding),
            child: RichText(
              text: TextSpan(
                children: [
                  if (globalController.commonPostList[postIndex].sharePosts?.discount != null)
                    WidgetSpan(
                      baseline: TextBaseline.alphabetic,
                      alignment: PlaceholderAlignment.baseline,
                      child: Padding(
                        padding: const EdgeInsets.only(right: k4Padding),
                        child: Text(
                          '-${globalController.commonPostList[postIndex].sharePosts?.discount}% ',
                          style: regular14TextStyle(cRedColor),
                        ),
                      ),
                    ),
                  TextSpan(
                    text: '${globalController.commonPostList[postIndex].sharePosts?.price}\$ ',
                    style: semiBold20TextStyle(cBlackColor),
                  ),
                  TextSpan(
                    text: globalController.commonPostList[postIndex].sharePosts?.sellPostAvailabilty != 0 ? '• ${ksInStock.tr}' : '• ${ksStockOut.tr}',
                    style: semiBold20TextStyle(globalController.commonPostList[postIndex].sharePosts?.sellPostAvailabilty != 0 ? cLinkColor : cRedColor),
                  ),
                ],
              ),
            ),
          ),
        if (globalController.commonPostList[postIndex].sharePosts?.discount != null &&
            globalController.commonPostList[postIndex].sharePosts?.postCategory?.name == 'Selling')
          Padding(
            padding: const EdgeInsets.only(bottom: k8Padding, left: kHorizontalPadding),
            child: Text(
              '${ksLastPrice.tr}: 400\$ ',
              style: regular14TextStyle(cSmallBodyTextColor).copyWith(decoration: TextDecoration.lineThrough),
            ),
          ),
        if (globalController.commonPostList[postIndex].sharePosts?.content != null && globalController.commonPostList[postIndex].sharePosts?.content != '')
          Obx(() => Padding(
                padding: EdgeInsets.only(
                    left: kHorizontalPadding,
                    right: kHorizontalPadding,
                    bottom: (globalController.commonPostList[postIndex].sharePosts!.images.isNotEmpty ||
                            globalController.commonPostList[postIndex].sharePosts?.postCategory?.name == 'Selling')
                        ? k12Padding
                        : 0),
                child: RichText(
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.clip,
                  maxLines: (globalController.commonPostList[postIndex].sharePosts!.content!.length > 256) ? 5 : null,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: globalController.commonPostList[postIndex].sharePosts?.content,
                        style: (globalController.commonPostList[postIndex].sharePosts!.content!.length < 150 &&
                                globalController.commonPostList[postIndex].sharePosts?.postCategory?.name != 'Selling' &&
                                globalController.commonPostList[postIndex].sharePosts!.images.isEmpty)
                            ? regular20TextStyle(cBlackColor)
                            : regular14TextStyle(cBlackColor),
                      ),
                    ],
                  ),
                ),
              )),
        if (globalController.commonPostList[postIndex].sharePosts!.images.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Container(
              color: cWhiteColor,
              height: 302,
              width: width - 82,
              child: Column(
                children: [
                  Row(
                    children: [
                      TextButton(
                        style: kTextButtonStyle,
                        onPressed: () async {
                          if ((globalController.commonPostList[postIndex].sharePosts!.content != null &&
                                  globalController.commonPostList[postIndex].sharePosts!.content!.trim() != '') ||
                              globalController.commonPostList[postIndex].sharePosts!.images.length > 1) {
                            //! need to create for shared post
                            await Get.find<HomeController>().getPostData(globalController.commonPostList[postIndex].sharePosts!.id);
                          } else {
                            Get.to(() => CommonPhotoView(
                                  image: Environment.imageBaseUrl + globalController.commonPostList[postIndex].sharePosts!.images[0].path.toString(),
                                  postIndex: postIndex,
                                ));
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                          height: globalController.commonPostList[postIndex].sharePosts!.images.length < 2 ? 302 : 150,
                          width: globalController.commonPostList[postIndex].sharePosts!.images.length > 3 ? ((width - 82) / 2) - 1 : width - 82,
                          child: ClipRRect(
                            borderRadius: k8CircularBorderRadius,
                            child: Image.network(
                              globalController.commonPostList[postIndex].sharePosts!.images[0].fullPath.toString(),
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
                      if (globalController.commonPostList[postIndex].sharePosts!.images.length > 3)
                        const SizedBox(
                          width: 2,
                        ),
                      if (globalController.commonPostList[postIndex].sharePosts!.images.length > 3)
                        TextButton(
                          style: kTextButtonStyle,
                          onPressed: () async {
                            Get.to(() => HomePostDetailsScreen(
                                  postIndex: postIndex,
                                ));
                            await Get.find<HomeController>().getPostData(globalController.commonPostList[postIndex].sharePosts!.id);
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                            height: 150,
                            width: ((width - 82) / 2) - 1,
                            child: ClipRRect(
                              borderRadius: k8CircularBorderRadius,
                              child: Image.network(
                                globalController.commonPostList[postIndex].sharePosts!.images[1].fullPath.toString(),
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
                  if (globalController.commonPostList[postIndex].sharePosts!.images.length > 1)
                    const SizedBox(
                      height: 2,
                    ),
                  Row(
                    children: [
                      if (globalController.commonPostList[postIndex].sharePosts!.images.length < 4 &&
                          globalController.commonPostList[postIndex].sharePosts!.images.length > 1)
                        TextButton(
                          style: kTextButtonStyle,
                          onPressed: () async {
                            Get.to(() => HomePostDetailsScreen(
                                  postIndex: postIndex,
                                ));
                            await Get.find<HomeController>().getPostData(globalController.commonPostList[postIndex].sharePosts!.id);
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                            height: 150,
                            width: globalController.commonPostList[postIndex].sharePosts!.images.length < 3 ? (width - 82) : ((width - 82) / 2) - 1,
                            child: ClipRRect(
                              borderRadius: k8CircularBorderRadius,
                              child: Image.network(
                                globalController.commonPostList[postIndex].sharePosts!.images[1].fullPath.toString(),
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
                      if (globalController.commonPostList[postIndex].sharePosts!.images.length < 4 &&
                          globalController.commonPostList[postIndex].sharePosts!.images.length > 2)
                        const SizedBox(
                          width: 2,
                        ),
                      if (globalController.commonPostList[postIndex].sharePosts!.images.length > 2)
                        TextButton(
                          style: kTextButtonStyle,
                          onPressed: () async {
                            Get.to(() => HomePostDetailsScreen(
                                  postIndex: postIndex,
                                ));
                            await Get.find<HomeController>().getPostData(globalController.commonPostList[postIndex].sharePosts!.id);
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                            height: 150,
                            width: globalController.commonPostList[postIndex].sharePosts!.images.length > 4 ? (width - 86) / 3 : ((width - 82) / 2) - 1,
                            child: ClipRRect(
                              borderRadius: k8CircularBorderRadius,
                              child: Image.network(
                                globalController.commonPostList[postIndex].sharePosts!.images[2].fullPath.toString(),
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
                      if (globalController.commonPostList[postIndex].sharePosts!.images.length > 3)
                        const SizedBox(
                          width: 2,
                        ),
                      if (globalController.commonPostList[postIndex].sharePosts!.images.length > 3)
                        TextButton(
                          style: kTextButtonStyle,
                          onPressed: () async {
                            //! need to create for shared post
                            await Get.find<HomeController>().getPostData(globalController.commonPostList[postIndex].sharePosts!.id);
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                            height: 150,
                            width: globalController.commonPostList[postIndex].sharePosts!.images.length < 5 ? ((width - 82) / 2) - 1 : (width - 86) / 3,
                            child: ClipRRect(
                              borderRadius: k8CircularBorderRadius,
                              child: Image.network(
                                globalController.commonPostList[postIndex].sharePosts!.images[3].fullPath.toString(),
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
                      if (globalController.commonPostList[postIndex].sharePosts!.images.length > 4)
                        const SizedBox(
                          width: 2,
                        ),
                      if (globalController.commonPostList[postIndex].sharePosts!.images.length >= 5)
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            TextButton(
                              style: kTextButtonStyle,
                              onPressed: () async {
                                Get.to(() => HomePostDetailsScreen(
                                      postIndex: postIndex,
                                    ));
                                await Get.find<HomeController>().getPostData(globalController.commonPostList[postIndex].sharePosts!.id);
                              },
                              child: Container(
                                  decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                                  height: 150,
                                  width: (width - 86) / 3,
                                  child: ClipRRect(
                                    borderRadius: k8CircularBorderRadius,
                                    child: Image.network(
                                      globalController.commonPostList[postIndex].sharePosts!.images[4].fullPath.toString(),
                                      fit: BoxFit.cover,
                                      color: globalController.commonPostList[postIndex].sharePosts!.images.length > 5 ? cBlackColor.withOpacity(0.3) : null,
                                      colorBlendMode: globalController.commonPostList[postIndex].sharePosts!.images.length > 5 ? BlendMode.multiply : null,
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
                                  )),
                            ),
                            if (globalController.commonPostList[postIndex].sharePosts!.images.length > 5)
                              Positioned(
                                child: TextButton(
                                  style: kTextButtonStyle,
                                  onPressed: () {
                                  },
                                  child: Text(
                                    "${globalController.commonPostList[postIndex].sharePosts!.images.length - 5} More",
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
        kH12sizedBox,
      ],
    );
  }
}
