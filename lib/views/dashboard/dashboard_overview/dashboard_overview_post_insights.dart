import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter_svg/svg.dart';

class DashboardOverviewPostInsights extends StatelessWidget {
  const DashboardOverviewPostInsights({super.key, this.postContent, this.postImage});
  final String? postContent, postImage;
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
                if (postImage != null)
                  Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(h8), bottomLeft: Radius.circular(h8)), color: cWhiteColor),
                        height: 70,
                        width: 70,
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
                      Container(
                        width: width - 110,
                        height: 70,
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
                    ],
                  ),
                kH8sizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Saturday, 6.57pm",
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
                    const Icon(
                      BipHip.lock,
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
                          "0",
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
                          "0",
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
                          "0",
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
                      "21252",
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
                      "453",
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
                          "440",
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
                          "430",
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
                          "420",
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
                          "410",
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
                          "400",
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
                          "300",
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
                      "21252",
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
                      "235",
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
                      "124",
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
