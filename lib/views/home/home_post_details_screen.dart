import 'package:bip_hip/controllers/home/home_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/home_page_widgets/post_upper_container.dart';
import 'package:bip_hip/views/home/home_post_details.dart';

class HomePostDetailsScreen extends StatelessWidget {
  HomePostDetailsScreen({super.key});

  final HomeController _homeController = Get.find<HomeController>();

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
              hasBackButton: true,
              isCenterTitle: true,
              title: 'Wahid Murad',
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: SizedBox(
            height: height - kAppBarSize - MediaQuery.of(context).padding.top,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: k12Padding),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: PostUpperContainer(userName: 'Wahid Murad', isCategorized: false, privacy: BipHip.world, postTime: '1hr'),
                    ),
                    kH12sizedBox,
                    CommonPostWidget(
                      isCommented: true,
                      isLiked: true,
                      isTextualPost: true,
                      mediaList: _homeController.postData.value!.post.imageUrls,
                      isSelfPost: true,
                      isCommentShown: true,
                      showBottomSection: true,
                      postText: _homeController.postData.value!.post.content,
                    ),
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

class CommonPostWidget extends StatelessWidget {
  const CommonPostWidget({
    super.key,
    required this.isCommented,
    required this.isLiked,
    required this.isTextualPost,
    this.category,
    this.title,
    this.postText,
    required this.mediaList,
    required this.isSelfPost,
    required this.isCommentShown,
    required this.showBottomSection,
  });
  final bool isCommented, isLiked, isTextualPost, isSelfPost, isCommentShown, showBottomSection;
  final String? category, title, postText;
  final List mediaList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isTextualPost)
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
        PostBottomSection(isCommentShown: isCommentShown),
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
                            onPressed: () {},
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
                          PostBottomSection(isCommentShown: isCommentShown),
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
