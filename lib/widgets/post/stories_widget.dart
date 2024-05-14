import 'package:bip_hip/controllers/home/selfie_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class StoriesWidget extends StatelessWidget {
  StoriesWidget({super.key});
  final SelfieController selfieController = Get.find<SelfieController>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: k10Padding),
        child: ListView.builder(
            padding: const EdgeInsets.only(left: k10Padding),
            itemCount:
                selfieController.mySelfieList.isNotEmpty ? 1 + selfieController.friendSelfiesList.length + 1 : selfieController.friendSelfiesList.length + 1,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (index == 0) {
                return StoryCard(
                  isStory: false,
                  storyImage: '',
                  profileImage: Get.find<GlobalController>().userImage.toString(),
                  userName: '',
                  isSeen: false,
                  onPressed: () async {
                    Get.find<SelfieController>().resetSelfieData();
                    await Get.find<GlobalController>().selectImageSource(
                        selfieController.isSelfieImageChanged, selfieController.selfieImageLink, selfieController.selfieImageFile, 'gallery', false, false);
                    if (selfieController.isSelfieImageChanged.value) {
                      Get.toNamed(krSelfiePage);
                    }
                  },
                );
              }
              if (selfieController.mySelfieList.isNotEmpty && index==1) {
                // index = selfieController.mySelfieList.length;
                return StoryCard(
                  isStory: true,
                  storyImage: selfieController.mySelfieList[0].fullPath ?? "",
                  profileImage: Get.find<GlobalController>().userImage.toString(),
                  userName: ksYourSelfie.tr,
                  isSeen: true,
                  onPressed: () {
                    Get.toNamed(krSelfieViewPage);
                  },
                );
              }
              //  if (selfieController.mySelfieList.isNotEmpty) {
              //   return StoryCard(
              //     isStory: true,
              //     storyImage: selfieController.mySelfieList[index].fullPath ?? "",
              //     profileImage: selfieController.friendSelf[index].profilePicture ?? "",
              //     userName: selfieController.friendSelfiesList[index - 2].fullName ?? ksNA.tr,
              //     isSeen: false,
              //     onPressed: () {
              //       Get.toNamed(krSelfieViewPage);
              //     },
              //   );
              // }
              if (selfieController.friendSelfiesList.isNotEmpty && selfieController.mySelfieList.isNotEmpty) {
                return StoryCard(
                  isStory: true,
                  storyImage: selfieController.friendSelfiesList[index - 2].currentSelfies[0].fullPath ?? "",
                  profileImage: selfieController.friendSelfiesList[index - 2].profilePicture ?? "",
                  userName: selfieController.friendSelfiesList[index - 2].fullName ?? ksNA.tr,
                  isSeen: false,
                  onPressed: () {
                    Get.toNamed(krSelfieViewPage);
                  },
                );
              }
              if (selfieController.friendSelfiesList.isNotEmpty && selfieController.mySelfieList.isEmpty) {
                return StoryCard(
                  isStory: true,
                  storyImage: selfieController.friendSelfiesList[index - 1].currentSelfies[0].fullPath ?? "",
                  profileImage: selfieController.friendSelfiesList[index - 1].profilePicture ?? "",
                  userName: selfieController.friendSelfiesList[index - 1].fullName ?? ksNA.tr,
                  isSeen: false,
                  onPressed: () {
                    Get.toNamed(krSelfieViewPage);
                  },
                );
              }
              return const SizedBox();
              // else {
              //   return StoryCard(
              //     isStory: true,
              //     storyImage: allStories[index - 1]['storyImage'],
              //     profileImage: allStories[index - 1]['profileImage'],
              //     userName: allStories[index - 1]['name'],
              //     isSeen: allStories[index - 1]['isSeen'],
              //     onPressed: () {
              //       Get.toNamed(krSelfieViewPage);
              //     },
              //   );
              // }
            }),
      ),
    );
    // SizedBox(
    //   height: 150,
    //   width: width - 120,
    //   child: Padding(
    //     padding: const EdgeInsets.symmetric(vertical: k10Padding),
    //     child: ListView.builder(
    //         padding: const EdgeInsets.only(left: k10Padding),
    //         itemCount: selfieController.friendSelfiesList.length,
    //         shrinkWrap: true,
    //         scrollDirection: Axis.horizontal,
    //         physics: const AlwaysScrollableScrollPhysics(),
    //         itemBuilder: (context, index) {
    //           // int sameIndex = 0;
    //           // if (selfieController.friendSelfiesList[index].id == Get.find<GlobalController>().userId.value) {
    //           //   sameIndex++;
    //           // }
    //           // index = index - sameIndex;
    //           return StoryCard(
    //             isStory: true,
    //             storyImage: selfieController.friendSelfiesList[index].currentSelfies[0].fullPath ?? "",
    //             profileImage: selfieController.friendSelfiesList[index].profilePicture ?? "",
    //             userName: selfieController.friendSelfiesList[index].fullName ?? ksNA.tr,
    //             isSeen: true,
    //             onPressed: () {
    //               Get.toNamed(krSelfieViewPage);
    //             },
    //           );

    //           // if (selfieController.friendSelfiesList.isNotEmpty && selfieController.mySelfieList.isNotEmpty) {
    //           //   return StoryCard(
    //           //     isStory: true,
    //           //     storyImage: selfieController.friendSelfiesList[index - 2].currentSelfies[0].fullPath ?? "",
    //           //     profileImage: selfieController.friendSelfiesList[index - 2].profilePicture ?? "",
    //           //     userName: selfieController.friendSelfiesList[index - 2].fullName ?? ksNA.tr,
    //           //     isSeen: false,
    //           //     onPressed: () {
    //           //       Get.toNamed(krSelfieViewPage);
    //           //     },
    //           //   );
    //           // }
    //           // if (selfieController.friendSelfiesList.isNotEmpty && selfieController.mySelfieList.isEmpty) {
    //           //   return StoryCard(
    //           //     isStory: true,
    //           //     storyImage: selfieController.friendSelfiesList[index - 1].currentSelfies[0].fullPath ?? "",
    //           //     profileImage: selfieController.friendSelfiesList[index - 1].profilePicture ?? "",
    //           //     userName: selfieController.friendSelfiesList[index - 1].fullName ?? ksNA.tr,
    //           //     isSeen: false,
    //           //     onPressed: () {
    //           //       Get.toNamed(krSelfieViewPage);
    //           //     },
    //           //   );
    //           // }
    //           // return const SizedBox();
    //           // else {
    //           //   return StoryCard(
    //           //     isStory: true,
    //           //     storyImage: allStories[index - 1]['storyImage'],
    //           //     profileImage: allStories[index - 1]['profileImage'],
    //           //     userName: allStories[index - 1]['name'],
    //           //     isSeen: allStories[index - 1]['isSeen'],
    //           //     onPressed: () {
    //           //       Get.toNamed(krSelfieViewPage);
    //           //     },
    //           //   );
    //           // }
    //         }),
    //   ),
    // ),

    // ],
    // );
  }
}

class StoryCard extends StatelessWidget {
  const StoryCard(
      {super.key, required this.isStory, required this.storyImage, required this.profileImage, required this.userName, required this.isSeen, this.onPressed});

  final bool isStory;
  final String storyImage;
  final String profileImage;
  final String userName;
  final bool isSeen;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: k8Padding),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 137,
          width: 90,
          decoration: BoxDecoration(borderRadius: k8CircularBorderRadius, border: Border.all(color: cLineColor)),
          child: Stack(
            children: [
              Container(
                height: 137,
                width: 90,
                color: cTransparentColor,
              ),
              if (isStory)
                SizedBox(
                  height: 137,
                  width: 90,
                  child: ClipRRect(
                    borderRadius: k8CircularBorderRadius,
                    child: Image.network(
                      storyImage,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(kiDummyImage1ImageUrl);
                      },
                      loadingBuilder: imageLoadingBuilder,
                    ),
                  ),
                ),
              if (isStory)
                Positioned(
                  top: 8,
                  left: 6,
                  child: Container(
                    // height: h28,
                    // width: h28,
                    decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: isSeen ? cLineColor : cPrimaryColor)),
                    child: ClipOval(
                      child: Image.network(
                        profileImage,
                        fit: BoxFit.cover,
                        height: h32,
                        width: h32,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(kiDummyImage1ImageUrl);
                        },
                        loadingBuilder: smallImageLoadingBuilder,
                      ),
                    ),
                  ),
                ),
              if (!isStory)
                Positioned(
                  top: 0,
                  child: SizedBox(
                    height: 80,
                    width: 90,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(k8BorderRadius),
                        topRight: Radius.circular(k8BorderRadius),
                      ),
                      child: Image.network(
                        profileImage,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(kiDummyImage1ImageUrl);
                        },
                        loadingBuilder: imageLoadingBuilder,
                      ),
                    ),
                  ),
                ),
              if (!isStory)
                Positioned(
                  bottom: 30,
                  left: 28.5,
                  child: Container(
                    height: 33,
                    width: 33,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: cPrimaryColor, border: Border.all(color: cWhiteColor, width: 2)),
                    child: const Icon(
                      BipHip.plus,
                      color: cWhiteColor,
                    ),
                  ),
                ),
              if (!isStory)
                Positioned(
                  left: 32,
                  bottom: 5,
                  child: Text(
                    '${ksAdd.tr}\n${ksSelfie.tr}',
                    textAlign: TextAlign.center,
                    style: semiBold10TextStyle(cBlackColor),
                  ),
                ),
              if (isStory)
                Positioned(
                    bottom: 6,
                    left: 6,
                    child: SizedBox(
                      width: 80,
                      child: Text(
                        userName,
                        overflow: TextOverflow.clip,
                        style: semiBold10TextStyle(cWhiteColor),
                      ),
                    ))
            ],
          ),
        ),
      ),
    );
  }
}
