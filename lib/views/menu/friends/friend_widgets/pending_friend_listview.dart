import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/shimmer_views/friends/all_pending_friend_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/friends/friend_widgets/pending_friend_action_content.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';
import 'package:flutter/rendering.dart';

class PendingFriendListView extends StatelessWidget {
  PendingFriendListView({super.key});
  final FriendController _friendController = Get.find<FriendController>();
  final GlobalController _globalController = Get.find<GlobalController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _friendController.isSendFriendRequestListLoading.value
          ? const AllPendingFriendShimmer()
          : _friendController.sendFriendRequestList.isNotEmpty
              ? NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (_friendController.sendFriendListScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                        scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                        !_friendController.sendFriendListScrolled.value) {
                      _friendController.sendFriendListScrolled.value = true;
                      if (_friendController.sendFriendRequestList.isNotEmpty) {
                        _friendController.getMoreSendFriendRequestList(null);
                      }
                      return true;
                    }
                    return false;
                  },
                  child: Expanded(
                    child: SingleChildScrollView(
                      controller: _friendController.sendFriendListScrollController,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: k20Padding, vertical: k4Padding).copyWith(bottom: k0Padding),
                            child: ListView.builder(
                              itemCount: _friendController.sendFriendRequestList.length,
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
                                            Environment.imageBaseUrl + _friendController.sendFriendRequestList[index].profilePicture.toString(),
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Image.asset(kiProfileDefaultImageUrl);
                                            },
                                            loadingBuilder: imageLoadingBuilder,
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        _friendController.sendFriendRequestList[index].fullName ?? ksNA.tr,
                                        style: semiBold16TextStyle(cBlackColor),
                                      ),
                                      trailing: CustomIconButton(
                                          onPress: () {
                                            _friendController.pendingFriendActionSelect.value = '';
                                            _friendController.pendingFriendFollowStatus.value = _friendController.sendFriendRequestList[index].followStatus!;
                                            if (_friendController.pendingFriendActionSelect.value == '') {
                                              _globalController.isBottomSheetRightButtonActive.value = false;
                                            } else {
                                              _globalController.isBottomSheetRightButtonActive.value = true;
                                            }
                                            _globalController.commonBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              content: PendingFriendActionContent(
                                                friendController: _friendController,
                                              ),
                                              onPressCloseButton: () {
                                                Get.back();
                                              },
                                              onPressRightButton: () async {
                                                _friendController.userId.value = _friendController.sendFriendRequestList[index].id!;
                                                Get.back();
                                                if (_friendController.pendingFriendActionSelect.value == 'Cancel Request') {
                                                  await _friendController.cancelFriendRequest();
                                                }
                                                if (_friendController.pendingFriendActionSelect.value == 'Unfollow') {
                                                  await _friendController.unfollowUser();
                                                }
                                                if (_friendController.pendingFriendActionSelect.value == 'Follow') {
                                                  await _friendController.followUser();
                                                }
                                                _friendController.pendingFriendActionSelect.value = '';
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
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Expanded(child: EmptyView(title: ksNoFriendRequestSendYet.tr)),
    );
  }
}



