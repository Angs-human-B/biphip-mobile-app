import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/home_page_widgets/post_upper_container.dart';
import 'package:bip_hip/views/home/home_post_details.dart';

class HomePostDetailsScreen extends StatelessWidget {
  const HomePostDetailsScreen({super.key});

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
            child: const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: k12Padding),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: PostUpperContainer(userName: 'Wahid Murad', isCategorized: false, privacy: BipHip.world, postTime: '1hr'),
                    ),
                    kH12sizedBox,
                    CommonPostWidget(
                      isCommented: true,
                      isLiked: true,
                      isTextualPost: true,
                      mediaList: [kiDummyImage1ImageUrl, kiDummyImage2ImageUrl, kiDummyImage3ImageUrl],
                      isSelfPost: true,
                      isCommentShown: true,
                      showBottomSection: true,
                      postText:
                          'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which dont look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isnt anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.',
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
        PostBottomSection( isCommentShown: isCommentShown),
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
                              child: Image.asset(
                                mediaList[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          PostBottomSection( isCommentShown: isCommentShown),
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
