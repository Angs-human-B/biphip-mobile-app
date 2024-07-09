import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter_svg/svg.dart';

class StoreReview extends StatelessWidget {
  StoreReview({super.key});
  final ProfileViewController profileViewController = Get.find<ProfileViewController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (height * 0.42) - (kAppBarSize + MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ksReviews.tr,
              style: semiBold18TextStyle(cBlackColor),
            ),
            kH12sizedBox,
            Text(
              ksDoYouRecommendGenieInfoTech.tr,
              style: regular20TextStyle(cBlackColor),
            ),
            kH24sizedBox,
            Row(
              children: [
                CustomElevatedButton(
                  buttonWidth: (width - 56) / 2,
                  buttonHeight: h32,
                  buttonColor: cPrimaryColor,
                  textStyle: semiBold16TextStyle(cWhiteColor),
                  label: ksYes.tr,
                  onPressed: () {},
                ),
                kW16sizedBox,
                CustomElevatedButton(
                  buttonWidth: (width - 56) / 2,
                  buttonHeight: h32,
                  buttonColor: cWhiteColor,
                  borderColor: cPrimaryColor,
                  textStyle: semiBold16TextStyle(cPrimaryColor),
                  label: ksNo.tr,
                  onPressed: () {},
                ),
              ],
            ),
            if (profileViewController.storeRatingReviewCount.value == 0)
              SizedBox(
                height: height * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        kiReviewSvgImage,
                        width: h60,
                        height: h60,
                        color: cIconColor,
                      ),
                    ),
                    kH16sizedBox,
                    Text(
                      ksNoReviews.tr,
                      style: semiBold16TextStyle(cBlackColor),
                    ),
                  ],
                ),
              ),
            if (profileViewController.storeRatingReviewCount.value != 0)
              Column(
                children: [
                  kH24sizedBox,
                  Row(
                    children: [
                      Text(
                        ksRating.tr,
                        style: regular20TextStyle(cBlackColor),
                      ),
                      kW8sizedBox,
                      Container(
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: cBlackColor,
                        ),
                      ),
                      kW8sizedBox,
                      Text(
                        profileViewController.storeRating.value,
                        style: regular20TextStyle(cBlackColor),
                      ),
                      Text(
                        " (${profileViewController.storeRatingReviewCount.value} ${ksReviews.tr})",
                        style: regular20TextStyle(cBlackColor),
                      ),
                    ],
                  ),
                  kH16sizedBox,
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          width: width,
                          height: height * 0.138,
                          child: ListView.separated(
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                // return StoreReviewPostWidget(
                                //   userName: profileViewController.storeReviewList[index]["userName"],
                                //   postText: profileViewController.storeReviewList[index]["postText"],
                                // );
                                return SizedBox(
                                    width: width,
                                    height: height * 0.11,
                                    child: StoreReviewPostWidget(
                                      userImage: profileViewController.storeReviewList[index]["userImage"],
                                      userName: profileViewController.storeReviewList[index]["userName"],
                                      postText: profileViewController.storeReviewList[index]["postText"],
                                    ));
                              },
                              separatorBuilder: (context, index) => kH8sizedBox,
                              itemCount: profileViewController.storeReviewList.length),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class StoreReviewPostWidget extends StatelessWidget {
  const StoreReviewPostWidget({super.key, this.postText, this.postDate, this.userName, this.userImage});
  final String? postText, userName, userImage;
  final DateTime? postDate;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          child: Container(
                            height: h44,
                            width: h44,
                            decoration: const BoxDecoration(
                              color: cBlackColor,
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                              userImage ?? "",
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const Icon(
                                BipHip.user,
                                size: kIconSize24,
                                color: cIconColor,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0, left: k8Padding),
                          child: RichText(
                            textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.clip,
                            maxLines: 3,
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style.copyWith(height: 1.4),
                              children: [
                                TextSpan(
                                  text: userName,
                                  style: semiBold16TextStyle(cBlackColor),
                                ),
                                const TextSpan(text: '\n'),
                                const WidgetSpan(
                                  baseline: TextBaseline.alphabetic,
                                  alignment: PlaceholderAlignment.baseline,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 0),
                                    child: Icon(
                                      // globalController.privacyList.firstWhere(
                                      //   (element) => element['id'] == globalController.commonPostList[postIndex].isPublic,
                                      // )["icon"],
                                      BipHip.world,
                                      color: cIconColor,
                                      size: kIconSize12,
                                    ),
                                  ),
                                ),
                                TextSpan(
                                    text: ' ${Get.find<GlobalController>().postTimeDifference(postDate ?? DateTime.now())}',
                                    style: regular14TextStyle(cSmallBodyTextColor))
                              ],
                            ),
                          ),
                        ),
                        // InkWell(
                        //   onTap: () {
                        //     globalController.postSelectedAction.value = "";
                        //     globalController.selectedAudienceId.value = globalController.commonPostList[postIndex].isPublic!;
                        //     globalController.blankBottomSheet(
                        //       context: context,
                        //       bottomSheetHeight: isDeviceScreenLarge() ? height * 0.32 : height * 0.40,
                        //       content: Get.find<GlobalController>().userId.value == globalController.commonPostList[postIndex].user!.id
                        //           ? SelfPostActionContent(
                        //               postIndex: postIndex,
                        //             )
                        //           : OthersPostActionContent(
                        //               postIndex: postIndex,
                        //             ),
                        //     );
                        //   },
                        //   child: const Padding(
                        //     padding: EdgeInsets.only(top: k4Padding),
                        //     child: Icon(
                        //       BipHip.system,
                        //       size: kIconSize18,
                        //       color: cIconColor,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    kH8sizedBox,
                    Text(
                      postText ?? ksNA.tr,
                      style: regular14TextStyle(cBlackColor),
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
