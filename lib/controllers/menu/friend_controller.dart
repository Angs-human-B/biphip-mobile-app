import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/models/common/common_friend_family_user_model.dart';
import 'package:bip_hip/models/menu/friend/common_friend_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class FriendController extends GetxController {
  final ApiController _apiController = ApiController();
  final SpController _spController = SpController();
  final ProfileController _profileController = Get.find<ProfileController>();
  final GlobalController _globalController = Get.find<GlobalController>();
  //*Scroll controller for pagination
  final ScrollController friendListScrollController = ScrollController();

  //*Friend List Api Call
  final Rx<CommonFriendModel?> friendListData = Rx<CommonFriendModel?>(null);
  final RxList<FriendFamilyUserData> friendList = RxList<FriendFamilyUserData>([]);
  final Rx<String?> friendListSubLink = Rx<String?>(null);
  final RxBool friendListScrolled = RxBool(false);
  final RxBool isFriendListLoading = RxBool(false);
  final RxInt allFriendCount = RxInt(0);
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
        friendListData.value = CommonFriendModel.fromJson(response.data);
        friendList.addAll(friendListData.value!.friends!.data);

        allFriendCount.value = friendListData.value!.friends!.total!;
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
        friendListData.value = CommonFriendModel.fromJson(response.data);
        friendList.addAll(friendListData.value!.friends!.data);
        allFriendCount.value = friendListData.value!.friends!.total!;
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
      ll('getMoreFriendList error: $e');
    }
  }

  //*Scroll controller for pagination
  final ScrollController receivedFriendListScrollController = ScrollController();
  //*Received Friend List Api Call
  final Rx<CommonSendReceiveModel?> receivedFriendListData = Rx<CommonSendReceiveModel?>(null);
  final RxList<FriendFamilyUserData> receivedFriendList = RxList<FriendFamilyUserData>([]);
  final Rx<String?> receivedFriendListSubLink = Rx<String?>(null);
  final RxBool receivedFriendListScrolled = RxBool(false);
  final RxBool isReceivedFriendListLoading = RxBool(false);
  final RxInt receivedRequestCount = RxInt(0);
  Future<void> getReceivedFriendList() async {
    try {
      isReceivedFriendListLoading.value = true;
      String suffixUrl = '?take=15';
      String? token = await _spController.getBearerToken();
      var response = await _apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetFriendRequestReceiveList + suffixUrl,
      ) as CommonDM;
      if (response.success == true) {
        receivedFriendList.clear();
        receivedFriendListScrolled.value = false;
        receivedFriendListData.value = CommonSendReceiveModel.fromJson(response.data);
        receivedFriendList.addAll(receivedFriendListData.value!.users!.data);
        receivedRequestCount.value = receivedFriendListData.value!.users!.total!;
        receivedFriendListSubLink.value = receivedFriendListData.value!.users!.nextPageUrl;
        if (receivedFriendListSubLink.value != null) {
          receivedFriendListScrolled.value = false;
        } else {
          receivedFriendListScrolled.value = true;
        }
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

  //*Get More Received Friend List for pagination
  Future<void> getMoreReceivedFriendList(take) async {
    try {
      String? token = await _spController.getBearerToken();
      dynamic receivedFriendListSub;

      if (receivedFriendListSubLink.value == null) {
        return;
      } else {
        receivedFriendListSub = receivedFriendListSubLink.value!.split('?');
      }

      String receivedFriendListSuffixUrl = '';

      receivedFriendListSuffixUrl = '?${receivedFriendListSub[1]}&take=15';

      var response = await _apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetFriendRequestReceiveList + receivedFriendListSuffixUrl,
      ) as CommonDM;

      if (response.success == true) {
        receivedFriendListData.value = CommonSendReceiveModel.fromJson(response.data);
        receivedFriendList.addAll(receivedFriendListData.value!.users!.data);
        receivedRequestCount.value = receivedFriendListData.value!.users!.total!;
        receivedFriendListSubLink.value = receivedFriendListData.value!.users!.nextPageUrl;
        if (receivedFriendListSubLink.value != null) {
          receivedFriendListScrolled.value = false;
        } else {
          receivedFriendListScrolled.value = true;
        }
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
      ll('getMoreReceivedFriendList error: $e');
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
          if (userId.value == receivedFriendList[index].id) {
            receivedFriendList.removeAt(index);
            receivedRequestCount.value--;
          }
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
          if (userId.value == receivedFriendList[index].id) {
            receivedFriendList.removeAt(index);
            receivedRequestCount.value--;
          }
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
        for (int index = 0; index < friendList.length; index++) {
          if (userId.value == friendList[index].id) {
            friendList.removeAt(index);
            allFriendCount.value--;
          }
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
        for (int index = 0; index < friendList.length; index++) {
          if (userId.value == friendList[index].id) {
            friendList[index].followStatus = 0;
          }
        }
        for (int index = 0; index < sendFriendRequestList.length; index++) {
          if (userId.value == sendFriendRequestList[index].id) {
            sendFriendRequestList[index].followStatus = 0;
          }
        }
        isUnfollowUserLoading.value = false;
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

  //*Follow User
  final RxBool isFollowUserLoading = RxBool(false);
  Future<void> followUser() async {
    try {
      isFollowUserLoading.value = true;
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        'user_id': userId.value.toString(),
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuFollowUser,
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        for (int index = 0; index < friendList.length; index++) {
          if (userId.value == friendList[index].id) {
            friendList[index].followStatus = 1;
          }
        }
        for (int index = 0; index < sendFriendRequestList.length; index++) {
          if (userId.value == sendFriendRequestList[index].id) {
            sendFriendRequestList[index].followStatus = 1;
          }
        }
        isFollowUserLoading.value = false;
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isFollowUserLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isFollowUserLoading.value = false;
      ll('followUser error: $e');
    }
  }

  //*Scroll controller for pagination
  final ScrollController sendFriendListScrollController = ScrollController();
  //* Friend Request Send List(Pending)
  final Rx<CommonSendReceiveModel?> sendFriendRequestData = Rx<CommonSendReceiveModel?>(null);
  final RxList<FriendFamilyUserData> sendFriendRequestList = RxList<FriendFamilyUserData>([]);
  final Rx<String?> sendFriendListSubLink = Rx<String?>(null);
  final RxBool sendFriendListScrolled = RxBool(false);
  final RxBool isSendFriendRequestListLoading = RxBool(false);
  Future<void> getSendFriendRequestList() async {
    try {
      isSendFriendRequestListLoading.value = true;
      String suffixUrl = '?take=15';
      String? token = await _spController.getBearerToken();
      var response = await _apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetFriendRequestSendList + suffixUrl,
      ) as CommonDM;
      if (response.success == true) {
        sendFriendRequestList.clear();
        sendFriendListScrolled.value = false;
        sendFriendRequestData.value = CommonSendReceiveModel.fromJson(response.data);
        sendFriendRequestList.addAll(sendFriendRequestData.value!.users!.data);
        sendFriendListSubLink.value = sendFriendRequestData.value!.users!.nextPageUrl;
        if (sendFriendListSubLink.value != null) {
          sendFriendListScrolled.value = false;
        } else {
          sendFriendListScrolled.value = true;
        }
        isSendFriendRequestListLoading.value = false;
      } else {
        isSendFriendRequestListLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isSendFriendRequestListLoading.value = false;
      ll('getSendFriendRequest error: $e');
    }
  }

  //*Get More Send Friend Request List(Pending) for pagination
  Future<void> getMoreSendFriendRequestList(take) async {
    try {
      String? token = await _spController.getBearerToken();
      dynamic sendFriendListSub;

      if (sendFriendListSubLink.value == null) {
        return;
      } else {
        sendFriendListSub = sendFriendListSubLink.value!.split('?');
      }

      String sendFriendListSuffixUrl = '';

      sendFriendListSuffixUrl = '?${sendFriendListSub[1]}&take=15';

      var response = await _apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetFriendRequestSendList + sendFriendListSuffixUrl,
      ) as CommonDM;

      if (response.success == true) {
        sendFriendRequestData.value = CommonSendReceiveModel.fromJson(response.data);
        sendFriendRequestList.addAll(sendFriendRequestData.value!.users!.data);
        sendFriendListSubLink.value = sendFriendRequestData.value!.users!.nextPageUrl;
        if (sendFriendListSubLink.value != null) {
          sendFriendListScrolled.value = false;
        } else {
          sendFriendListScrolled.value = true;
        }
        isSendFriendRequestListLoading.value = false;
      } else {
        isSendFriendRequestListLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isSendFriendRequestListLoading.value = false;
      ll('getMoreSendFriendRequestList error: $e');
    }
  }

  //*Cancel Friend Request
  final RxBool isCancelFriendRequestLoading = RxBool(false);
  Future<dynamic> cancelFriendRequest() async {
    try {
      isCancelFriendRequestLoading.value = true;
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        'user_id': userId.value.toString(),
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuCancelFriendRequest,
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        for (int index = 0; index < sendFriendRequestList.length; index++) {
          if (userId.value == sendFriendRequestList[index].id) {
            sendFriendRequestList.removeAt(index);
          }
        }
        for (int index = 0; index < addFriendRequestList.length; index++) {
          if (addFriendRequestList[index].id == userId.value) {
            // isSendRequest.add(false);
            // isSendRequest[index] = true;
            addFriendRequestList[index].friendStatus = 0;
            // isSendRequest[index] = !isSendRequest[index];
          }
        }
        isCancelFriendRequestLoading.value = false;
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
        return true;
      } else {
        isCancelFriendRequestLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
      return false;
    } catch (e) {
      isCancelFriendRequestLoading.value = false;
      ll('cancelFriendRequest error: $e');
      return false;
    }
  }

  //*Scroll controller for pagination
  final ScrollController addFriendListScrollController = ScrollController();
  //* Add Friend
  final Rx<CommonFriends?> addFriendRequestData = Rx<CommonFriends?>(null);
  final RxList<FriendFamilyUserData> addFriendRequestList = RxList<FriendFamilyUserData>([]);
  final Rx<String?> addFriendListSubLink = Rx<String?>(null);
  final RxBool addFriendListScrolled = RxBool(false);
  final RxBool isAddFriendRequestListLoading = RxBool(false);
  Future<void> getAddFriendRequestList() async {
    try {
      isAddFriendRequestListLoading.value = true;
      String suffixUrl = '&take=15';
      String? token = await _spController.getBearerToken();
      var response = await _apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: '$kuCommonUserSearch?key=${_profileController.searchController.text.trim()}$suffixUrl',
      ) as CommonDM;
      if (response.success == true) {
        addFriendRequestList.clear();
        addFriendListScrolled.value = false;
        addFriendRequestData.value = CommonFriends.fromJson(response.data);
        for (int index = 0; index < addFriendRequestData.value!.data.length; index++) {
          if (addFriendRequestData.value!.data[index].friendStatus == 2 || addFriendRequestData.value!.data[index].friendStatus == 0) {
            addFriendRequestList.add(addFriendRequestData.value!.data[index]);
            addFriendListSubLink.value = addFriendRequestData.value!.nextPageUrl;
            if (addFriendListSubLink.value != null) {
              sendFriendListScrolled.value = false;
            } else {
              sendFriendListScrolled.value = true;
            }
          }
        }

        isAddFriendRequestListLoading.value = false;
      } else {
        isAddFriendRequestListLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isAddFriendRequestListLoading.value = false;
      ll('getAddFriendRequestList error: $e');
    }
  }

  //*Get More Add Friend Request List for pagination
  Future<void> getMoreAddFriendRequestList(take) async {
    try {
      String? token = await _spController.getBearerToken();
      dynamic addFriendListSub;

      if (addFriendListSubLink.value == null) {
        return;
      } else {
        addFriendListSub = addFriendListSubLink.value!.split('?');
      }

      String addFriendListSuffixUrl = '';

      addFriendListSuffixUrl = '&${addFriendListSub[1]}&take=15';

      var response = await _apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: '$kuCommonUserSearch?key=${_profileController.searchController.text.trim()}$addFriendListSuffixUrl',
      ) as CommonDM;
      if (response.success == true) {
        addFriendRequestData.value = CommonFriends.fromJson(response.data);
        for (int index = 0; index < addFriendRequestData.value!.data.length; index++) {
          if (addFriendRequestData.value!.data[index].friendStatus == 2 || addFriendRequestData.value!.data[index].friendStatus == 0) {
            addFriendRequestList.add(addFriendRequestData.value!.data[index]);
            addFriendListSubLink.value = addFriendRequestData.value!.nextPageUrl;
            if (addFriendListSubLink.value != null) {
              addFriendListScrolled.value = false;
            } else {
              addFriendListScrolled.value = true;
            }
          }
        }
        addFriendListSubLink.value = addFriendRequestData.value!.nextPageUrl;
        if (addFriendListSubLink.value != null) {
          addFriendListScrolled.value = false;
        } else {
          addFriendListScrolled.value = true;
        }
        // isSendRequest.clear();
        // for (int index = 0; index < addFriendRequestList.length; index++) {
        //   if (addFriendRequestList[index].friendStatus == 2) {
        //     isSendRequest.add(false);
        //   } else if (addFriendRequestList[index].friendStatus == 0) {
        //     isSendRequest.add(true);
        //   }
        // }

        isAddFriendRequestListLoading.value = false;
      } else {
        isAddFriendRequestListLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isAddFriendRequestListLoading.value = false;
      ll('getMoreAddFriendRequestList error: $e');
    }
  }

  //*Send Friend Request
  final RxBool isSendFriendRequestLoading = RxBool(false);
  Future<dynamic> sendFriendRequest() async {
    try {
      isSendFriendRequestLoading.value = true;
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        'friend_id': userId.value.toString(),
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuSendFriendRequest,
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        for (int index = 0; index < addFriendRequestList.length; index++) {
          if (addFriendRequestList[index].id == userId.value) {
            addFriendRequestList[index].friendStatus = 2;
          }
        }
        isSendFriendRequestLoading.value = false;
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
        return true;
      } else {
        isSendFriendRequestLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
        return false;
      }
    } catch (e) {
      isSendFriendRequestLoading.value = false;
      ll('sendFriendRequest error: $e');
      return false;
    }
  }

  //* tempFriendList -> when add family member friend name list needed for suggestion
  final RxList<String> tempFriendList = RxList<String>([]);

  //*Friend List Api Call for add family suggestion list
  final Rx<CommonFriendModel?> friendListDataForAddFamily = Rx<CommonFriendModel?>(null);
  final RxList<FriendFamilyUserData> friendListForAddFamily = RxList<FriendFamilyUserData>([]);
  final RxBool isFriendListForAddFamilyLoading = RxBool(false);
  Future<void> getFriendListForAddFamily() async {
    try {
      isFriendListForAddFamilyLoading.value = true;
      String suffixUrl = '?take=100';
      String? token = await _spController.getBearerToken();
      var response = await _apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetFriendList + suffixUrl,
      ) as CommonDM;
      if (response.success == true) {
        friendListForAddFamily.clear();
        friendListDataForAddFamily.value = CommonFriendModel.fromJson(response.data);
        friendListForAddFamily.addAll(friendListDataForAddFamily.value!.friends!.data);
        tempFriendList.clear();
        for (int i = 0; i < friendListForAddFamily.length; i++) {
          if (friendListForAddFamily[i].familyRelationStatus == null) {
            tempFriendList.add(friendListDataForAddFamily.value!.friends!.data[i].fullName!);
          }
        }
        ll(tempFriendList);
        isFriendListForAddFamilyLoading.value = false;
      } else {
        isFriendListForAddFamilyLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isFriendListForAddFamilyLoading.value = false;
      ll('getFriendListForAddFamily error: $e');
    }
  }

  final RxList pendingFriendActionList = RxList([
    {'icon': BipHip.cancelRequest, 'action': 'Cancel Request', 'actionSubtitle': 'The request will be cancelled'},
    {'icon': BipHip.unFollow, 'action': 'Unfollow', 'actionSubtitle': 'Unfollow this user'}
  ]);
  final RxString pendingFriendActionSelect = RxString('');
  //*Follow Pending friend list
  final RxList pendingFollowFriendActionList = RxList([
    {'icon': BipHip.cancelRequest, 'action': 'Cancel Request', 'actionSubtitle': 'The request will be cancelled'},
    {'icon': BipHip.user, 'action': 'Follow', 'actionSubtitle': 'Follow this user'}
  ]);
  final RxInt allFriendFollowStatus = RxInt(-1);
  final RxInt pendingFriendFollowStatus = RxInt(-1);
  //*Follow All friend list
  final RxList friendFollowActionList = RxList([
    {'icon': BipHip.unfriend, 'action': 'Unfriend', 'actionSubtitle': 'Remove your friend'},
    {'icon': BipHip.user, 'action': 'Follow', 'actionSubtitle': 'Follow your friend'},
    {'icon': BipHip.removeFamily, 'action': 'Add Family', 'actionSubtitle': 'Add your family'}
  ]);
  final RxBool isFriendSuffixIconVisible = RxBool(false);
}
