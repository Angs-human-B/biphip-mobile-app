import 'dart:async';
import 'package:bip_hip/helpers/menu/family/family_helper.dart';
import 'package:bip_hip/models/common/common_friend_family_user_model.dart';
import 'package:bip_hip/models/menu/family/common_family_model.dart';
import 'package:bip_hip/models/menu/family/family_relation_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class FamilyController extends GetxController {
  final ApiController apiController = ApiController();
  final SpController spController = SpController();
  final GlobalController globalController = Get.find<GlobalController>();
  //*Scroll controller for pagination
  final ScrollController familyListScrollController = ScrollController();
  //*Family List Api Call
  Rx<CommonFamilyModel?> familyData = Rx<CommonFamilyModel?>(null);
  RxList<FriendFamilyUserData> familyList = RxList<FriendFamilyUserData>([]);
  final Rx<String?> familyListSubLink = Rx<String?>(null);
  final RxBool familyListScrolled = RxBool(false);
  final RxBool isFamilyListLoading = RxBool(false);
  final RxInt allFamilyCount = RxInt(0);
  Future<void> getFamilyList() async {
    try {
      isFamilyListLoading.value = true;
      String suffixUrl = '?take=15';
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetFamilyList + suffixUrl,
      ) as CommonDM;
      if (response.success == true) {
        familyList.clear();
        familyListScrolled.value = false;
        familyData.value = CommonFamilyModel.fromJson(response.data);
        familyList.addAll(familyData.value!.families!.data);
        allFamilyCount.value = familyData.value!.families!.total!;
        familyListSubLink.value = familyData.value!.families!.nextPageUrl;
        if (familyListSubLink.value != null) {
          familyListScrolled.value = false;
        } else {
          familyListScrolled.value = true;
        }

        isFamilyListLoading.value = false;
      } else {
        isFamilyListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isFamilyListLoading.value = true;
      ll('getFamilyList error: $e');
    }
  }

  //*Get More Family List for pagination
  Future<void> getMoreFamilyList(take) async {
    try {
      String? token = await spController.getBearerToken();
      dynamic familyListSub;

      if (familyListSubLink.value == null) {
        return;
      } else {
        familyListSub = familyListSubLink.value!.split('?');
      }

      String familyListSuffixUrl = '';

      familyListSuffixUrl = '?${familyListSub[1]}&take=15';

      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetFamilyList + familyListSuffixUrl,
      ) as CommonDM;

      if (response.success == true) {
        familyData.value = CommonFamilyModel.fromJson(response.data);
        familyList.addAll(familyData.value!.families!.data);
        allFamilyCount.value = familyData.value!.families!.total!;
        familyListSubLink.value = familyData.value!.families!.nextPageUrl;
        if (familyListSubLink.value != null) {
          familyListScrolled.value = false;
        } else {
          familyListScrolled.value = true;
        }

        isFamilyListLoading.value = false;
      } else {
        isFamilyListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isFamilyListLoading.value = true;
      ll('getMoreFamilyList error: $e');
    }
  }

  //*Received Scroll controller for pagination
  final ScrollController receivedFamilyListScrollController = ScrollController();
  //*Received Family List Api Call
  Rx<CommonFamilySendReceiveModel?> receivedFamilyListData = Rx<CommonFamilySendReceiveModel?>(null);
  RxList<FriendFamilyUserData> receivedFamilyList = RxList<FriendFamilyUserData>([]);
  final Rx<String?> receivedFamilyListSubLink = Rx<String?>(null);
  final RxBool receivedFamilyListScrolled = RxBool(false);
  final RxBool isReceivedFamilyListLoading = RxBool(false);
  Future<void> getReceivedFamilyList() async {
    try {
      isReceivedFamilyListLoading.value = true;
      String suffixUrl = '?take=15';
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetFamilyRequestReceiveList + suffixUrl,
      ) as CommonDM;
      if (response.success == true) {
        receivedFamilyList.clear();
        receivedFamilyListScrolled.value = false;
        receivedFamilyListData.value = CommonFamilySendReceiveModel.fromJson(response.data);
        receivedFamilyList.addAll(receivedFamilyListData.value!.users!.data);
        receivedRequestCount.value = receivedFamilyListData.value!.users!.total!;
        receivedFamilyListSubLink.value = receivedFamilyListData.value!.users!.nextPageUrl;
        if (receivedFamilyListSubLink.value != null) {
          receivedFamilyListScrolled.value = false;
        } else {
          receivedFamilyListScrolled.value = true;
        }
        isReceivedFamilyListLoading.value = false;
      } else {
        isReceivedFamilyListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isReceivedFamilyListLoading.value = true;
      ll('getReceivedFamilyList error: $e');
    }
  }

  //*Get More Received Family List for pagination
  Future<void> getMoreReceivedFamilyList(take) async {
    try {
      String? token = await spController.getBearerToken();
      dynamic receivedFamilyListSub;

      if (receivedFamilyListSubLink.value == null) {
        return;
      } else {
        receivedFamilyListSub = receivedFamilyListSubLink.value!.split('?');
      }

      String receivedFamilyListSuffixUrl = '';

      receivedFamilyListSuffixUrl = '?${receivedFamilyListSub[1]}&take=15';

      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetFamilyRequestReceiveList + receivedFamilyListSuffixUrl,
      ) as CommonDM;

      if (response.success == true) {
        receivedFamilyListData.value = CommonFamilySendReceiveModel.fromJson(response.data);
        receivedFamilyList.addAll(receivedFamilyListData.value!.users!.data);
        receivedRequestCount.value = receivedFamilyListData.value!.users!.total!;
        receivedFamilyListSubLink.value = receivedFamilyListData.value!.users!.nextPageUrl;
        if (receivedFamilyListSubLink.value != null) {
          receivedFamilyListScrolled.value = false;
        } else {
          receivedFamilyListScrolled.value = true;
        }

        isReceivedFamilyListLoading.value = false;
      } else {
        isReceivedFamilyListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isReceivedFamilyListLoading.value = true;
      ll('getMoreReceivedFamilyList error: $e');
    }
  }

  //*Accept Family Request
  final RxInt userId = RxInt(-1);
  Future<void> acceptFamilyRequest() async {
    try {
      isFamilyRequestListLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'family_id': userId.value.toString(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuAcceptFamilyRequest,
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        for (int index = 0; index < receivedFamilyList.length; index++) {
          if (userId.value == receivedFamilyList[index].id) {
            receivedFamilyList.removeAt(index);
            receivedRequestCount.value--;
          }
        }
        isFamilyRequestListLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isFamilyRequestListLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isFamilyRequestListLoading.value = false;
      ll('acceptFamilyRequest error: $e');
    }
  }

  //*Reject Family Request

  final RxInt receivedRequestCount = RxInt(0);
  Future<void> rejectFamilyRequest() async {
    try {
      isFamilyRequestListLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'family_id': userId.value.toString(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuRejectFamilyRequest,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        isFamilyRequestListLoading.value = false;
        for (int index = 0; index < receivedFamilyList.length; index++) {
          if (userId.value == receivedFamilyList[index].id) {
            receivedFamilyList.removeAt(index);
            receivedRequestCount.value--;
          }
        }

        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isFamilyRequestListLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isFamilyRequestListLoading.value = false;
      ll('rejectFamilyRequest error: $e');
    }
  }

  //*Send Request Scroll controller for pagination
  final ScrollController sendFamilyListScrollController = ScrollController();
  //* Family Request Send List(Pending)
  Rx<CommonFamilySendReceiveModel?> sendFamilyRequestData = Rx<CommonFamilySendReceiveModel?>(null);
  RxList<FriendFamilyUserData> sendFamilyRequestList = RxList<FriendFamilyUserData>([]);
  final Rx<String?> sendFamilyListSubLink = Rx<String?>(null);
  final RxBool sendFamilyListScrolled = RxBool(false);
  final RxBool isSendFamilyRequestListLoading = RxBool(false);
  Future<void> getSendFamilyRequestList() async {
    try {
      isSendFamilyRequestListLoading.value = true;
      String suffixUrl = '?take=15';
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetFamilyRequestSendList + suffixUrl,
      ) as CommonDM;
      if (response.success == true) {
        sendFamilyRequestList.clear();
        sendFamilyListScrolled.value = false;
        sendFamilyRequestData.value = CommonFamilySendReceiveModel.fromJson(response.data);
        sendFamilyRequestList.addAll(sendFamilyRequestData.value!.users!.data);
        sendFamilyListSubLink.value = sendFamilyRequestData.value!.users!.nextPageUrl;
        if (sendFamilyListSubLink.value != null) {
          sendFamilyListScrolled.value = false;
        } else {
          sendFamilyListScrolled.value = true;
        }
        isSendFamilyRequestListLoading.value = false;
      } else {
        isSendFamilyRequestListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isSendFamilyRequestListLoading.value = true;
      ll('getSendFamilyRequestList error: $e');
    }
  }

  //*Get More Received Family List for pagination
  Future<void> getMoreSendFamilyList(take) async {
    try {
      String? token = await spController.getBearerToken();
      dynamic sendFamilyListSub;

      if (sendFamilyListSubLink.value == null) {
        return;
      } else {
        sendFamilyListSub = sendFamilyListSubLink.value!.split('?');
      }

      String sendFamilyListSuffixUrl = '';

      sendFamilyListSuffixUrl = '?${sendFamilyListSub[1]}&take=15';

      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetFamilyRequestSendList + sendFamilyListSuffixUrl,
      ) as CommonDM;

      if (response.success == true) {
        sendFamilyRequestData.value = CommonFamilySendReceiveModel.fromJson(response.data);
        sendFamilyRequestList.addAll(sendFamilyRequestData.value!.users!.data);
        sendFamilyListSubLink.value = sendFamilyRequestData.value!.users!.nextPageUrl;
        if (sendFamilyListSubLink.value != null) {
          sendFamilyListScrolled.value = false;
        } else {
          sendFamilyListScrolled.value = true;
        }
        isSendFamilyRequestListLoading.value = false;
      } else {
        isSendFamilyRequestListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isSendFamilyRequestListLoading.value = true;
      ll('getMoreSendFamilyList error: $e');
    }
  }

  //*Cancel Family Request
  final RxBool isFamilyRequestListLoading = RxBool(false);
  Future<void> cancelFamilyRequest() async {
    try {
      isFamilyRequestListLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'user_id': userId.value.toString(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuCancelFamilyRequest,
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        for (int index = 0; index < sendFamilyRequestList.length; index++) {
          if (userId.value == sendFamilyRequestList[index].id) {
            sendFamilyRequestList.removeAt(index);
          }
        }
        isFamilyRequestListLoading.value = false;
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isFamilyRequestListLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isFamilyRequestListLoading.value = false;
      ll('cancelFamilyRequest error: $e');
    }
  }

  //*Send Family Request
  final RxInt relationStatusId = RxInt(-1);
  final RxInt relationId = RxInt(-1);
  final RxBool isSendFamilyRequestLoading = RxBool(false);
  Future<void> sendFamilyRequest() async {
    try {
      isSendFamilyRequestLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'family_id': userId.value.toString(),
        'relation_id': relationId.value.toString(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuSendFamilyRequest,
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        if (isRouteFromAllFriend.value) {
          isRouteFromAllFriend.value = false;
          Get.offNamedUntil(krMenu, (route) => true);
          Get.toNamed(krFamily);
          FamilyHelper().pendingFamilyTapableButtOnPressed();
        } else {
          Get.back();
          FamilyHelper().pendingFamilyTapableButtOnPressed();
          isSendFamilyRequestLoading.value = false;
          globalController.searchController.clear();
        }
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor);
      } else {
        isSendFamilyRequestLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isSendFamilyRequestLoading.value = false;
      ll('sendFamilyRequest error: $e');
    }
  }

  //*Get Family Relation Status
  final Rx<FamilyRelationModel?> familyRelationListData = Rx<FamilyRelationModel?>(null);
  final RxList<Relation> familyRelationList = RxList<Relation>([]);
  RxBool isFamilyRelationListLoading = RxBool(false);
  Future<void> getFamilyRelationList() async {
    try {
      isFamilyRelationListLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetAllFamilyRelations,
      ) as CommonDM;
      if (response.success == true) {
        familyRelationList.clear();
        familyRelationListData.value = FamilyRelationModel.fromJson(response.data);
        familyRelationList.addAll(familyRelationListData.value!.relations);
        isFamilyRelationListLoading.value = false;
      } else {
        isFamilyRelationListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isFamilyRelationListLoading.value = true;
      ll('getFamilyRelationList error: $e');
    }
  }

  final RxString relation = RxString("");
  final RxString temporaryRelation = RxString("");
  final FocusNode addFamilyFocusNode = FocusNode();
  void clearAddFamilyData() {
    relationStatusId.value = -1;
    userId.value = -1;
    relationId.value = -1;
    relation.value = '';
    temporaryRelation.value = '';
  }

  Timer? debounce;
  final RxBool isFamilySuffixIconVisible = RxBool(false);
  final RxBool isRouteFromAllFriend = RxBool(false);
}
