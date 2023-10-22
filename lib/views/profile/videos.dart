import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/models/utility/video_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile/edit_profile.dart';
import 'package:bip_hip/views/profile/post_widgets/like_section_widget.dart';
import 'package:bip_hip/views/profile/post_widgets/post_activity_status_widget.dart';

class Videos extends StatelessWidget {
  const Videos({super.key});

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
              title: ksVideos.tr,
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
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: Column(
                  children: [
                    kH20sizedBox,
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: videos.length,
                        itemBuilder: (context, index) {
                          var item = videos[index];
                          return VideoContentSection(
                            item: item,
                          );
                        })
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

class VideoContentSection extends StatelessWidget {
  VideoContentSection({super.key, required this.item});

  final ProfileController _profileController = Get.find<ProfileController>();

  final Video item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: k20Padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              ll('play');
              _profileController.videoUrl.value = item.url;
              _profileController.playVideo(_profileController.videoUrl.value, init: true);

              Get.toNamed(krVideoDetails);
            },
            child: Stack(
              children: [
                SizedBox(
                  height: 170,
                  width: width,
                  child: ClipRRect(
                    borderRadius: k8CircularBorderRadius,
                    child: Image.network(
                      item.thumbnail,
                      fit: BoxFit.cover,
                      color: cBlackColor.withOpacity(0.5),
                      colorBlendMode: BlendMode.multiply,
                    ),
                  ),
                ),
                Positioned(
                  top: 55,
                  left: (width / 2) - 50,
                  child: const Icon(
                    BipHip.play,
                    color: cWhiteColor,
                    size: kIconSize60,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: InkWell(
                    onTap: () {
                      ll('edit');
                    },
                    child: Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        color: cWhiteColor,
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: const Icon(
                        BipHip.edit,
                        color: cBlackColor,
                        size: kIconSize14,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          kH16sizedBox,
          Text(
            item.name,
            style: semiBold14TextStyle(cBlackColor),
          ),
          kH4sizedBox,
          Text(
            '3 September, 2023',
            style: regular12TextStyle(cSmallBodyTextColor),
          ),
          kH16sizedBox,
          PostActivityStatusWidget(
            reactCount: 440,
            reactionOnPressed: () {
              // _postReactionController.giftFilter(0);
              // _globalController.blankBottomSheet(
              //     context: context, content: _BadgeTabViewContent(), isScrollControlled: true, bottomSheetHeight: height * .9);
            },
            giftCount: 50,
            commentCount: 200,
            shareCount: 340,
            isGiftShown: true,
            giftOnPressed: () {
              // _postReactionController.giftFilter(0);
              // _globalController.blankBottomSheet(
              //     context: context, content: _BadgeTabViewContent(), isScrollControlled: true, bottomSheetHeight: height * .9);
            },
          ),
          LikeSectionWidget(
            isGiftShown: true,
            giftOnPressed: () {
              // _globalController.blankBottomSheet(context: context, content: _GiftContent(), isScrollControlled: true, bottomSheetHeight: height * .9);
            },
            commentOnPressed: () {
              // showComment.value = !showComment.value;
              // ll(showComment);
            },
          ),
          // const Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [InteractionStats(), UserInteractionView()],
          // ),
          const CustomDivider(),
        ],
      ),
    );
  }
}
