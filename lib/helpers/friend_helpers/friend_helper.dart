
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/friends/friend_widgets/all_friend_listview.dart';
import 'package:bip_hip/views/menu/friends/friends.dart';

class FriendHelper{
  final ProfileController _profileController = Get.find<ProfileController>();
    //*friends page list data show
  StatelessWidget allReceivedPendingFriendsView() {
    if (_profileController.tapAbleButtonState[0] == true) {
      return AllFriendListView();
    } else if (_profileController.tapAbleButtonState[1] == true) {
      return ReceivedFriendList();
    } else {
      return PendingFriendList();
    }
  }
}