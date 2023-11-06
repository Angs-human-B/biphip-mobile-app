import 'dart:async';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/friends/friend_widgets/all_friend_listview.dart';
import 'package:bip_hip/views/menu/friends/friend_widgets/pending_friend_listview.dart';
import 'package:bip_hip/views/menu/friends/friend_widgets/received_friend_listview.dart';

class FriendHelper {
  final ProfileController _profileController = Get.find<ProfileController>();
  final FriendController _friendController = Get.find<FriendController>();
  //*friends page list data show
  StatelessWidget allReceivedPendingFriendsView() {
    if (_profileController.tapAbleButtonState[0] == true) {
      return AllFriendListView();
    } else if (_profileController.tapAbleButtonState[1] == true) {
      return ReceivedFriendListView();
    } else {
      return PendingFriendListView();
    }
  }

  //*pending friend selected action color
  Color pendingFriendItemColor(int index) {
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

  //* Friend page tapable button reset
  void friendTapableButtonReset() {
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

  //*All and Received friend count value show
  Widget totalFriendCountShow() {
    if (_profileController.tapAbleButtonState[0]) {
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

  //*All Friend Action on changed
  void allFriendActionOnChanged() {
    if (_friendController.allFriendFollowStatus.value == 1) {
      for (int i = 0; i < _profileController.friendActionList.length; i++) {
        _profileController.friendActionSelect.value = _profileController.friendActionList[i]['action'];
      }
    } else if (_friendController.allFriendFollowStatus.value == 0) {
      for (int i = 0; i < _friendController.friendFollowActionList.length; i++) {
        _profileController.friendActionSelect.value = _friendController.friendFollowActionList[i]['action'];
      }
    }
  }

  //*Pending Friend Action on changed
  void pendingFriendActionOnChanged() {
    if (_friendController.pendingFriendFollowStatus.value == 1) {
      for (int i = 0; i < _friendController.pendingFriendActionList.length; i++) {
        _friendController.pendingFriendActionSelect.value = _friendController.pendingFriendActionList[i]['action'];
      }
    } else if (_friendController.pendingFriendFollowStatus.value == 0) {
      for (int i = 0; i < _friendController.pendingFollowFriendActionList.length; i++) {
        _friendController.pendingFriendActionSelect.value = _friendController.pendingFollowFriendActionList[i]['action'];
      }
    }
  }

  //*all friend selected action color
  Color allFriendItemColor(int index) {
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
}
