import 'package:bip_hip/controllers/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile/edit_profile.dart';
import 'package:bip_hip/views/profile/photo_details.dart';
import 'package:bip_hip/views/profile/post_widgets/comment_widget.dart';
import 'package:video_player/video_player.dart';

class VideoDetails extends StatelessWidget {
  VideoDetails({super.key});

  final ProfileController _profileController = Get.find<ProfileController>();

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
                    Text(
                      'Comment',
                      style: semiBold14TextStyle(cBlackColor),
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
