import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/shimmers/menu/friends/received_friend_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';
import 'package:bip_hip/views/menu/friends/widgets/friend_family_button_action.dart';
import 'package:flutter/rendering.dart';

class ReceivedFriendListView extends StatelessWidget {
  ReceivedFriendListView({super.key});
  final FriendController friendController = Get.find<FriendController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => friendController.isReceivedFriendListLoading.value
          ? const ReceivedFriendShimmer()
          : friendController.receivedFriendList.isNotEmpty
              ? NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (friendController.receivedFriendListScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                        scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                        !friendController.receivedFriendListScrolled.value) {
                      friendController.receivedFriendListScrolled.value = true;
                      if (friendController.receivedFriendList.isNotEmpty) {
                        friendController.getMoreReceivedFriendList(null);
                      }
                      return true;
                    }
                    return false;
                  },
                  child: Expanded(
                    child: SingleChildScrollView(
                      controller: friendController.receivedFriendListScrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                            child: ListView.separated(
                              itemCount: friendController.receivedFriendList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) => kH16sizedBox,
                              itemBuilder: (context, index) {
                                return FriendFamilyButtonAction(
                                  backgroundImage: friendController.receivedFriendList[index].profilePicture.toString(),
                                  name: friendController.receivedFriendList[index].fullName ?? ksNA.tr,
                                  firstButtonText: ksConfirm.tr,
                                  secondButtonText: ksCancel.tr,
                                  firstButtonOnPressed: () async {
                                    friendController.userId.value = friendController.receivedFriendList[index].id!;
                                    await friendController.acceptFriendRequest();
                                  },
                                  secondButtonOnPressed: () async {
                                    friendController.userId.value = friendController.receivedFriendList[index].id!;
                                    await friendController.rejectFriendRequest();
                                  },
                                );
                              },
                            ),
                          ),
                          if (friendController.receivedFriendList.isNotEmpty &&
                              friendController.receivedFriendListScrolled.value &&
                              friendController.receivedFriendListSubLink.value != null)
                            const Center(child: CircularProgressIndicator()),
                        ],
                      ),
                    ),
                  ),
                )
              : Expanded(
                  child: Container(alignment: Alignment.center, child: EmptyView(title: ksNoFriendRequestReceivedYet.tr)),
                ),
    );
  }
}
