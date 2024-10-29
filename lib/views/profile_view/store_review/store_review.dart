import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:bip_hip/shimmers/profile/profile_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/post/like_section_widget.dart';
import 'package:flutter_svg/svg.dart';

class StoreReview extends StatelessWidget {
  StoreReview({super.key});
  final ProfileViewController profileViewController = Get.find<ProfileViewController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => profileViewController.isStoreReviewLoading.value
          ? const PostCommonShimmer()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                  child: Text(
                    ksReviews.tr,
                    style: semiBold18TextStyle(cBlackColor),
                  ),
                ),
                kH12sizedBox,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                  child: Text(
                    ksDoYouRecommendGenieInfoTech.tr,
                    style: regular20TextStyle(cBlackColor),
                  ),
                ),
                kH24sizedBox,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                  child: Row(
                    children: [
                      CustomElevatedButton(
                        buttonWidth: (width - 56) / 2,
                        buttonHeight: h32,
                        buttonColor: cPrimaryColor,
                        textStyle: semiBold16TextStyle(cWhiteColor),
                        label: ksYes.tr,
                        onPressed: () {
                          Get.toNamed(krProfileViewCreateReview);
                        },
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
                ),
                if (profileViewController.profileViewStoreReviewList.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                    child: SizedBox(
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
                  ),
                if (profileViewController.profileViewStoreReviewList.isNotEmpty)
                  Column(
                    children: [
                      kH24sizedBox,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                        child: Row(
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
                            // Text(
                            //   profileViewController.profileViewStoreData.value.reviews.data,
                            //   style: regular20TextStyle(cBlackColor),
                            // ),
                            // Text(
                            //   " (${profileViewController.storeRatingReviewCount.value} ${ksReviews.tr})",
                            //   style: regular20TextStyle(cBlackColor),
                            // ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: width,
                            child: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Obx(() => SizedBox(
                                          child: StoreReviewPostWidget(
                                        userImage: profileViewController.profileViewStoreReviewList[index].user!.profilePicture!,
                                        userName: profileViewController.profileViewStoreReviewList[index].user!.fullName!,
                                        postText: profileViewController.profileViewStoreReviewList[index].content,
                                        postDate: profileViewController.profileViewStoreReviewList[index].createdAt,
                                        // storeName: profileViewController.profileViewStoreReviewList[index].,
                                        storeName: profileViewController.storeProfileData.value?.name ?? ksNA.tr,
                                        ratingValue: profileViewController.storeProfileData.value?.rating.toString(),
                                        postIndex: index,
                                      )));
                                },
                                separatorBuilder: (context, index) => Container(
                                      color: cBackgroundColor,
                                      height: 8,
                                      width: width,
                                    ),
                                itemCount: profileViewController.profileViewStoreReviewList.length),
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
    );
  }
}

class StoreReviewPostWidget extends StatelessWidget {
  const StoreReviewPostWidget(
      {super.key, this.postText, this.postDate, this.userName, this.userImage, this.storeName, this.ratingValue, required this.postIndex});
  final String? postText, userName, userImage, storeName, ratingValue;
  final DateTime? postDate;
  final int postIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: k20Padding),
      child: SizedBox(
        width: width,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: h16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                TextSpan(
                                  text: " $ksRecommends".tr,
                                  style: regular16TextStyle(cSmallBodyTextColor),
                                ),
                                const TextSpan(text: '\n'),
                                TextSpan(
                                  text: storeName ?? ksNA.tr,
                                  style: regular16TextStyle(cBlackColor),
                                ),
                                TextSpan(
                                  text: "  $ksWith".tr,
                                  style: regular16TextStyle(cSmallBodyTextColor),
                                ),
                                TextSpan(
                                  text: " $ratingValue ${ksStar.tr}",
                                  style: regular16TextStyle(cBlackColor),
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
                      ],
                    ),
                    kH8sizedBox,
                    SizedBox(
                      width: width - 40,
                      child: Text(
                        postText ?? ksNA.tr,
                        style: regular14TextStyle(cBlackColor),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    const SizedBox(
                      height: h16,
                    ),
                    //! Like section widget not work properly
                    LikeSectionWidget(isGiftShown: true, postIndex: postIndex),
                    const SizedBox(
                      height: h16,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// class StoreReviewPostShimmer extends StatelessWidget {
//   const StoreReviewPostShimmer({super.key,});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: k20Padding),
//       child: SizedBox(
//         width: width,
//         child: Row(
//           mainAxisSize: MainAxisSize.max,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(
//                   height: h16,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         ClipOval(
//                           child: Container(
//                             height: h44,
//                             width: h44,
//                             decoration: const BoxDecoration(
//                               color: cBlackColor,
//                               shape: BoxShape.circle,
//                             ),
//                             child: Image.network(
//                               userImage ?? "",
//                               fit: BoxFit.cover,
//                               errorBuilder: (context, error, stackTrace) => const Icon(
//                                 BipHip.user,
//                                 size: kIconSize24,
//                                 color: cIconColor,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 2.0, left: k8Padding),
//                           child: RichText(
//                             textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
//                             textAlign: TextAlign.left,
//                             overflow: TextOverflow.clip,
//                             maxLines: 3,
//                             text: TextSpan(
//                               style: DefaultTextStyle.of(context).style.copyWith(height: 1.4),
//                               children: [
//                                 TextSpan(
//                                   text: userName,
//                                   style: semiBold16TextStyle(cBlackColor),
//                                 ),
//                                 TextSpan(
//                                   text: " $ksRecommends".tr,
//                                   style: regular16TextStyle(cSmallBodyTextColor),
//                                 ),
//                                 TextSpan(
//                                   text: " ".tr,
//                                   style: regular16TextStyle(cSmallBodyTextColor),
//                                 ),
//                                 const TextSpan(text: '\n'),
//                                 const WidgetSpan(
//                                   baseline: TextBaseline.alphabetic,
//                                   alignment: PlaceholderAlignment.baseline,
//                                   child: Padding(
//                                     padding: EdgeInsets.only(bottom: 0),
//                                     child: Icon(
//                                       // globalController.privacyList.firstWhere(
//                                       //   (element) => element['id'] == globalController.commonPostList[postIndex].isPublic,
//                                       // )["icon"],
//                                       BipHip.world,
//                                       color: cIconColor,
//                                       size: kIconSize12,
//                                     ),
//                                   ),
//                                 ),
//                                 TextSpan(
//                                     text: ' ${Get.find<GlobalController>().postTimeDifference(postDate ?? DateTime.now())}',
//                                     style: regular14TextStyle(cSmallBodyTextColor))
//                               ],
//                             ),
//                           ),
//                         ),
//                         // InkWell(
//                         //   onTap: () {
//                         //     globalController.postSelectedAction.value = "";
//                         //     globalController.selectedAudienceId.value = globalController.commonPostList[postIndex].isPublic!;
//                         //     globalController.blankBottomSheet(
//                         //       context: context,
//                         //       bottomSheetHeight: isDeviceScreenLarge() ? height * 0.32 : height * 0.40,
//                         //       content: Get.find<GlobalController>().userId.value == globalController.commonPostList[postIndex].user!.id
//                         //           ? SelfPostActionContent(
//                         //               postIndex: postIndex,
//                         //             )
//                         //           : OthersPostActionContent(
//                         //               postIndex: postIndex,
//                         //             ),
//                         //     );
//                         //   },
//                         //   child: const Padding(
//                         //     padding: EdgeInsets.only(top: k4Padding),
//                         //     child: Icon(
//                         //       BipHip.system,
//                         //       size: kIconSize18,
//                         //       color: cIconColor,
//                         //     ),
//                         //   ),
//                         // ),
//                       ],
//                     ),
//                     kH8sizedBox,
//                     SizedBox(
//                       width: width - 40,
//                       child: Text(
//                         postText ?? ksNA.tr,
//                         style: regular14TextStyle(cBlackColor),
//                         overflow: TextOverflow.clip,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: h16,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
