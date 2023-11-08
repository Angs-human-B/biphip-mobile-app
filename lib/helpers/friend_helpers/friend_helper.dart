import 'dart:async';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/friends/friend_widgets/all_friend_listview.dart';
import 'package:bip_hip/views/menu/friends/friend_widgets/pending_friend_listview.dart';
import 'package:bip_hip/views/menu/friends/friend_widgets/received_friend_listview.dart';

class FriendHelper {
  final ProfileController _profileController = Get.find<ProfileController>();
  final GlobalController _globalController = Get.find<GlobalController>();
  final FriendController _friendController = Get.find<FriendController>();
  
  //*friends page tapable button views
  StatelessWidget allReceivedPendingFriendsView() {
    if (_globalController.tapAbleButtonState[0] == true) {
      return AllFriendListView();
    } else if (_globalController.tapAbleButtonState[1] == true) {
      return ReceivedFriendListView();
    } else {
      return PendingFriendListView();
    }
  }

  //* Friend page tapable button reset
  void friendSearchFieldReset() {
    _profileController.searchController.clear();
    _friendController.isFriendSuffixIconVisible.value = false;
    _friendController.isFriendSearched.value = false;
  }

  //*Friend text field on change
  void friendOnChanged() async {
    if (_friendController.debounce?.isActive ?? false) _friendController.debounce!.cancel();
    if (Get.find<ProfileController>().searchController.text.trim() != '') {
      _friendController.isFriendSuffixIconVisible.value = true;
      _friendController.debounce = Timer(const Duration(milliseconds: 3000), () async {
        _friendController.isFriendSearched.value = true;
        await _friendController.getFriendSearchList();
      });
    } else {
      _friendController.isFriendSuffixIconVisible.value = false;
      _friendController.isFriendSearched.value = false;
      await _friendController.getFriendList();
    }
  }

  //*All and Received friend count value show
  Widget totalFriendCountShow() {
    if (_globalController.tapAbleButtonState[0]) {
      if (_friendController.allFriendCount.value == 0 || (_friendController.isFriendSearched.value && _friendController.searchedFriendCount.value == 0)) {
        return const SizedBox();
      } else {
        if (_friendController.isFriendSearched.value) {
          return Text('${ksSearchedFriends.tr}: ${_friendController.searchedFriendCount.value}',
              style: semiBold14TextStyle(
                cBlackColor,
              ));
        } else {
          return Text('${ksTotalFriends.tr}: ${_friendController.allFriendCount.value}', style: semiBold14TextStyle(cBlackColor));
        }
      }
    } else {
      if (_friendController.receivedRequestCount.value == 0) {
        return const SizedBox();
      } else {
        return Text(
          '${ksFriendRequests.tr}: ${_friendController.receivedRequestCount.value}',
          style: semiBold14TextStyle(cBlackColor),
        );
      }
    }
  }

  void allFriendTapableButtOnPressed() async {
    _globalController.toggleType(0);
    friendSearchFieldReset();
    await _friendController.getFriendList();
  }

  void receivedFriendTapableButtOnPressed() async {
    _globalController.toggleType(1);
    friendSearchFieldReset();
    await _friendController.getReceivedFriendList();
  }

  void pendingFriendTapableButtOnPressed() async {
    _globalController.toggleType(2);
    friendSearchFieldReset();
    await _friendController.getSendFriendRequestList();
  }

  void friendSuffixPressed() async {
    friendSearchFieldReset();
    if (_friendController.debounce?.isActive ?? false) _friendController.debounce!.cancel();
    await _friendController.getFriendList();
  }

  //*Add Friend
  void addFriendSuffixPressed() {
    _profileController.searchController.clear();
    _friendController.isFriendSuffixIconVisible.value = false;
    _friendController.addFriendRequestList.clear();
  }

  void addFriendBackButtonPressed() {
    friendSearchFieldReset();
    if (_friendController.debounce?.isActive ?? false) _friendController.debounce!.cancel();
    Get.back();
  }

  void addFriendOnPressed({required int index}) async {
    _friendController.userId.value = _friendController.addFriendRequestList[index].id!;
    if (_friendController.addFriendRequestList[index].friendStatus == 0) {
      await _friendController.sendFriendRequest();
    } else if (_friendController.addFriendRequestList[index].friendStatus == 2) {
      await _friendController.cancelFriendRequest();
    }
  }

  //*Add friend text field on change
  void addFriendOnChanged() async {
    if (_friendController.debounce?.isActive ?? false) _friendController.debounce!.cancel();
    if (_profileController.searchController.text.trim() != '') {
      _friendController.isFriendSuffixIconVisible.value = true;
      _friendController.debounce = Timer(const Duration(milliseconds: 3000), () async {
        await _friendController.getAddFriendRequestList();
      });
    }
    if (_profileController.searchController.text.trim() == '') {
      _friendController.isFriendSuffixIconVisible.value = false;
      _friendController.addFriendRequestList.clear();
    }
  }

  //* All Friend Action
  void allFriendActionOnChanged({required int index}) {
    if (_friendController.allFriendFollowStatus.value == 1) {
      _profileController.friendActionSelect.value = _profileController.friendActionList[index]['action'];
    } else if (_friendController.allFriendFollowStatus.value == 0) {
      _profileController.friendActionSelect.value = _friendController.friendFollowActionList[index]['action'];
    }
  }

  Color allFriendItemColor({required int index}) {
    if (_friendController.allFriendFollowStatus.value == 1) {
      if (_profileController.friendActionSelect.value == _profileController.friendActionList[index]['action']) {
        return cPrimaryTint3Color;
      }
    } else {
      if (_profileController.friendActionSelect.value == _friendController.friendFollowActionList[index]['action']) {
        return cPrimaryTint3Color;
      }
    }
    return cWhiteColor;
  }

  void allFriendActionOnPressed({required int index}) {
    if (_friendController.allFriendFollowStatus.value == 1) {
      _profileController.friendActionSelect.value = _profileController.friendActionList[index]['action'];
    } else if (_friendController.allFriendFollowStatus.value == 0) {
      _profileController.friendActionSelect.value = _friendController.friendFollowActionList[index]['action'];
    }
    if (_profileController.friendActionSelect.value == '') {
      Get.find<GlobalController>().isBottomSheetRightButtonActive.value = false;
    } else {
      Get.find<GlobalController>().isBottomSheetRightButtonActive.value = true;
    }
  }

  //*Pending Friend Action
  void pendingFriendActionOnChanged({required int index}) {
    if (_friendController.pendingFriendFollowStatus.value == 1) {
      _friendController.pendingFriendActionSelect.value = _friendController.pendingFriendActionList[index]['action'];
    } else if (_friendController.pendingFriendFollowStatus.value == 0) {
      _friendController.pendingFriendActionSelect.value = _friendController.pendingFollowFriendActionList[index]['action'];
    }
  }

  Color pendingFriendItemColor({required int index}) {
    if (_friendController.pendingFriendFollowStatus.value == 1) {
      if (_friendController.pendingFriendActionSelect.value == _friendController.pendingFriendActionList[index]['action']) {
        return cPrimaryTint3Color;
      }
    } else {
      if (_friendController.pendingFriendActionSelect.value == _friendController.pendingFollowFriendActionList[index]['action']) {
        return cPrimaryTint3Color;
      }
    }
    return cWhiteColor;
  }

  void pendingFriendOnPressed({required int index}) {
    if (_friendController.pendingFriendFollowStatus.value == 1) {
      _friendController.pendingFriendActionSelect.value = _friendController.pendingFriendActionList[index]['action'];
    } else if (_friendController.pendingFriendFollowStatus.value == 0) {
      _friendController.pendingFriendActionSelect.value = _friendController.pendingFollowFriendActionList[index]['action'];
    }
    if (_friendController.pendingFriendActionSelect.value == '') {
      Get.find<GlobalController>().isBottomSheetRightButtonActive.value = false;
    } else {
      Get.find<GlobalController>().isBottomSheetRightButtonActive.value = true;
    }
  }
}
