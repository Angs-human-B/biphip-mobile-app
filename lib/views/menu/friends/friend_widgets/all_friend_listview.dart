import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/shimmer_views/friends/all_pending_friend_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';
import 'package:flutter/rendering.dart';

class AllFriendListView extends StatelessWidget {
  AllFriendListView({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();
  final FriendController _friendController = Get.find<FriendController>();
  final GlobalController _globalController = Get.find<GlobalController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (_friendController.isFriendListLoading.value)
          ? const AllPendingFriendShimmer()
          : _friendController.friendList.isNotEmpty
              ? NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (_friendController.friendListScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                        scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                        !_friendController.friendListScrolled.value) {
                      _friendController.friendListScrolled.value = true;
                      if (_friendController.friendList.isNotEmpty) {
                        _friendController.getMoreFriendList(null);
                      }
                      if (_friendController.friendList.isNotEmpty && _friendController.isFriendSearched.value) {
                        _friendController.getMoreFriendSearchList(null);
                      }
                      return true;
                    }
                    return false;
                  },
                  child: Expanded(
                    child: SingleChildScrollView(
                      controller: _friendController.friendListScrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                            child: ListView.builder(
                              itemCount: _friendController.friendList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: k12Padding),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(k8BorderRadius),
                                    child: CustomListTile(
                                      padding: const EdgeInsets.symmetric(horizontal: k8Padding, vertical: k8Padding).copyWith(right: k0Padding),
                                      borderColor: cLineColor,
                                      leading: Container(
                                        height: h40,
                                        width: h40,
                                        decoration: const BoxDecoration(
                                          color: cWhiteColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: ClipOval(
                                          child: Image.network(
                                            Environment.imageBaseUrl + _friendController.friendList[index].profilePicture.toString(),
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Image.asset(kiProfileDefaultImageUrl);
                                            },
                                            loadingBuilder: imageLoadingBuilder,
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        _friendController.friendList[index].fullName ?? ksNA.tr,
                                        style: semiBold16TextStyle(cBlackColor),
                                      ),
                                      trailing: CustomIconButton(
                                          onPress: () {
                                            _profileController.friendActionSelect.value = '';
                                            _friendController.allFriendFollowStatus.value = _friendController.friendList[index].followStatus!;
                                            if (_profileController.friendActionSelect.value == '') {
                                              _globalController.isBottomSheetRightButtonActive.value = false;
                                            } else {
                                              _globalController.isBottomSheetRightButtonActive.value = true;
                                            }
                                            _globalController.commonBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              content: _FriendActionContent(
                                                profileController: _profileController,
                                                friendController: _friendController,
                                              ),
                                              onPressCloseButton: () {
                                                Get.back();
                                              },
                                              onPressRightButton: () async {
                                                _friendController.userId.value = _friendController.friendList[index].id!;
                                                Get.back();
                                                if (_profileController.friendActionSelect.value == 'Unfriend') {
                                                  await _friendController.unfriendUserRequest();
                                                }
                                                if (_profileController.friendActionSelect.value == 'Unfollow') {
                                                  await _friendController.unfollowUser();
                                                }
                                                if (_profileController.friendActionSelect.value == 'Follow') {
                                                  await _friendController.followUser();
                                                }
                                                _profileController.friendActionSelect.value = '';
                                              },
                                              rightText: ksDone.tr,
                                              rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                                              title: ksAction.tr,
                                              isRightButtonShow: true,
                                              bottomSheetHeight: 250,
                                            );
                                          },
                                          icon: BipHip.system),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          if (_friendController.friendList.isNotEmpty && !_friendController.friendListScrolled.value)
                            const Center(child: CircularProgressIndicator()),
                        ],
                      ),
                    ),
                  ),
                )
              : Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      child: Container(
                          alignment: Alignment.center,
                          child: EmptyView(title: _friendController.allFriendCount.value == 0 ? ksNoFriendAddedYet.tr : ksNoSearchedFriendsAvailable.tr)))),
    );
  }
}



class _FriendActionContent extends StatelessWidget {
  const _FriendActionContent({
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