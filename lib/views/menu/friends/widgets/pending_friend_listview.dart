import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/shimmers/menu/friends/all_pending_friend_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/friends/widgets/pending_friend_action_content.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';
import 'package:flutter/rendering.dart';

class PendingFriendListView extends StatelessWidget {
  PendingFriendListView({super.key});
  final FriendController friendController = Get.find<FriendController>();
  final GlobalController globalController = Get.find<GlobalController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => friendController.isSendFriendRequestListLoading.value
          ? const AllPendingFriendShimmer()
          : friendController.sendFriendRequestList.isNotEmpty
              ? NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (friendController.sendFriendListScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                        scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                        !friendController.sendFriendListScrolled.value) {
                      friendController.sendFriendListScrolled.value = true;
                      if (friendController.sendFriendRequestList.isNotEmpty) {
                        friendController.getMoreSendFriendRequestList(null);
                      }
                      return true;
                    }
                    return false;
                  },
                  child: Expanded(
                    child: SingleChildScrollView(
                      controller: friendController.sendFriendListScrollController,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: k20Padding, vertical: k4Padding).copyWith(bottom: k0Padding),
                            child: ListView.separated(
                              itemCount: friendController.sendFriendRequestList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) => kH16sizedBox,
                              itemBuilder: (context, index) {
                                return ClipRRect(
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
                                          friendController.sendFriendRequestList[index].profilePicture.toString(),
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Image.asset(kiProfileDefaultImageUrl);
                                          },
                                          loadingBuilder: imageLoadingBuilder,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      friendController.sendFriendRequestList[index].fullName ?? ksNA.tr,
                                      style: semiBold16TextStyle(cBlackColor),
                                    ),
                                    trailing: CustomIconButton(
                                        onPress: () {
                                          friendController.pendingFriendActionSelect.value = '';
                                          friendController.pendingFriendFollowStatus.value = friendController.sendFriendRequestList[index].followStatus!;
                                          if (friendController.pendingFriendActionSelect.value == '') {
                                            friendController.pendingFriendActionBottomSheetRightButtonState.value = false;
                                          } else {
                                            friendController.pendingFriendActionBottomSheetRightButtonState.value = true;
                                          }
                                          globalController.commonBottomSheet(
                                            context: context,
                                            isBottomSheetRightButtonActive: friendController.pendingFriendActionBottomSheetRightButtonState,
                                            isScrollControlled: true,
                                            content: PendingFriendActionContent(
                                              friendController: friendController,
                                            ),
                                            onPressCloseButton: () {
                                              Get.back();
                                            },
                                            onPressRightButton: () async {
                                              friendController.userId.value = friendController.sendFriendRequestList[index].id!;
                                              Get.back();
                                              if (friendController.pendingFriendActionSelect.value == 'Cancel Request') {
                                                await friendController.cancelFriendRequest();
                                              }
                                              if (friendController.pendingFriendActionSelect.value == 'Unfollow') {
                                                await friendController.unfollowUser();
                                              }
                                              if (friendController.pendingFriendActionSelect.value == 'Follow') {
                                                await friendController.followUser();
                                              }
                                              friendController.pendingFriendActionSelect.value = '';
                                            },
                                            rightText: ksDone.tr,
                                            rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                                            title: ksAction.tr,
                                            isRightButtonShow: true,
                                            bottomSheetHeight: 200,
                                          );
                                        },
                                        icon: BipHip.system),
                                  ),
                                );
                              },
                            ),
                          ),
                          if (friendController.sendFriendRequestList.isNotEmpty &&
                              friendController.sendFriendListScrolled.value &&
                              friendController.sendFriendListSubLink.value != null)
                            const Center(child: CircularProgressIndicator()),
                        ],
                      ),
                    ),
                  ),
                )
              : Expanded(child: EmptyView(title: ksNoFriendRequestSendYet.tr)),
    );
  }
}
