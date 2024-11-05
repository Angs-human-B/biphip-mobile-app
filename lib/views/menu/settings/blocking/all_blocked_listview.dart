import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/shimmers/menu/friends/all_pending_friend_shimmer.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/family/add_family.dart';
import 'package:bip_hip/views/menu/friends/widgets/all_friend_action_content.dart';
import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../widgets/common/utils/common_simple_text.dart';

class AllBlockedListview extends StatelessWidget {
  AllBlockedListview({super.key});
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
                            trailing: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    color: cPrimaryTint3Color,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 4.5.h),
                                  child: Normalext(
                                    "Unblock",
                                    weight: FontWeight.bold,
                                    fontSize: 26.sp,
                                  ),
                                ),
                              ),
                            ),
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
