import 'package:bip_hip/controllers/menu/award_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/widgets/post_upper_container.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:bip_hip/widgets/post/like_section_widget.dart';
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
                if(awardController.isOthersWinner.value)
                Padding(
                  padding: const EdgeInsets.only(top: k8Padding),
                  child: Text(ksSeeProfile.tr,style: semiBold14TextStyle(cPrimaryColor),),
                ),
                kH24sizedBox,
                Container(
                  width: width - 40,
                  height: h32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(k8BorderRadius),
                    color: cWhiteColor,
                    border: Border.all(width: 1, color: cPrimaryColor),
                  ),
                  child: Center(
                    child: Text(
                      ksViewCertificate.tr,
                      style: regular12TextStyle(cPrimaryColor),
                    ),
                  ),
                ),
                kH24sizedBox,
                const PostUpperContainer(
                    userName: 'Wahid Murad',
                    isCategorized: true,
                    privacy: BipHip.world,
                    postTime: '1 hr',
                    category: 'Photography',
                    categoryIcon: BipHip.photography,
                    categoryIconColor: cPhotographyColor,
                    userImage: 'https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/3155475/user-clipart-md.png',
                    taggedFriend: []),
                // CommonPostWidget(
                //   postIndex: 1,
                //   isCommented: true,
                //   isLiked: true,
                //   isSharedPost: true,
                //   showBottomSection: true,
                //   userName: 'Wahid Murad',
                //   postTime: '1 hr',
                //   isCategorized: true,
                //   category: 'Photography',
                //   categoryIcon: BipHip.photography,
                //   categoryIconColor: cPhotographyColor, // Based on API
                //   privacy: BipHip.world,
                //   brandName: '', //API
                //   kidName: '', //API
                //   kidAge: '',
                //   postText: '', //API
                //   mediaList: awardController.imageList,
                //   isSelfPost: true,
                //   isCommentShown: true, commentCount: 0, shareCount: 0, giftCount: 0,
                //   // reactCount: item.countReactions,
                //   postID: 1,
                //   secondaryImage: '',
                //   subCategory: '',
                //   platformName: 'Jane Clothing',
                //   platformLink: 'www.facebook.com/Clothing/lorem',
                //   actionName: '',
                //   title: '',
                //   price: '',
                //   mainPrice: '400',
                //   discount: '',
                //   isInStock: false,
                //   productCondition: 'New',
                //   productCategory: 'Phone', userImage: 'https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/3155475/user-clipart-md.png',
                //   taggedFriends: [],
                // ),

                // CommonPostWidget(
                //     isCommented: true,
                //     isLiked: true,
                //     isCategorized: true,
                //     userName: "Wahid Murad",
                //     postTime: "1 hr",
                //     privacy: BipHip.world,
                //     mediaList: awardController.imageList,
                //     isSelfPost: true,
                //     isCommentShown: true,
                //     isSharedPost: true,
                //     showBottomSection: true,
                //     commentCount: 0,
                //     shareCount: 0,
                //     giftCount: 0,
                //     postID: 1,
                //     isInStock: false,
                //     postText: '',
                //     // userImage: "https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/3155475/user-clipart-md.png",
                //     userImage: 'https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/3155475/user-clipart-md.png',
                //     taggedFriends: []),
                kH12sizedBox,
                Container(
                  width: width - 40,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(k8BorderRadius),
                  ),
                  child: Image.network(
                    "https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/3155475/user-clipart-md.png",
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
                kH12sizedBox,
                LikeSectionWidget(
                  isGiftShown: true,
                  giftOnPressed: () {},
                  commentOnPressed: () {},
                ),
                const CustomDivider(),
                kH8sizedBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
