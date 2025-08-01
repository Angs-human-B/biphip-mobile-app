import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/helpers/menu/friend/friend_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class PendingFriendActionContent extends StatelessWidget {
  PendingFriendActionContent({
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
          itemCount: friendController.pendingFriendActionList.length,
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
                      friendController.pendingFriendFollowStatus.value == 1
                          ? friendController.pendingFriendActionList[index]['icon']
                          : friendController.pendingFollowFriendActionList[index]['icon'],
                      color: cBlackColor,
                      size: isDeviceScreenLarge() ? h18 : h14,
                    ),
                  ),
                  title: friendController.pendingFriendFollowStatus.value == 1
                      ? friendController.pendingFriendActionList[index]['action'].toString().tr
                      : friendController.pendingFollowFriendActionList[index]['action'].toString().tr,
                  titleTextStyle: semiBold16TextStyle(cBlackColor),
                  subtitle: friendController.pendingFriendFollowStatus.value == 1
                      ? friendController.pendingFriendActionList[index]['actionSubtitle'].toString().tr
                      : friendController.pendingFollowFriendActionList[index]['actionSubtitle'].toString().tr,
                  subTitleTextStyle: regular14TextStyle(cBlackColor),
                  trailing: CustomRadioButton(
                    onChanged: () {
                      friendHelper.pendingFriendActionOnChanged(index: index);
                    },
                    isSelected: friendController.pendingFriendFollowStatus.value == 1
                        ? (friendController.pendingFriendActionSelect.value == friendController.pendingFriendActionList[index]['action'])
                        : (friendController.pendingFriendActionSelect.value == friendController.pendingFollowFriendActionList[index]['action']),
                  ),
                  itemColor: friendHelper.pendingFriendItemColor(index: index),
                  onPressed: () {
                    friendHelper.pendingFriendOnPressed(index: index);
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
