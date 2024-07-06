import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/post/like_section_widget.dart';
import 'package:bip_hip/widgets/post/post_activity_status_widget.dart';

class ProfileViewVideoTab extends StatelessWidget {
  ProfileViewVideoTab({super.key});
  final ProfileViewController profileViewController = Get.find<ProfileViewController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.65,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: profileViewController.videoContentList.length,
                      itemBuilder: (context, index) {
                        return VideoContentListWidget(
                          videoPreviewImage: profileViewController.videoContentList[index]["videoPreviewImage"],
                          videoTitle: profileViewController.videoContentList[index]["videoTitle"],
                          videoPublishedDate: profileViewController.videoContentList[index]["videoPublishedDate"],
                          postIndex: profileViewController.videoContentList[index]["postIndex"],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoTabContent extends StatelessWidget {
  VideoTabContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.65,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        ),
      ),
    );
  }
}

class VideoContentListWidget extends StatelessWidget {
  const VideoContentListWidget(
      {super.key, required this.videoPreviewImage, required this.videoTitle, required this.videoPublishedDate, required this.postIndex});
  final String videoPreviewImage, videoTitle, videoPublishedDate;
  final int postIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(k8BorderRadius),
              child: Image.network(
                videoPreviewImage,
                width: width - 40,
                height: 145,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: InkWell(
                onTap: () {},
                child: const Icon(
                  BipHip.playNew,
                  size: kIconSize50,
                  color: cWhiteColor,
                ),
              ),
            ),
          ],
        ),
        kH8sizedBox,
        Text(
          videoTitle,
          style: semiBold14TextStyle(cBlackColor),
        ),
        kH4sizedBox,
        Text(
          videoPublishedDate,
          style: regular10TextStyle(cSmallBodyTextColor),
        ),
        kH35sizedBox,
        PostActivityStatusWidget(
          postIndex: 1,
          isGiftShown: true,
        ),
        LikeSectionWidget(isGiftShown: true, postIndex: 1),
      ],
    );
  }
}
