import 'dart:async';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/friends/widgets/all_friend_listview.dart';
import 'package:bip_hip/views/menu/friends/widgets/pending_friend_listview.dart';
import 'package:bip_hip/views/menu/friends/widgets/received_friend_listview.dart';

class FriendHelper {
  final GlobalController globalController = Get.find<GlobalController>();
  final FriendController friendController = Get.find<FriendController>();

  //*friends page tapable button views
  Widget friendListView() {
    if (globalController.tapAbleButtonState[0] == true) {
      return AllFriendListView();
    } else if (globalController.tapAbleButtonState[1] == true) {
      return ReceivedFriendListView();
    } else {
      return PendingFriendListView();
    }
  }

  //* Friend page tapable button reset
  void friendSearchFieldReset() {
    globalController.searchController.clear();
    friendController.isFriendSuffixIconVisible.value = false;
    friendController.isFriendSearched.value = false;
  }

  //*Friend text field on change
  void searchFriends() async {
    if (friendController.debounce?.isActive ?? false) friendController.debounce!.cancel();
    if (globalController.searchController.text.trim() != '') {
      friendController.isFriendSuffixIconVisible.value = true;
      friendController.debounce = Timer(const Duration(milliseconds: 3000), () async {
        friendController.isFriendSearched.value = true;
        await friendController.getFriendSearchList();
      });
    } else {
      friendController.isFriendSuffixIconVisible.value = false;
      friendController.isFriendSearched.value = false;
      await friendController.getFriendList();
    }
  }

  //*All and Received friend count value show
  Widget totalFriendCountShow() {
    if (globalController.tapAbleButtonState[0]) {
      if (friendController.allFriendCount.value == 0 || (friendController.isFriendSearched.value && friendController.searchedFriendCount.value == 0)) {
        return const SizedBox();
      } else {
        if (friendController.isFriendSearched.value) {
          return Text('${ksSearchedFriends.tr}: ${friendController.searchedFriendCount.value}',
              style: semiBold14TextStyle(
                cBlackColor,
              ));
        } else {
          return Text('${ksTotalFriends.tr}: ${friendController.allFriendCount.value}', style: semiBold14TextStyle(cBlackColor));
        }
      }
    } else {
      if (friendController.receivedRequestCount.value == 0) {
        return const SizedBox();
      } else {
        return Text(
          '${ksFriendRequests.tr}: ${friendController.receivedRequestCount.value}',
          style: semiBold14TextStyle(cBlackColor),
        );
      }
    }
  }

  void allFriendTapableButtonOnPressed() async {
    globalController.toggleType(0);
    friendSearchFieldReset();
    await friendController.getFriendList();
  }

  void receivedFriendTapableButtonOnPressed() async {
    globalController.toggleType(1);
    friendSearchFieldReset();
    await friendController.getReceivedFriendList();
  }

  void pendingFriendTapableButtonOnPressed() async {
    globalController.toggleType(2);
    friendSearchFieldReset();
    await friendController.getSendFriendRequestList();
  }

  void friendSearchReset() async {
    friendSearchFieldReset();
    if (friendController.debounce?.isActive ?? false) friendController.debounce!.cancel();
    await friendController.getFriendList();
  }

  //*Add Friend
  void resetAddFriend() {
    globalController.searchController.clear();
    friendController.isFriendSuffixIconVisible.value = false;
    friendController.addFriendList.clear();
  }

  void addFriendBackButtonPressed() {
    friendSearchFieldReset();
    if (friendController.debounce?.isActive ?? false) friendController.debounce!.cancel();
    Get.back();
  }

  void addCancelFriendRequest({required int index}) async {
    friendController.userId.value = friendController.addFriendList[index].id!;
    if (friendController.addFriendList[index].friendStatus == 0) {
      await friendController.sendFriendRequest();
    } else if (friendController.addFriendList[index].friendStatus == 2) {
      await friendController.cancelFriendRequest();
    }
  }

  //*Add friend text field on change
  void searchToAddFriend() async {
    if (friendController.debounce?.isActive ?? false) friendController.debounce!.cancel();
    if (globalController.searchController.text.trim() != '') {
      friendController.isFriendSuffixIconVisible.value = true;
      friendController.debounce = Timer(const Duration(milliseconds: 3000), () async {
        await friendController.getAddFriendList();
      });
    }
    if (globalController.searchController.text.trim() == '') {
      friendController.isFriendSuffixIconVisible.value = false;
      friendController.addFriendList.clear();
    }
  }

  //* All Friend Action
  void allFriendActionOnChanged({required int index}) {
    if (friendController.allFriendFollowStatus.value == 1) {
      friendController.friendActionSelect.value = friendController.friendActionList[index]['action'];
    } else if (friendController.allFriendFollowStatus.value == 0) {
      friendController.friendActionSelect.value = friendController.friendFollowActionList[index]['action'];
    }
    if (friendController.friendActionSelect.value == '') {
      Get.find<GlobalController>().isBottomSheetRightButtonActive.value = false;
    } else {
      Get.find<GlobalController>().isBottomSheetRightButtonActive.value = true;
    }
  }

  Color allFriendItemColor({required int index}) {
    if (friendController.allFriendFollowStatus.value == 1) {
      if (friendController.friendActionSelect.value == friendController.friendActionList[index]['action']) {
        return cPrimaryTint3Color;
      }
    } else {
      if (friendController.friendActionSelect.value == friendController.friendFollowActionList[index]['action']) {
        return cPrimaryTint3Color;
      }
    }
    return cWhiteColor;
  }

  void allFriendActionOnPressed({required int index}) {
    if (friendController.allFriendFollowStatus.value == 1) {
      friendController.friendActionSelect.value = friendController.friendActionList[index]['action'];
    } else if (friendController.allFriendFollowStatus.value == 0) {
      friendController.friendActionSelect.value = friendController.friendFollowActionList[index]['action'];
    }
    if (friendController.friendActionSelect.value == '') {
      Get.find<GlobalController>().isBottomSheetRightButtonActive.value = false;
    } else {
      Get.find<GlobalController>().isBottomSheetRightButtonActive.value = true;
    }
  }

  //*Pending Friend Action
  void pendingFriendActionOnChanged({required int index}) {
    if (friendController.pendingFriendFollowStatus.value == 1) {
      friendController.pendingFriendActionSelect.value = friendController.pendingFriendActionList[index]['action'];
    } else if (friendController.pendingFriendFollowStatus.value == 0) {
      friendController.pendingFriendActionSelect.value = friendController.pendingFollowFriendActionList[index]['action'];
    }
    if (friendController.pendingFriendActionSelect.value == '') {
      Get.find<GlobalController>().isBottomSheetRightButtonActive.value = false;
    } else {
      Get.find<GlobalController>().isBottomSheetRightButtonActive.value = true;
    }
  }

  Color pendingFriendItemColor({required int index}) {
    if (friendController.pendingFriendFollowStatus.value == 1) {
      if (friendController.pendingFriendActionSelect.value == friendController.pendingFriendActionList[index]['action']) {
        return cPrimaryTint3Color;
      }
    } else {
      if (friendController.pendingFriendActionSelect.value == friendController.pendingFollowFriendActionList[index]['action']) {
        return cPrimaryTint3Color;
      }
    }
    return cWhiteColor;
  }

  void pendingFriendOnPressed({required int index}) {
    if (friendController.pendingFriendFollowStatus.value == 1) {
      friendController.pendingFriendActionSelect.value = friendController.pendingFriendActionList[index]['action'];
    } else if (friendController.pendingFriendFollowStatus.value == 0) {
      friendController.pendingFriendActionSelect.value = friendController.pendingFollowFriendActionList[index]['action'];
    }
    if (friendController.pendingFriendActionSelect.value == '') {
      Get.find<GlobalController>().isBottomSheetRightButtonActive.value = false;
    } else {
      Get.find<GlobalController>().isBottomSheetRightButtonActive.value = true;
    }
  }
}
