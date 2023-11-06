import 'dart:async';

import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/friends/friend_widgets/all_friend_listview.dart';
import 'package:bip_hip/views/menu/friends/friend_widgets/pending_friend_listview.dart';
import 'package:bip_hip/views/menu/friends/friend_widgets/received_friend_listview.dart';

class FriendHelper{
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
}