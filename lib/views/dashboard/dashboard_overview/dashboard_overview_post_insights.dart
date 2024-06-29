import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter_svg/svg.dart';

class DashboardOverviewPostInsights extends StatelessWidget {
  DashboardOverviewPostInsights({super.key, this.postContent, this.postImage});
  final String? postContent, postImage;
  final DashboardController dashboardController = Get.find<DashboardController>();
  // final bool isVideoContent;

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
              title: ksPostInsights.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kH16sizedBox,
                Row(
                  children: [
                    if (postImage != null)
                      Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(h8), bottomLeft: Radius.circular(h8)), color: cWhiteColor),
                        // height: 70,
                        // width: 70,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(h8), bottomLeft: Radius.circular(h8)),
                          child: Image.network(
                            postImage ?? "",
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => const Icon(
                              BipHip.imageFile,
                              size: kIconSize20,
                              color: cIconColor,
                            ),
                            loadingBuilder: imageLoadingBuilder,
                            frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                              return child;
                            },
                          ),
                        ),
                      ),
                    if (postImage != null && postContent != null)
                      Container(
                        width: width - 110,
                        // height: 70,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(k8BorderRadius), bottomRight: Radius.circular(k8BorderRadius)),
                          border: Border(
                            top: BorderSide(width: 1, color: cLineColor),
                            right: BorderSide(width: 1, color: cLineColor),
                            bottom: BorderSide(width: 1, color: cLineColor),
                            left: BorderSide.none,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: k8Padding, left: k8Padding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (postContent != null)
                                SizedBox(
                                  width: width - 130,
                                  child: Text(
                                    postContent!,
                                    style: semiBold16TextStyle(cBlackColor),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              kH4sizedBox,
                              Text(
                                Get.find<GlobalController>().userName.value ?? ksNA,
                                style: postContent != null ? regular14TextStyle(cSmallBodyTextColor) : semiBold16TextStyle(cBlackColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (postImage == null && postContent != null)
                      Padding(
                        padding: const EdgeInsets.all(k8Padding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (postContent != null)
                              SizedBox(
                                width: width - 56,
                                child: Text(
                                  postContent!,
                                  style: semiBold16TextStyle(cBlackColor),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            kH4sizedBox,
                            Text(
                              Get.find<GlobalController>().userName.value ?? ksNA,
                              style: postContent != null ? regular14TextStyle(cSmallBodyTextColor) : semiBold16TextStyle(cBlackColor),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                kH8sizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Get.find<GlobalController>().postTimeDifference(dashboardController.dashboardPostInsightData.value!.post!.dateTime!),
                      style: regular12TextStyle(cSmallBodyTextColor),
                    ),
                    kW4sizedBox,
                    Container(
                      width: 2,
                      height: 2,
                      decoration: const BoxDecoration(
                        color: cSmallBodyTextColor,
                      ),
                    ),
                    kW4sizedBox,
                    //  Icon(
                    //   ,
                    //   color: cIconColor,
                    //   size: kIconSize12,
                    // ),
                    Icon(
                      Get.find<GlobalController>().privacyIcon(dashboardController.dashboardPostInsightData.value?.post?.isPublic),
                      color: cIconColor,
                      size: kIconSize12,
                    ),
                  ],
                ),
                kH20sizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          ksPostView.tr,
                          style: regular14TextStyle(cBlackColor),
                        ),
                        kH4sizedBox,
                        Text(
                          dashboardController.dashboardPostInsightData.value?.countView.toString() ?? ksNA.tr,
                          style: semiBold16TextStyle(cBlackColor),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          ksEngagement.tr,
                          style: regular14TextStyle(cBlackColor),
                        ),
                        kH4sizedBox,
                        Text(
                          dashboardController.dashboardPostInsightData.value?.countEngagement.toString() ?? ksNA.tr,
                          style: semiBold16TextStyle(cBlackColor),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          ksGift.tr,
                          style: regular14TextStyle(cBlackColor),
                        ),
                        kH4sizedBox,
                        Text(
                          dashboardController.dashboardPostInsightData.value?.countGift.toString() ?? ksNA.tr,
                          style: semiBold16TextStyle(cBlackColor),
                        ),
                      ],
                    ),
                  ],
                ),
                kH20sizedBox,
                Text(
                  ksOverview.tr,
                  style: semiBold18TextStyle(cBlackColor),
                ),
                kH16sizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ksReach.tr,
                      style: regular12TextStyle(cBlackColor),
                    ),
                    Text(
                      // dashboardController.dashboardPostInsightData.value?..toString()??ksNA.tr,
                      ksNA.tr, //!Reach count data missing
                      style: regular12TextStyle(cBlackColor),
                    ),
                  ],
                ),
                kH12sizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ksImpression.tr,
                      style: regular12TextStyle(cBlackColor),
                    ),
                    Text(
                      // dashboardController.dashboardPostInsightData.value?..toString()??ksNA.tr,//!Impresseion data missing
                      ksNA.tr,
                      style: regular12TextStyle(cBlackColor),
                    ),
                  ],
                ),
                kH20sizedBox,
                Text(
                  ksInteractions.tr,
                  style: semiBold18TextStyle(cBlackColor),
                ),
                kH16sizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SvgPicture.asset(
                          kiLikeSvgImageUrl,
                          width: h24,
                          height: h24,
                        ),
                        kH8sizedBox,
                        Text(
                          dashboardController.dashboardPostInsightData.value?.countReactionLike.toString() ?? ksNA.tr,
                          style: regular12TextStyle(cBlackColor),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SvgPicture.asset(
                          kiLoveSvgImageUrl,
                          width: h24,
                          height: h24,
                        ),
                        kH8sizedBox,
                        Text(
                          dashboardController.dashboardPostInsightData.value?.countReactionLove.toString() ?? ksNA.tr,
                          style: regular12TextStyle(cBlackColor),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SvgPicture.asset(
                          kiHahaSvgImageUrl,
                          width: h24,
                          height: h24,
                        ),
                        kH8sizedBox,
                        Text(
                          dashboardController.dashboardPostInsightData.value?.countReactionHaha.toString() ?? ksNA.tr,
                          style: regular12TextStyle(cBlackColor),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SvgPicture.asset(
                          kiWowSvgImageUrl,
                          width: h24,
                          height: h24,
                        ),
                        kH8sizedBox,
                        Text(
                          dashboardController.dashboardPostInsightData.value?.countReactionWow.toString() ?? ksNA.tr,
                          style: regular12TextStyle(cBlackColor),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SvgPicture.asset(
                          kiSadSvgImageUrl,
                          width: h24,
                          height: h24,
                        ),
                        kH8sizedBox,
                        Text(
                          dashboardController.dashboardPostInsightData.value?.countReactionLike.toString() ?? ksNA.tr,
                          style: regular12TextStyle(cBlackColor),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SvgPicture.asset(
                          kiAngrySvgImageUrl,
                          width: h24,
                          height: h24,
                        ),
                        kH8sizedBox,
                        Text(
                          dashboardController.dashboardPostInsightData.value?.countReactionAngry.toString() ?? ksNA.tr,
                          style: regular12TextStyle(cBlackColor),
                        ),
                      ],
                    ),
                  ],
                ),
                kH16sizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ksReactions.tr,
                      style: regular12TextStyle(cBlackColor),
                    ),
                    Text(
                      dashboardController.dashboardPostInsightData.value?.countReaction.toString() ?? ksNA.tr,
                      style: regular12TextStyle(cBlackColor),
                    ),
                  ],
                ),
                kH12sizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ksComments.tr,
                      style: regular12TextStyle(cBlackColor),
                    ),
                    Text(
                      dashboardController.dashboardPostInsightData.value?.countComment.toString() ?? ksNA.tr,
                      style: regular12TextStyle(cBlackColor),
                    ),
                  ],
                ),
                kH12sizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ksShares.tr,
                      style: regular12TextStyle(cBlackColor),
                    ),
                    Text(
                      dashboardController.dashboardPostInsightData.value?.countShare.toString() ?? ksNA.tr,
                      style: regular12TextStyle(cBlackColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
