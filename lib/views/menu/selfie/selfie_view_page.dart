import 'package:bip_hip/controllers/home/selfie_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/widgets/post_upper_container.dart';
import 'package:story_view/story_view.dart';

class SelfieViewPage extends StatelessWidget {
  SelfieViewPage({super.key});
  final SelfieController selfieController = Get.find<SelfieController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Obx(
          () => Stack(
            children: [
              StoryView(
                //  selfieController.stories,
                storyItems: selfieController.addStoryItems(selfieController.allSelfieList[selfieController.allSelfieListIndex.value]["selfies"]),
                controller: selfieController.storyController,
                inline: false,
                repeat: false,

                onStoryShow: (storyItem, index) {
                  // final index = selfieController.storyItems.indexOf(storyItem);
                  ll(index);
                },
                // onComplete: () {
                //   int currentIndex = selfieController.allSelfieListIndex.value;
                //   if (currentIndex < selfieController.allSelfieList.length - 1) {
                //     selfieController.allSelfieListIndex.value++;
                //     selfieController.addStoryItems(
                //       selfieController.allSelfieList[currentIndex + 1]["selfies"],
                //     );
                //   } else {
                //     Get.back();
                //   }
                // },
                // onComplete: () {
                //   int currentIndex = selfieController.allSelfieListIndex.value;

                //   if (currentIndex < selfieController.allSelfieList.length - 1) {
                //     // Move to the next index
                //     selfieController.allSelfieListIndex.value++;

                //     // Show the selfies at the next index
                //     selfieController.showSelfiesAtIndex(currentIndex + 1);
                //   } else {
                //     // Navigate back when there are no more selfies to show
                //     Get.back();

                //     // Reset the index to 0
                //     selfieController.allSelfieListIndex.value = 0;

                //     // Show the selfies at the initial index (0)
                //     // selfieController.showSelfiesAtIndex(0);
                //   }
                // },
                onComplete: () {
                  int currentIndex = selfieController.allSelfieListIndex.value;
                  if (currentIndex < selfieController.allSelfieList.length - 1) {
                    selfieController.allSelfieListIndex.value++;
                    selfieController.addStoryItems(
                      selfieController.allSelfieList[currentIndex + 1]["selfies"],
                    );
                  } else {
                    Get.back();
                    selfieController.allSelfieListIndex.value = 0;
                  }
                },
//                 onComplete: () {
//   int currentIndex = selfieController.allSelfieListIndex.value;

//   if (currentIndex < selfieController.allSelfieList.length - 1) {
//     // Next selfie set exists
//     selfieController.allSelfieListIndex.value++;
//     selfieController.addStoryItems(
//       selfieController.allSelfieList[currentIndex + 1]["selfies"],
//     );
//     selfieController.playNextSelfieSet(); // Start playing the next selfie set automatically
//   } else {
//     // No more selfie sets, navigate back
//     Get.back();
//     selfieController.allSelfieListIndex.value = 0;
//   }
// },

                progressPosition: ProgressPosition.top,
                indicatorHeight: IndicatorHeight.medium,
              ),
              Positioned(
                  top: 80,
                  left: 20,
                  child: CustomstoryView(
                      userImage: selfieController.allSelfieList[selfieController.allSelfieListIndex.value]["userImage"].toString(),
                      userName: selfieController.allSelfieList[selfieController.allSelfieListIndex.value]["userName"].toString(),
                      storyUploadTime: "Just now")),
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
