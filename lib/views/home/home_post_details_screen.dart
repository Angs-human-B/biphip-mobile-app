import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/models/home/postListModel.dart';
import 'package:bip_hip/shimmers/home/home_page_details_screen_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/widgets/common_photo_view.dart';
import 'package:bip_hip/views/home/widgets/common_post_widget.dart';
import 'package:bip_hip/views/home/widgets/post_upper_container.dart';

class HomePostDetailsScreen extends StatelessWidget {
  HomePostDetailsScreen({super.key});

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeController.isPostDetailsPageLoading.value
          ? const HomePostDetailsScreenShimmer()
          : Container(
              color: cWhiteColor,
              child: SafeArea(
                top: false,
                child: Scaffold(
                  backgroundColor: cWhiteColor,
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(kAppBarSize),
                    //* info:: appBar
                    child: CustomAppBar(
                      hasBackButton: true,
                      isCenterTitle: true,
                      title: homeController.postData.value!.post.user!.fullName!,
                      onBack: () {
                        Get.back();
                      },
                    ),
                  ),
                  body: SizedBox(
                    height: height - kAppBarSize - MediaQuery.of(context).padding.top,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(top: k12Padding),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                              child: PostUpperContainer(
                                taggedFriend: homeController.postData.value!.post.taggedFriends,
                                userName: homeController.postData.value!.post.user!.fullName!,
                                isCategorized: true,
                                privacy: BipHip.world,
                                postTime: homeController.postTimeDifference(homeController.postData.value!.post.createdAt),
                                userImage: homeController.postData.value!.post.user!.profilePicture!,
                                category:
                                    homeController.postData.value!.post.postCategory == null ? null : homeController.postData.value!.post.postCategory!.name,
                                categoryIcon: homeController.postData.value!.post.postCategory == null
                                    ? null
                                    : homeController.getCategoryIcon(homeController.postData.value!.post.postCategory?.id),
                                categoryIconColor: homeController.postData.value!.post.postCategory == null
                                    ? null
                                    : homeController.getCategoryColor(homeController.postData.value!.post.postCategory?.id),
                                kidName: homeController.postData.value!.post.kid == null ? null : homeController.postData.value!.post.kid!.name, //API
                                kidAge: homeController.postData.value!.post.kid == null ? null : homeController.postData.value!.post.kid!.age.toString(), //API
                                brandName: homeController.postData.value!.post.brand == null ? null : homeController.postData.value!.post.brand!.name, //API
                                secondaryImage:
                                    homeController.postData.value!.post.kid?.profilePicture ?? homeController.postData.value!.post.brand?.profilePicture,
                              ),
                            ),
                            kH12sizedBox,
                            CommonPostDetailsScreenWidget(
                              isCommented: true,
                              isLiked: true,
                              mediaList: homeController.postData.value!.post.images,
                              isSelfPost: true,
                              isCommentShown: true,
                              showBottomSection: true,
                              postText: homeController.postData.value!.post.postCategory?.name == 'News'
                                  ? homeController.postData.value!.post.description ?? ''
                                  : homeController.postData.value!.post.content ?? '', //API
                              // title: homeController.postData.value!.post.title, //API
                              title: homeController.postData.value!.post.title, //API
                              reactCount: homeController.postData.value!.post.countReactions,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

class CommonPostDetailsScreenWidget extends StatelessWidget {
  const CommonPostDetailsScreenWidget({
    super.key,
    required this.isCommented,
    required this.isLiked,
    this.category,
    this.title,
    this.postText,
    required this.mediaList,
    required this.isSelfPost,
    required this.isCommentShown,
    required this.showBottomSection,  this.reactCount,
  });

  final CountReactions? reactCount;
  final bool isCommented, isLiked, isSelfPost, isCommentShown, showBottomSection;
  final String? category, title, postText;
  final List mediaList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: k8Padding, horizontal: kHorizontalPadding),
            child: Text(
              title!,
              overflow: TextOverflow.clip,
              style: semiBold14TextStyle(cBlackColor),
            ),
          ),
        if (postText != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: RichText(
              textAlign: TextAlign.left,
              overflow: TextOverflow.clip,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: postText!,
                    style: regular14TextStyle(cBlackColor),
                  ),
                ],
              ),
            ),
          ),
        PostBottomSection(
          isCommentShown: isCommentShown,
          isSelfPost: true,
          commentCount: 0,
          shareCount: 0,
          giftCount: 0, reactCount: reactCount,
        ),
        if (mediaList.isNotEmpty)
          Container(
            color: cWhiteColor,
            child: Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: mediaList.length,
                    itemBuilder: (context, index) {
                      // var item = homePagePost[index];
                      return Column(
                        children: [
                          TextButton(
                            style: kTextButtonStyle,
                            onPressed: () {
                              Get.to(() => CommonPhotoView(
                                    image: Environment.imageBaseUrl + mediaList[index].path.toString(),
                                  ));
                            },
                            child: Container(
                              decoration: BoxDecoration(borderRadius: k4CircularBorderRadius, color: cWhiteColor),
                              height: 300,
                              width: (width - 40),
                              child: ClipRRect(
                                borderRadius: k8CircularBorderRadius,
                                child: Image.network(
                                  Environment.imageBaseUrl + mediaList[index].path.toString(),
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
                          kH12sizedBox,
                          PostBottomSection(
                            isCommentShown: isCommentShown,
                            isSelfPost: true,
                            commentCount: 0,
                            shareCount: 0,
                            giftCount: 0, 
                            // reactCount: reactCount,
                          ),
                        ],
                      );
                    }),
              ],
            ),
          ),
      ],
    );
  }
}
