import 'package:bip_hip/utils/constants/imports.dart';

class FriendFamilyController extends GetxController {
  final RxList pendingFriendActionList = RxList([
    {'icon': BipHip.cancelRequest, 'action': 'Cancel Request', 'actionSubtitle': 'The request will be cancelled'},
    {'icon': BipHip.unFollow, 'action': 'Unfollow', 'actionSubtitle': 'Unfollow this user'}
  ]);
  final RxString pendingFriendActionSelect = RxString('');
}
