import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/models/utility/video_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';

class VideoContentSection extends StatelessWidget {
  VideoContentSection({super.key, required this.item});

  final ProfileController profileController = Get.find<ProfileController>();

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
              profileController.videoUrl.value = item.url;
              profileController.playVideo(profileController.videoUrl.value, init: true);

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
          // PostActivityStatusWidget(
          //   // reactCount: 440,
          //   reactionOnPressed: () {
          //   },
          //   giftCount: 50,
          //   commentCount: 200,
          //   shareCount: 340,
          //   isGiftShown: true,
          //   giftOnPressed: () {
          //   },
          // ),
          // LikeSectionWidget(
          //   isGiftShown: true,
          //   giftOnPressed: () {
          //   },
          //   commentOnPressed: () {
          //   },
          // ),
          const CustomDivider(),
        ],
      ),
    );
  }
}
