import 'package:bip_hip/controllers/home/selfie_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/widgets/post_upper_container.dart';
import 'package:story_view/story_view.dart';
// import 'package:story_view/widgets/story_view.dart';

class SelfieViewPage extends StatelessWidget {
  SelfieViewPage({super.key});
  final SelfieController selfieController = Get.find<SelfieController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Stack(
          children: [
            StoryView(
              //  selfieController.stories,
              storyItems: selfieController.stories,
              controller: StoryController(),
              inline: false,
              repeat: false,
              onStoryShow: (story, index) {
                ll('Story Show');
              },
              // onStoryHide: (s) {
              //   print('Story Hide');
              // },
              onComplete: () {
                ll('Story Complete');
              },
              progressPosition: ProgressPosition.top,
              indicatorHeight: IndicatorHeight.medium,
            ),
            const Positioned(
                top: 80,
                left: 20,
                child:
                    CustomstoryView(userImage: "https://impulse.aarafacademy.com/uploads/samples/g1.jpg", userName: "Test User", storyUploadTime: "Just now")),
            Positioned(
              bottom: 20,
              left: k20Padding,
              child: IconWithTextRow(
                actionIcon: BipHip.gift,
                actionText: "Received 42 Gift",
                iconColor: cAmberColor,
                iconSize: kIconSize24,
                actionTextStyle: semiBold18TextStyle(cWhiteColor),
                actionOnPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomstoryView extends StatelessWidget {
  const CustomstoryView({super.key, required this.userName, required this.userImage, required this.storyUploadTime});
  final String userName;
  final String userImage;
  final String storyUploadTime;
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(child: Image.network(userImage, width: h36, height: h36, fit: BoxFit.cover)),
          SizedBox(
            height: h36,
            child: Row(
              children: [
                kW8sizedBox,
                Text(userName, style: semiBold18TextStyle(cWhiteColor)),
                kW8sizedBox,
                Text(storyUploadTime, style: regular14TextStyle(cWhiteColor)),
              ],
            ),
          ),
          // const Spacer(),
          // const SizedBox(),
          SizedBox(
            height: h36,
            child: Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    BipHip.system,
                    color: cWhiteColor,
                    size: kIconSize20,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    BipHip.cross,
                    color: cWhiteColor,
                    size: kIconSize20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
