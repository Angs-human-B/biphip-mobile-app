
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class AllFriendActionContent extends StatelessWidget {
  const AllFriendActionContent({
    Key? key,
    required this.profileController,
    required this.friendController,
  }) : super(key: key);

  final ProfileController profileController;
  final FriendController friendController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: profileController.friendActionList.length,
          itemBuilder: (BuildContext context, int index) {
            return Obx(
              () => Padding(
                padding: const EdgeInsets.only(bottom: k8Padding),
                child: CustomListTile(
                  leading: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: cNeutralColor,
                    ),
                    height: h28,
                    width: h28,
                    child: Icon(
                      friendController.allFriendFollowStatus.value == 1
                          ? profileController.friendActionList[index]['icon']
                          : friendController.friendFollowActionList[index]['icon'],
                      color: cBlackColor,
                      size: isDeviceScreenLarge() ? h18 : h14,
                    ),
                  ),
                  title: friendController.allFriendFollowStatus.value == 1
                      ? profileController.friendActionList[index]['action']
                      : friendController.friendFollowActionList[index]['action'],
                  titleTextStyle: semiBold16TextStyle(cBlackColor),
                  subtitle: friendController.allFriendFollowStatus.value == 1
                      ? profileController.friendActionList[index]['actionSubtitle']
                      : friendController.friendFollowActionList[index]['actionSubtitle'],
                  subTitleTextStyle: regular14TextStyle(cBlackColor),
                  trailing: CustomRadioButton(
                    onChanged: () {
                      if (friendController.allFriendFollowStatus.value == 1) {
                        profileController.friendActionSelect.value = profileController.friendActionList[index]['action'];
                      } else if (friendController.allFriendFollowStatus.value == 0) {
                        profileController.friendActionSelect.value = friendController.friendFollowActionList[index]['action'];
                      }
                    },
                    isSelected: friendController.allFriendFollowStatus.value == 1
                        ? (profileController.friendActionSelect.value == profileController.friendActionList[index]['action'])
                        : profileController.friendActionSelect.value == friendController.friendFollowActionList[index]['action'],
                  ),
                  itemColor: friendController.allFriendFollowStatus.value == 1
                      ? (profileController.friendActionSelect.value == profileController.friendActionList[index]['action'] ? cPrimaryTint3Color : cWhiteColor)
                      : (profileController.friendActionSelect.value == friendController.friendFollowActionList[index]['action']
                          ? cPrimaryTint3Color
                          : cWhiteColor),
                  onPressed: () {
                    if (friendController.allFriendFollowStatus.value == 1) {
                      profileController.friendActionSelect.value = profileController.friendActionList[index]['action'];
                    } else if (friendController.allFriendFollowStatus.value == 0) {
                      profileController.friendActionSelect.value = friendController.friendFollowActionList[index]['action'];
                    }
                    if (profileController.friendActionSelect.value == '') {
                      Get.find<GlobalController>().isBottomSheetRightButtonActive.value = false;
                    } else {
                      Get.find<GlobalController>().isBottomSheetRightButtonActive.value = true;
                    }
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}