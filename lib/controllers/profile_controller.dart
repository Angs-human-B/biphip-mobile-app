import 'dart:io';

import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile/menu/family.dart';
import 'package:bip_hip/views/profile/menu/friends.dart';

class ProfileController extends GetxController {
  final RxBool isSupportButtonPressed = RxBool(false);
  final RxBool isSettingButtonPressed = RxBool(false);
  final RxInt interestCatagoriesIndex = RxInt(0);
  final RxBool isInterestSelected = RxBool(false);
  final RxString profileImageLink = RxString('');
  final Rx<File> profileImageFile = File('').obs;
  final RxBool isProfileImageChanged = RxBool(false);
  final RxString coverImageLink = RxString('');
  final Rx<File> coverImageFile = File('').obs;
  final RxBool isCoverImageChanged = RxBool(false);
  final TextEditingController bioEditingController = TextEditingController();
  final RxInt bioCount = 0.obs;
  final RxString bio = RxString('');
  final RxString photoLink = RxString('');

  final RxList tapAbleButtonState = RxList([true, false, false]);
  final RxList tapAbleButtonText = RxList(["All", "Received", "Pending"]);

  //*For tapAble button
  void toggleType(int index) {
    for (int i = 0; i < 3; i++) {
      if (index == i) {
        tapAbleButtonState[i] = true;
      } else {
        tapAbleButtonState[i] = false;
      }
    }
  }

    void resetTapButtonData() {
      tapAbleButtonState.clear();
      tapAbleButtonState.addAll([true, false, false]);
    }

    //*Search
    final TextEditingController searchController = TextEditingController();
    RxBool isCloseIconVisible = RxBool(false);

    //*Friends
    RxList allFriendsLists = RxList(friendsList);
    RxList receivedFriendLists = RxList(friendsList);
    RxList pendingFriendLists = RxList(friendsList);
    RxList addFriendLists = RxList(addFriendList);

    //*friends page list data show
    StatelessWidget allReceivedPendingFriendsView() {
      if (tapAbleButtonState[0] == true) {
        return AllFriendList();
      } else if (tapAbleButtonState[1] == true) {
        return ReceivedFriendList();
      } else {
        return PendingFriendList();
      }
    }

    //*Family
    RxList allFamilyLists = RxList(friendsList);
    RxList receivedFamilyLists = RxList(friendsList);
    RxList pendingFamilyLists = RxList(friendsList);
    RxList addFamilyLists = RxList(addFriendList);

    //*friends page list data show
    StatelessWidget allReceivedPendingFamilyView() {
      if (tapAbleButtonState[0] == true) {
        return AllFamilyList();
      } else if (tapAbleButtonState[1] == true) {
        return ReceivedFamilyList();
      } else {
        return PendingFamilyList();
      }
    }

    void showPictureUploadModalBottomSheet(context, content) {
      showModalBottomSheet(
        backgroundColor: cWhiteColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(k16BorderRadius), topRight: Radius.circular(k16BorderRadius)),
        ),
        context: context,
        builder: (context) {
          return content;
        },
      );
    }

    void clearBio() {
      bioCount.value = 0;
      bioEditingController.clear();
    }
  }
