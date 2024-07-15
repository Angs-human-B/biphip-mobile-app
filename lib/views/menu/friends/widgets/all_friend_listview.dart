import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/profile_view/profile_view_controller.dart';
import 'package:bip_hip/shimmers/menu/friends/all_pending_friend_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/family/add_family.dart';
import 'package:bip_hip/views/menu/friends/widgets/all_friend_action_content.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';
import 'package:flutter/rendering.dart';

class AllFriendListView extends StatelessWidget {
  AllFriendListView({super.key});
  final FriendController friendController = Get.find<FriendController>();
  final GlobalController globalController = Get.find<GlobalController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (friendController.isFriendListLoading.value)
          ? const AllPendingFriendShimmer()
          : friendController.friendList.isNotEmpty
              ? NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (friendController.friendListScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                        scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                        !friendController.friendListScrolled.value) {
                      friendController.friendListScrolled.value = true;
                      if (friendController.friendList.isNotEmpty) {
                        friendController.getMoreFriendList(null);
                      }
                      if (friendController.friendList.isNotEmpty && friendController.isFriendSearched.value) {
                        friendController.getMoreFriendSearchList(null);
                      }
                      return true;
                    }
                    return false;
                  },
                  child: Expanded(
                    child: SingleChildScrollView(
                      controller: friendController.friendListScrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                            child: ListView.separated(
                              itemCount: friendController.friendList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) => kH16sizedBox,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    Get.toNamed(krProfileView);
                                    Get.find<ProfileViewController>().userName.value = friendController.friendList[index].userName!;
                                    await Get.find<ProfileViewController>().getProfileOverview();
                                    await Get.find<ProfileViewController>().getProfileViewPostList();
                                    await Get.find<ProfileViewController>().getProfileViewFriend();
                                    // await Get.find<FamilyController>().getFamilyList();
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(k8BorderRadius),
                                    child: CustomListTile(
                                      padding: const EdgeInsets.only(left: k8Padding, top: k8Padding, bottom: k8Padding),
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
                                            friendController.friendList[index].profilePicture.toString(),
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Image.asset(kiProfileDefaultImageUrl);
                                            },
                                            loadingBuilder: imageLoadingBuilder,
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        friendController.friendList[index].fullName ?? ksNA.tr,
                                        style: semiBold16TextStyle(cBlackColor),
                                      ),
                                      trailing: CustomIconButton(
                                          onPress: () {
                                            friendController.familyRelationStatus.value = friendController.friendList[index].familyRelationStatus;
                                            unFocus(context);
                                            friendController.friendActionSelect.value = '';
                                            friendController.allFriendFollowStatus.value = friendController.friendList[index].followStatus!;
                                            if (friendController.friendActionSelect.value == '') {
                                              friendController.friendActionBottomSheetRightButtonState.value = false;
                                            } else {
                                              friendController.friendActionBottomSheetRightButtonState.value = true;
                                            }
                                            globalController.commonBottomSheet(
                                              context: context,
                                              isBottomSheetRightButtonActive: friendController.friendActionBottomSheetRightButtonState,
                                              isScrollControlled: true,
                                              content: AllFriendActionContent(
                                                friendController: friendController,
                                              ),
                                              onPressCloseButton: () {
                                                Get.back();
                                              },
                                              onPressRightButton: () async {
                                                friendController.userId.value = friendController.friendList[index].id!;
                                                Get.back();
                                                if (friendController.friendActionSelect.value == 'Unfriend') {
                                                  await friendController.unfriendUserRequest();
                                                }
                                                if (friendController.friendActionSelect.value == 'Unfollow') {
                                                  await friendController.unfollowUser();
                                                }
                                                if (friendController.friendActionSelect.value == 'Follow') {
                                                  await friendController.followUser();
                                                }
                                                if (friendController.friendActionSelect.value == 'Add Family') {
                                                  Get.find<FamilyController>().clearAddFamilyData();
                                                  Get.find<FamilyController>().isRouteFromAllFriend.value = true;
                                                  Get.find<FamilyController>().userId.value = friendController.friendList[index].id!;
                                                  Get.to(() => AddFamily(
                                                        name: friendController.friendList[index].fullName,
                                                        profilePicture: friendController.friendList[index].profilePicture,
                                                      ));
                                                }
                                                friendController.friendActionSelect.value = '';
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
                          if (friendController.friendList.isNotEmpty &&
                              friendController.friendListScrolled.value &&
                              friendController.friendListSubLink.value != null)
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
                          child: EmptyView(title: friendController.allFriendCount.value == 0 ? ksNoFriendAddedYet.tr : ksNoSearchedFriendsAvailable.tr)))),
    );
  }
}
