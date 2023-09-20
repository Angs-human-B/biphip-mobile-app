import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile/menu/family.dart';
import 'package:bip_hip/views/profile/menu/friends.dart';

class ProfileController extends GetxController {
  final RxBool isSupportButtonPressed = RxBool(false);
  final RxBool isSettingButtonPressed = RxBool(false);
  final RxInt interestCatagoriesIndex = RxInt(0);
  final RxBool isInterestSelected = RxBool(false);
  
//*For Friends tapable button
  RxBool isAllButtonClickedFriend = RxBool(true);
  RxBool isReceivedButtonClickedFriend = RxBool(false);
  void toggleTypeFriend(int index) {
    if (index == 1) {
      isAllButtonClickedFriend.value = true;
      isReceivedButtonClickedFriend.value = false;
    } else if (index == 2) {
      isReceivedButtonClickedFriend.value = true;
      isAllButtonClickedFriend.value = false;
    } else {
      isAllButtonClickedFriend.value = false;
      isReceivedButtonClickedFriend.value = false;
    }
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
    if (isAllButtonClickedFriend.value == true) {
      return AllFriendList();
    } else if (isReceivedButtonClickedFriend.value == true) {
      return ReceivedFriendList();
    } else {
      return PendingFriendList();
    }
  }

  //*For Family tapable button
  RxBool isAllButtonClickedFamily = RxBool(true);
  RxBool isReceivedButtonClickedFamily = RxBool(false);
  void toggleTypeFamily(int index) {
    if (index == 1) {
      isAllButtonClickedFamily.value = true;
      isReceivedButtonClickedFamily.value = false;
    } else if (index == 2) {
      isReceivedButtonClickedFamily.value = true;
      isAllButtonClickedFamily.value = false;
    } else {
      isAllButtonClickedFamily.value = false;
      isReceivedButtonClickedFamily.value = false;
    }
  }

  //*Family
  RxList allFamilyLists = RxList(friendsList);
  RxList receivedFamilyLists = RxList(friendsList);
  RxList pendingFamilyLists = RxList(friendsList);
  RxList addFamilyLists = RxList(addFriendList);

  //*friends page list data show
  StatelessWidget allReceivedPendingFamilyView() {
    if (isAllButtonClickedFamily.value == true) {
      return AllFamilyList();
    } else if (isReceivedButtonClickedFamily.value == true) {
      return ReceivedFamilyList();
    } else {
      return PendingFamilyList();
    }
  }
}
