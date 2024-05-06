import 'package:bip_hip/controllers/menu/award_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/widgets/common_photo_view.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:flutter_svg/svg.dart';

class AwardDetailsPage extends StatelessWidget {
  AwardDetailsPage({
    super.key,
    this.userImage,
    this.certificateImage,
    this.ranking,
    this.winningDate,
  });
  final String? userImage;
  final String? certificateImage;
  final String? ranking;
  final String? winningDate;
  final AwardController awardController = Get.find<AwardController>();

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
              title: ksAwards.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Obx(
              () => SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: width,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const SizedBox(
                            height: 82,
                            width: 56,
                          ),
                          Positioned(
                            top: h16,
                            child: Container(
                              width: 56,
                              height: 56,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    cYellowLinearColor1,
                                    cYellowLinearColor2,
                                  ],
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(k4Padding),
                                child: ClipOval(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: cWhiteColor,
                                    ),
                                    child: Image.network(
                                      userImage!,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => const Icon(
                                        BipHip.imageFile,
                                        size: kIconSize40,
                                        color: cIconColor,
                                      ),
                                      loadingBuilder: imageLoadingBuilder,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 2,
                            left: (width - 60) / 2,
                            child: SvgPicture.asset(
                              kiWinner,
                              width: h24,
                              height: h24,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: (width - 60) / 2,
                            child: Stack(
                              children: [
                                Container(),
                                SvgPicture.asset(
                                  kiPositionBadge,
                                  width: h24,
                                  height: h24,
                                ),
                                Positioned(
                                    top: 6,
                                    left: h8,
                                    child: Text(
                                      ranking ?? '0',
                                      style: semiBold10TextStyle(cWhiteColor),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    kH8sizedBox,
                    Text(
                      'Aminul islam rana',
                      style: semiBold16TextStyle(cBlackColor),
                      textAlign: TextAlign.left,
                    ),
                    kH4sizedBox,
                    Text(
                      winningDate ?? '',
                      style: regular12TextStyle(cSmallBodyTextColor),
                      textAlign: TextAlign.left,
                    ),
                    if (awardController.isOthersWinner.value)
                      Padding(
                        padding: const EdgeInsets.only(top: k8Padding),
                        child: Text(
                          ksSeeProfile.tr,
                          style: semiBold14TextStyle(cPrimaryColor),
                        ),
                      ),
                    kH24sizedBox,
                    CustomElevatedButton(
                      label: ksViewCertificate.tr,
                      onPressed: () {
                        Get.to(() => CommonPhotoView(
                              image: certificateImage ?? '',
                              description: '',
                              isLikeSectionShow: false,
                              topRightIcon: Icons.download,//!Download Icon should be chnage 
                            ));
                      },
                      buttonWidth: width - 40,
                      buttonHeight: h32,
                      buttonColor: cWhiteColor,
                      borderColor: cPrimaryColor,
                      textStyle: regular12TextStyle(cPrimaryColor),
                    ),
                    kH24sizedBox,
                    //  PostUpperContainer(
                    //     userName: 'Wahid Murad',
                    //     isCategorized: true,
                    //     privacy: BipHip.world,
                    //     postTime: '1 hr',
                    //     category: 'Photography',
                    //     categoryIcon: BipHip.photography,
                    //     categoryIconColor: cPhotographyColor,
                    //     userImage: 'https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/3155475/user-clipart-md.png',
                    //     taggedFriend: []),
                    kH12sizedBox,
                    SizedBox(
                      width: width - 40,
                      height: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(k8BorderRadius),
                        child: Image.network(
                          "https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/featured_hu6547841b230d5bd693e155a5fda2f54e_25956_768x0_resize_q75_lanczos.jpg",
                          fit: BoxFit.cover,
                          loadingBuilder: imageLoadingBuilder,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              kiProfileDefaultImageUrl,
                              height: h40,
                              width: h40,
                            );
                          },
                        ),
                      ),
                    ),
                    kH12sizedBox,
                    // LikeSectionWidget(
                    //   isGiftShown: true,
                    //   giftOnPressed: () {},
                    //   commentOnPressed: () {
                    //     awardController.isCommentOnPressed.value = !awardController.isCommentOnPressed.value;
                    //   },
                    // ),
                    const CustomDivider(),
                    kH12sizedBox,
                    // if (awardController.isCommentOnPressed.value)
                      // CommentWidget(
                      //   profileImage: kiDummyImage3ImageUrl,
                      //   comment:
                      //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Diam nisi, cras neque, lorem vel vulputate vitae aliquam. Pretium tristique nisi, ut commodo fames. Porttitor et sagittis egestas vitae metus, odio tristique amet, duis.',
                      //   timePassed: '30',
                      //   isLikeButtonShown: true,
                      //   commentLink: 'https://itnext.io/showing-url-preview-in-flutter-a3ad4ff9927e',
                      //   isReplyButtonShown: true,
                      //   isReactButtonShown: true,
                      //   isImageComment: true,
                      //   image: kiDummyImage3ImageUrl,
                      //   isLink: false,
                      //   userName: 'Monjurul Sharker Omi',
                      //   isSendMessageShown: false,
                      //   isHideButtonShown: true,
                      //   replyList: replyComment,
                      // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
