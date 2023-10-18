import 'package:bip_hip/models/common/common_data_model.dart';
import 'package:bip_hip/models/common/common_error_model.dart';
import 'package:bip_hip/models/friend/friend_list_model.dart';
import 'package:bip_hip/models/friend/received_friend_list_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class FriendController extends GetxController {
  final ApiController _apiController = ApiController();
  final SpController _spController = SpController();
  final GlobalController _globalController = Get.find<GlobalController>();
  //*Scroll controller for pagination
  final ScrollController friendListScrollController = ScrollController();
  //*Friend List Api Call
  Rx<FriendListModel?> friendListData = Rx<FriendListModel?>(null);
  RxList<FriendData> friendList = RxList<FriendData>([]);
  final Rx<String?> friendListSubLink = Rx<String?>(null);
  final RxBool friendListScrolled = RxBool(false);
  final RxBool isFriendListLoading = RxBool(false);
  Future<void> getFriendList() async {
    try {
      isFriendListLoading.value = true;
      String suffixUrl = '?take=15';
      String? token = await _spController.getBearerToken();
      var response = await _apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetFriendList + suffixUrl,
      ) as CommonDM;
      if (response.success == true) {
        friendList.clear();
        friendListScrolled.value = false;
        friendListData.value = FriendListModel.fromJson(response.data);
        friendList.addAll(friendListData.value!.friends!.data);
        friendListSubLink.value = friendListData.value!.friends!.nextPageUrl;
        if (friendListSubLink.value != null) {
          friendListScrolled.value = false;
        } else {
          friendListScrolled.value = true;
        }

        isFriendListLoading.value = false;
      } else {
        isFriendListLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isFriendListLoading.value = false;
      ll('getFriendList error: $e');
    }
  }

  //*Get More Friend List for pagination
  Future<void> getMoreFriendList(take) async {
    try {
      String? token = await _spController.getBearerToken();
      dynamic friendListSub;

      if (friendListSubLink.value == null) {
        return;
      } else {
        friendListSub = friendListSubLink.value!.split('?');
      }

      String friendListSuffixUrl = '';

      friendListSuffixUrl = '?${friendListSub[1]}&take=15';

      var response = await _apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetFriendList + friendListSuffixUrl,
      ) as CommonDM;

      if (response.success == true) {
        friendListData.value = FriendListModel.fromJson(response.data);
        ll(friendListData.value);
        friendList.addAll(friendListData.value!.friends!.data);
        friendListSubLink.value = friendListData.value!.friends!.nextPageUrl;
        if (friendListSubLink.value != null) {
          friendListScrolled.value = false;
        } else {
          friendListScrolled.value = true;
        }

        isFriendListLoading.value = false;
      } else {
        isFriendListLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isFriendListLoading.value = false;
      ll('getFriendList error: $e');
    }
  }

  //*Received Friend List Api Call
  Rx<ReceivedFriendListModel?> receivedFriendListData = Rx<ReceivedFriendListModel?>(null);
  RxList<ReceivedFriendData> receivedFriendList = RxList<ReceivedFriendData>([]);
  // final Rx<String?> friendListSubLink = Rx<String?>(null);
  // final RxBool friendListScrolled = RxBool(false);
  final RxBool isReceivedFriendListLoading = RxBool(false);
  Future<void> getReceivedFriendList() async {
    try {
      isReceivedFriendListLoading.value = true;
      // String suffixUrl = '?take=3';
      String? token = await _spController.getBearerToken();
      var response = await _apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetFriendRequestReceiveList,
      ) as CommonDM;
      if (response.success == true) {
        receivedFriendList.clear();

        receivedFriendListData.value = ReceivedFriendListModel.fromJson(response.data);
        receivedFriendList.addAll(receivedFriendListData.value!.users!.data);
        receivedRequestCount.value = receivedFriendList.length;
        isReceivedFriendListLoading.value = false;
      } else {
        isReceivedFriendListLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isReceivedFriendListLoading.value = false;
      ll('getReceivedFriendList error: $e');
    }
  }

  //*Accept Friend Request
  final RxBool isAcceptFriendRequestLoading = RxBool(false);
  final RxInt userId = RxInt(-1);
  Future<void> acceptFriendRequest() async {
    try {
      isAcceptFriendRequestLoading.value = true;
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        'user_id': userId.value.toString(),
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuAcceptFriendRequest,
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        for (int index = 0; index <= receivedFriendList.length; index++) {
          receivedFriendList.removeAt(index);
        }
        isAcceptFriendRequestLoading.value = false;
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isAcceptFriendRequestLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isAcceptFriendRequestLoading.value = false;
      ll('acceptFriendRequest error: $e');
    }
  }

  //*Reject Friend Request
  final RxBool isRejectFriendRequestLoading = RxBool(false);
  final RxInt receivedRequestCount = RxInt(0);
  Future<void> rejectFriendRequest() async {
    try {
      isRejectFriendRequestLoading.value = true;
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        'user_id': userId.value.toString(),
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuRejectFriendRequest,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        isRejectFriendRequestLoading.value = false;
        for (int index = 0; index <= receivedFriendList.length; index++) {
          receivedFriendList.removeAt(index);
          receivedRequestCount.value--;
        }
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isRejectFriendRequestLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isRejectFriendRequestLoading.value = false;
      ll('rejectFriendRequest error: $e');
    }
  }

  //*Unfriend User
  final RxBool isUnfriendUserRequestLoading = RxBool(false);
  Future<void> unfriendUserRequest() async {
    try {
      isUnfriendUserRequestLoading.value = true;
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        'user_id': userId.value.toString(),
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuUnFriendUser,
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        isUnfriendUserRequestLoading.value = false;
        for (int index = 0; index <= receivedFriendList.length; index++) {
          friendList.removeAt(index);
        }
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isUnfriendUserRequestLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isUnfriendUserRequestLoading.value = false;
      ll('unfriendRequest error: $e');
    }
  }

  //*Unfollow User
  final RxBool isUnfollowUserLoading = RxBool(false);
  final RxString followStatus = RxString('');
  Future<void> unfollowUser() async {
    try {
      isUnfollowUserLoading.value = true;
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        'user_id': userId.value.toString(),
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuUnFollowUser,
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        isUnfollowUserLoading.value = false;
        followStatus.value = response.message.toString();
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isUnfollowUserLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isUnfollowUserLoading.value = false;
      ll('unfollowUser error: $e');
    }
  }
}
