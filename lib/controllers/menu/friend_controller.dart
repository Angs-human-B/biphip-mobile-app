import 'dart:async';
import 'package:bip_hip/models/common/common_friend_family_user_model.dart';
import 'package:bip_hip/models/menu/friend/common_friend_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class FriendController extends GetxController {
  final ApiController apiController = ApiController();
  final SpController spController = SpController();
  final GlobalController globalController = Get.find<GlobalController>();
  final Rx<String?> familyRelationStatus = Rx<String?>('');
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
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
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
        isFriendListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isFriendListLoading.value = true;
      ll('getFriendList error: $e');
    }
  }

  //*Get More Friend List for pagination
  Future<void> getMoreFriendList(take) async {
    try {
      String? token = await spController.getBearerToken();
      dynamic friendListSub;

      if (friendListSubLink.value == null) {
        return;
      } else {
        friendListSub = friendListSubLink.value!.split('?');
      }

      String friendListSuffixUrl = '';

      friendListSuffixUrl = '?${friendListSub[1]}&take=15';

      var response = await apiController.commonApiCall(
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
        isFriendListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isFriendListLoading.value = true;
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
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
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
        isReceivedFriendListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isReceivedFriendListLoading.value = true;
      ll('getReceivedFriendList error: $e');
    }
  }

  //*Get More Received Friend List for pagination
  Future<void> getMoreReceivedFriendList(take) async {
    try {
      String? token = await spController.getBearerToken();
      dynamic receivedFriendListSub;

      if (receivedFriendListSubLink.value == null) {
        return;
      } else {
        receivedFriendListSub = receivedFriendListSubLink.value!.split('?');
      }

      String receivedFriendListSuffixUrl = '';

      receivedFriendListSuffixUrl = '?${receivedFriendListSub[1]}&take=15';

      var response = await apiController.commonApiCall(
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
        isReceivedFriendListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isReceivedFriendListLoading.value = true;
      ll('getMoreReceivedFriendList error: $e');
    }
  }

  //*Accept Friend Request
  final RxInt userId = RxInt(-1);
  Future<void> acceptFriendRequest() async {
    try {
      isFriendViewLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'user_id': userId.value.toString(),
      };
      var response = await apiController.commonApiCall(
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
        isFriendViewLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isFriendViewLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isFriendViewLoading.value = false;
      ll('acceptFriendRequest error: $e');
    }
  }

  //*Reject Friend Request
  Future<void> rejectFriendRequest() async {
    try {
      isFriendViewLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'user_id': userId.value.toString(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuRejectFriendRequest,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        isFriendViewLoading.value = false;
        for (int index = 0; index <= receivedFriendList.length; index++) {
          if (userId.value == receivedFriendList[index].id) {
            receivedFriendList.removeAt(index);
            receivedRequestCount.value--;
          }
        }
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isFriendViewLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isFriendViewLoading.value = false;
      ll('rejectFriendRequest error: $e');
    }
  }

  //*Unfriend User
  final RxBool isFriendViewLoading = RxBool(false);
  Future<void> unfriendUserRequest() async {
    try {
      isFriendViewLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'user_id': userId.value.toString(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuUnFriendUser,
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        isFriendViewLoading.value = false;
        for (int index = 0; index < friendList.length; index++) {
          if (userId.value == friendList[index].id) {
            friendList.removeAt(index);
            allFriendCount.value--;
            searchedFriendCount.value--;
          }
        }
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isFriendViewLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isFriendViewLoading.value = false;
      ll('unfriendRequest error: $e');
    }
  }

  //*Unfollow User
  Future<void> unfollowUser() async {
    try {
      isFriendViewLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'user_id': userId.value.toString(),
      };
      var response = await apiController.commonApiCall(
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
        isFriendViewLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isFriendViewLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isFriendViewLoading.value = false;
      ll('unfollowUser error: $e');
    }
  }

  //*Follow User

  Future<void> followUser() async {
    try {
      isFriendViewLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'user_id': userId.value.toString(),
      };
      var response = await apiController.commonApiCall(
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
        isFriendViewLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isFriendViewLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isFriendViewLoading.value = false;
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
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
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
        isSendFriendRequestListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isSendFriendRequestListLoading.value = true;
      ll('getSendFriendRequest error: $e');
    }
  }

  //*Get More Send Friend Request List(Pending) for pagination
  Future<void> getMoreSendFriendRequestList(take) async {
    try {
      String? token = await spController.getBearerToken();
      dynamic sendFriendListSub;

      if (sendFriendListSubLink.value == null) {
        return;
      } else {
        sendFriendListSub = sendFriendListSubLink.value!.split('?');
      }

      String sendFriendListSuffixUrl = '';

      sendFriendListSuffixUrl = '?${sendFriendListSub[1]}&take=15';

      var response = await apiController.commonApiCall(
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
        isSendFriendRequestListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isSendFriendRequestListLoading.value = true;
      ll('getMoreSendFriendRequestList error: $e');
    }
  }

  //*Cancel Friend Request
  final RxBool isCancelFriendRequestLoading = RxBool(false);
  Future<dynamic> cancelFriendRequest() async {
    try {
      isCancelFriendRequestLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'user_id': userId.value.toString(),
      };
      var response = await apiController.commonApiCall(
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
        for (int index = 0; index < addFriendList.length; index++) {
          if (addFriendList[index].id == userId.value) {
            addFriendList[index].friendStatus = 0;
          }
        }
        isCancelFriendRequestLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
        return true;
      } else {
        isCancelFriendRequestLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
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
  final Rx<CommonFriends?> addFriendData = Rx<CommonFriends?>(null);
  final RxList<FriendFamilyUserData> addFriendList = RxList<FriendFamilyUserData>([]);
  final Rx<String?> addFriendListSubLink = Rx<String?>(null);
  final RxBool addFriendListScrolled = RxBool(false);
  final RxBool isAddFriendListLoading = RxBool(false);
  Future<void> getAddFriendList() async {
    try {
      isAddFriendListLoading.value = true;
      String suffixUrl = '&take=15';
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: '$kuCommonUserSearch?key=${globalController.searchController.text.trim()}$suffixUrl',
      ) as CommonDM;
      if (response.success == true) {
        addFriendList.clear();
        addFriendListScrolled.value = false;
        addFriendData.value = CommonFriends.fromJson(response.data);
        for (int index = 0; index < addFriendData.value!.data.length; index++) {
          if (addFriendData.value!.data[index].friendStatus == 2 || addFriendData.value!.data[index].friendStatus == 0) {
            addFriendList.add(addFriendData.value!.data[index]);
            addFriendListSubLink.value = addFriendData.value!.nextPageUrl;
            if (addFriendListSubLink.value != null) {
              sendFriendListScrolled.value = false;
            } else {
              sendFriendListScrolled.value = true;
            }
          }
        }

        isAddFriendListLoading.value = false;
      } else {
        isAddFriendListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isAddFriendListLoading.value = true;
      ll('getAddFriendList error: $e');
    }
  }

  //*Get More Add Friend Request List for pagination
  Future<void> getMoreAddFriendList(take) async {
    try {
      String? token = await spController.getBearerToken();
      dynamic addFriendListSub;

      if (addFriendListSubLink.value == null) {
        return;
      } else {
        addFriendListSub = addFriendListSubLink.value!.split('?');
      }

      String addFriendListSuffixUrl = '';

      addFriendListSuffixUrl = '&${addFriendListSub[1]}&take=15';

      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: '$kuCommonUserSearch?key=${globalController.searchController.text.trim()}$addFriendListSuffixUrl',
      ) as CommonDM;
      if (response.success == true) {
        addFriendData.value = CommonFriends.fromJson(response.data);
        for (int index = 0; index < addFriendData.value!.data.length; index++) {
          if (addFriendData.value!.data[index].friendStatus == 2 || addFriendData.value!.data[index].friendStatus == 0) {
            addFriendList.add(addFriendData.value!.data[index]);
            addFriendListSubLink.value = addFriendData.value!.nextPageUrl;
            if (addFriendListSubLink.value != null) {
              addFriendListScrolled.value = false;
            } else {
              addFriendListScrolled.value = true;
            }
          }
        }
        addFriendListSubLink.value = addFriendData.value!.nextPageUrl;
        if (addFriendListSubLink.value != null) {
          addFriendListScrolled.value = false;
        } else {
          addFriendListScrolled.value = true;
        }
        isAddFriendListLoading.value = false;
      } else {
        isAddFriendListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isAddFriendListLoading.value = true;
      ll('getMoreAddFriendRequestList error: $e');
    }
  }

  //*Send Friend Request
  final RxBool isSendFriendRequestLoading = RxBool(false);
  Future<dynamic> sendFriendRequest() async {
    try {
      isSendFriendRequestLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'friend_id': userId.value.toString(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuSendFriendRequest,
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        for (int index = 0; index < addFriendList.length; index++) {
          if (addFriendList[index].id == userId.value) {
            addFriendList[index].friendStatus = 2;
          }
        }
        isSendFriendRequestLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
        return true;
      } else {
        isSendFriendRequestLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
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
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
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
            tempFriendList.add(friendListDataForAddFamily.value!.friends!.data[i].profilePicture!);
          }
        }
        isFriendListForAddFamilyLoading.value = false;
      } else {
        isFriendListForAddFamilyLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isFriendListForAddFamilyLoading.value = true;
      ll('getFriendListForAddFamily error: $e');
    }
  }

  final RxInt searchedFriendCount = RxInt(0);
  Rx<CommonFriends?> searchFriendData = Rx<CommonFriends?>(null);
  Future<void> getFriendSearchList() async {
    friendListSubLink.value = null;
    friendListScrolled.value = false;
    isFriendListLoading.value = false;
    try {
      isFriendListLoading.value = true;
      String suffixUrl = '&take=15';
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: '$kuGetSearchFriends?key=${globalController.searchController.text.trim()}$suffixUrl',
      ) as CommonDM;
      if (response.success == true) {
        friendList.clear();
        friendListScrolled.value = false;
        searchFriendData.value = CommonFriends.fromJson(response.data);
        friendList.addAll(searchFriendData.value!.data);
        searchedFriendCount.value = searchFriendData.value!.total!;
        friendListSubLink.value = searchFriendData.value!.nextPageUrl;
        if (friendListSubLink.value != null) {
          friendListScrolled.value = false;
        } else {
          friendListScrolled.value = true;
        }

        isFriendListLoading.value = false;
      } else {
        isFriendListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isFriendListLoading.value = true;
      ll('getFriendSearchList error: $e');
    }
  }

  //*Get More Friend Search List for pagination
  Future<void> getMoreFriendSearchList(take) async {
    try {
      String? token = await spController.getBearerToken();
      dynamic friendListSub;

      if (friendListSubLink.value == null) {
        return;
      } else {
        friendListSub = friendListSubLink.value!.split('?');
      }

      String friendListSuffixUrl = '';

      friendListSuffixUrl = '&${friendListSub[1]}&take=15';

      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: '$kuGetSearchFriends?key=${globalController.searchController.text}$friendListSuffixUrl',
      ) as CommonDM;

      if (response.success == true) {
        searchFriendData.value = CommonFriends.fromJson(response.data);
        friendList.addAll(searchFriendData.value!.data);
        searchedFriendCount.value = searchFriendData.value!.total!;
        friendListSubLink.value = searchFriendData.value!.nextPageUrl;
        if (friendListSubLink.value != null) {
          friendListScrolled.value = false;
        } else {
          friendListScrolled.value = true;
        }

        isFriendListLoading.value = false;
      } else {
        isFriendListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isFriendListLoading.value = true;
      ll('getMoreFriendSearchList error: $e');
    }
  }

  Timer? debounce;

  final RxBool isFriendSearched = RxBool(false);
  //*Pending friend Action
  final RxString pendingFriendActionSelect = RxString('');
  final RxInt pendingFriendFollowStatus = RxInt(-1);
  final RxBool pendingFriendActionBottomSheetRightButtonState = RxBool(false);
  final RxList pendingFriendActionList = RxList([
    {'icon': BipHip.cancelRequest, 'action': 'Cancel Request', 'actionSubtitle': 'The request will be cancelled'},
    {'icon': BipHip.unFollow, 'action': 'Unfollow', 'actionSubtitle': 'Unfollow this user'}
  ]);
  final RxList pendingFollowFriendActionList = RxList([
    {'icon': BipHip.cancelRequest, 'action': 'Cancel Request', 'actionSubtitle': 'The request will be cancelled'},
    {'icon': BipHip.follow, 'action': 'Follow', 'actionSubtitle': 'Follow this user'}
  ]);
  //*All friend Action
  final RxString friendActionSelect = RxString('');
  final RxInt allFriendFollowStatus = RxInt(-1);
  final RxBool friendActionBottomSheetRightButtonState = RxBool(false);
  final RxList friendActionList = RxList([
    {'icon': BipHip.unfriend, 'action': 'Unfriend', 'actionSubtitle': 'Remove your friend'},
    {'icon': BipHip.unFollow, 'action': 'Unfollow', 'actionSubtitle': 'Unfollow your friend'},
    {'icon': BipHip.removeFamily, 'action': 'Add Family', 'actionSubtitle': 'Add your family'}
  ]);
  final RxList friendFollowActionList = RxList([
    {'icon': BipHip.unfriend, 'action': 'Unfriend', 'actionSubtitle': 'Remove your friend'},
    {'icon': BipHip.follow, 'action': 'Follow', 'actionSubtitle': 'Follow your friend'},
    {'icon': BipHip.removeFamily, 'action': 'Add Family', 'actionSubtitle': 'Add your family'}
  ]);
  //*Search suffix icon and bottom nav route bool value
  final RxBool isFriendSuffixIconVisible = RxBool(false);
  final RxBool isRouteFromBottomNavBar = RxBool(false);
}
