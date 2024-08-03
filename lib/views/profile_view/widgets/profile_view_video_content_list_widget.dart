import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:bip_hip/widgets/post/like_section_widget.dart';
import 'package:bip_hip/widgets/post/post_activity_status_widget.dart';

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
        kH20sizedBox,
        PostActivityStatusWidget(
          postIndex: 1,
          isGiftShown: true,
        ),
        LikeSectionWidget(isGiftShown: true, postIndex: 1),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: CustomDivider(),
        ),
        kH16sizedBox,
      ],
    );
  }
}
