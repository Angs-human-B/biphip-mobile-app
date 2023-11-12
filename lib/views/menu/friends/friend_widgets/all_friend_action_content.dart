import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/helpers/friend_helpers/friend_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class AllFriendActionContent extends StatelessWidget {
  AllFriendActionContent({
    Key? key,
    required this.friendController,
  }) : super(key: key);

  final FriendController friendController;
  final FriendHelper friendHelper = FriendHelper();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: friendController.friendActionList.length,
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
                          ? friendController.friendActionList[index]['icon']
                          : friendController.friendFollowActionList[index]['icon'],
                      color: cBlackColor,
                      size: isDeviceScreenLarge() ? h18 : h14,
                    ),
                  ),
                  title: friendController.allFriendFollowStatus.value == 1
                      ? friendController.friendActionList[index]['action'].toString().tr
                      : friendController.friendFollowActionList[index]['action'].toString().tr,
                  titleTextStyle: semiBold16TextStyle(cBlackColor),
                  subtitle: friendController.allFriendFollowStatus.value == 1
                      ? friendController.friendActionList[index]['actionSubtitle'].toString().tr
                      : friendController.friendFollowActionList[index]['actionSubtitle'].toString().tr,
                  subTitleTextStyle: regular14TextStyle(cBlackColor),
                  trailing: CustomRadioButton(
                    onChanged: () {
                      friendHelper.allFriendActionOnChanged(index: index);
                    },
                    isSelected: friendController.allFriendFollowStatus.value == 1
                        ? (friendController.friendActionSelect.value == friendController.friendActionList[index]['action'])
                        : friendController.friendActionSelect.value == friendController.friendFollowActionList[index]['action'],
                  ),
                  itemColor: friendHelper.allFriendItemColor(index: index),
                  onPressed: () {
                    friendHelper.allFriendActionOnPressed(index: index);
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
