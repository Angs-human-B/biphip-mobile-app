import 'package:bip_hip/utils/constants/imports.dart';

class FriendFamilyController extends GetxController {
  final RxList pendingFriendActionList = RxList([
    {'icon': BipHip.minusNew, 'action': 'Cancel Request', 'actionSubtitle': 'Anyone or off BipHip'},
    {'icon': BipHip.unFollow, 'action': 'Unfollow', 'actionSubtitle': 'Your Friend on BipHip'}
  ]);
  final RxString pendingFriendActionSelect = RxString('');
}
