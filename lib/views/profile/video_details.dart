import 'package:bip_hip/controllers/create_post_controller.dart';
import 'package:bip_hip/controllers/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile/edit_profile.dart';
import 'package:bip_hip/views/profile/photo_details.dart';
import 'package:bip_hip/views/profile/post_widgets/comment_widget.dart';
import 'package:video_player/video_player.dart';

class VideoDetails extends StatelessWidget {
  VideoDetails({super.key});

  final ProfileController _profileController = Get.find<ProfileController>();
  final CreatePostController _createPostController = Get.find<CreatePostController>();

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
              title: 'Videos'.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: SizedBox(
            height: height - kAppBarSize,
            width: width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    kH24sizedBox,
                    SizedBox(
                      height: 200,
                      width: width,
                      child: ClipRRect(
                        borderRadius: k8CircularBorderRadius,
                        child: VideoPlayer(_profileController.videoPlayerController),
                      ),
                    ),
                    // kH20sizedBox,
                    // const CustomDivider(),
                    kH20sizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        kW8sizedBox,
                        Stack(
                          children: [
                            SizedBox(
                              width: (_createPostController.category.value == "Kids" || _createPostController.category.value == "Selling") ? 70 : h45,
                              child: Row(
                                children: [
                                  Container(
                                    height: h45,
                                    width: h45,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                      "assets/images/profileDefault.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (_createPostController.category.value == "Kids" || _createPostController.category.value == "Selling")
                              Positioned(
                                right: 0,
                                bottom: 0,
                                top: 0,
                                child: Container(
                                  height: h45,
                                  width: h45,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                    "assets/images/profilePic.png",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        kW8sizedBox,
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Obx(
                                      () => Padding(
                                        padding: const EdgeInsets.only(top: 2.0),
                                        child: RichText(
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.clip,
                                          maxLines: 2,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Jane Smith',
                                                style: semiBold16TextStyle(cBlackColor),
                                              ),
                                              if (_createPostController.isTagAdded.value)
                                                TextSpan(
                                                  text: ' is with ',
                                                  style: regular16TextStyle(cBlackColor),
                                                ),
                                              if (_createPostController.isTagAdded.value)
                                                TextSpan(
                                                  text: 'Shohag Jalal & 8 others',
                                                  style: semiBold16TextStyle(cBlackColor),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              kH4sizedBox,
                              Obx(
                                () => Row(
                                  children: [
                                    CustomElevatedButton(
                                      isCustomButton: true,
                                      label: _createPostController.postType.value,
                                      prefixIcon: _createPostController.postTypeIcon.value,
                                      onPressed: () {},
                                      buttonHeight: 22,
                                      buttonColor: cGreyBoxColor,
                                      prefixIconColor: cBlackColor,
                                      textStyle: medium12TextStyle(cBlackColor),
                                    ),
                                    kW8sizedBox,
                                    CustomElevatedButton(
                                      label: _createPostController.category.value == "" ? "Select Category" : _createPostController.category.value,
                                      prefixIcon: _createPostController.category.value == "" ? null : _createPostController.categoryIcon.value,
                                      prefixIconColor: _createPostController.category.value == "" ? null : _createPostController.categoryIconColor.value,
                                      onPressed: () {},
                                      buttonHeight: 22,
                                      isCustomButton: true,
                                      buttonColor: cGreyBoxColor,
                                      textStyle: medium12TextStyle(cBlackColor),
                                    ),
                                    if (_createPostController.category.value == "Selling") kW8sizedBox,
                                    if (_createPostController.category.value == "Selling")
                                      CustomElevatedButton(
                                        label: "Post Type",
                                        onPressed: () {},
                                        buttonHeight: 22,
                                        isCustomButton: true,
                                        prefixIcon: BipHip.webLink,
                                        buttonColor: cGreyBoxColor,
                                        prefixIconColor: cPrimaryColor,
                                        textStyle: medium12TextStyle(cBlackColor),
                                      ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    kH20sizedBox,
                    const CustomDivider(),
                    kH20sizedBox,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [InteractionStats(), UserInteractionView()],
                    ),
                    kH20sizedBox,
                    const CustomDivider(),
                    kH20sizedBox,
                    Row(
                      children: [
                        Text(
                          'Comment',
                          style: semiBold14TextStyle(cBlackColor),
                        ),
                      ],
                    ),
                    kH16sizedBox,
                    const CommentWidget(
                      profileImage: 'assets/images/profileDefault.png',
                      timePassed: '5',
                      isLikeButtonShown: true,
                      isReplyButtonShown: true,
                      isReactButtonShown: false,
                      comment: 'When I was 16 I won a great victory. Thought I would live to be hundred. Now I know I shall not see 30.',
                      isLink: false,
                      reactCount: 0,
                      userName: 'Sharker Omi',
                      isSendMessageShown: false,
                      isHideButtonShown: false,
                      isImageComment: false, replyList: [],
                    ),
                    kH16sizedBox,
                    const CommentWidget(
                      profileImage: 'assets/images/profileDefault.png',
                      timePassed: '5',
                      isLikeButtonShown: true,
                      isReplyButtonShown: true,
                      isReactButtonShown: false,
                      commentLink: 'https://www.youtube.com/watch?v=cDJXsPS5FPM',
                      isLink: true,
                      reactCount: 0,
                      userName: 'Sharker Omi',
                      isSendMessageShown: false,
                      isHideButtonShown: false,
                      isImageComment: false, replyList: [],
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
