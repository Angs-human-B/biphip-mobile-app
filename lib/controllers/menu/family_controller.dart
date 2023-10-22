import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/models/common/common_data_model.dart';
import 'package:bip_hip/models/common/common_error_model.dart';
import 'package:bip_hip/models/family/common_family_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class FamilyController extends GetxController {
  final ApiController _apiController = ApiController();
  final SpController _spController = SpController();
  final GlobalController _globalController = Get.find<GlobalController>();
  final ProfileController _profileController = Get.find<ProfileController>();
  //*Scroll controller for pagination
  final ScrollController familyListScrollController = ScrollController();
  //*Family List Api Call
  Rx<CommonFamilyModel?> familyData = Rx<CommonFamilyModel?>(null);
  RxList<FamilyData> familyList = RxList<FamilyData>([]);
  final Rx<String?> familyListSubLink = Rx<String?>(null);
  final RxBool familyListScrolled = RxBool(false);
  final RxBool isFamilyListLoading = RxBool(false);
  final RxInt allFamilyCount = RxInt(0);
  Future<void> getFamilyList() async {
    try {
      isFamilyListLoading.value = true;
      String suffixUrl = '?take=15';
      String? token = await _spController.getBearerToken();
      var response = await _apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetFamilyList + suffixUrl,
      ) as CommonDM;
      if (response.success == true) {
        familyList.clear();
        familyListScrolled.value = false;
        familyData.value = CommonFamilyModel.fromJson(response.data);
        familyList.addAll(familyData.value!.families!.data);
        allFamilyCount.value = familyList.length;
        familyListSubLink.value = familyData.value!.families!.nextPageUrl;
        if (familyListSubLink.value != null) {
          familyListScrolled.value = false;
        } else {
          familyListScrolled.value = true;
        }

        isFamilyListLoading.value = false;
      } else {
        isFamilyListLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isFamilyListLoading.value = false;
      ll('getFamilyList error: $e');
    }
  }

  //*Get More Family List for pagination
  Future<void> getMoreFamilyList(take) async {
    try {
      String? token = await _spController.getBearerToken();
      dynamic familyListSub;

      if (familyListSubLink.value == null) {
        return;
      } else {
        familyListSub = familyListSubLink.value!.split('?');
      }

      String familyListSuffixUrl = '';

      familyListSuffixUrl = '?${familyListSub[1]}&take=15';

      var response = await _apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetFriendList + familyListSuffixUrl,
      ) as CommonDM;

      if (response.success == true) {
        familyData.value = CommonFamilyModel.fromJson(response.data);
        ll(familyData.value);
        familyList.addAll(familyData.value!.families!.data);
        allFamilyCount.value = familyList.length;
        familyListSubLink.value = familyData.value!.families!.nextPageUrl;
        if (familyListSubLink.value != null) {
          familyListScrolled.value = false;
        } else {
          familyListScrolled.value = true;
        }

        isFamilyListLoading.value = false;
      } else {
        isFamilyListLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isFamilyListLoading.value = false;
      ll('getMoreFamilyList error: $e');
    }
  }

  //*Received Family List Api Call
  Rx<CommonFamilySendReceiveModel?> receivedFamilyListData = Rx<CommonFamilySendReceiveModel?>(null);
  RxList<FamilyData> receivedFamilyList = RxList<FamilyData>([]);
  // final Rx<String?> familyListSubLink = Rx<String?>(null);
  // final RxBool familyListScrolled = RxBool(false);
  final RxBool isReceivedFamilyListLoading = RxBool(false);
  Future<void> getReceivedFamilyList() async {
    try {
      isReceivedFamilyListLoading.value = true;
      // String suffixUrl = '?take=3';
      String? token = await _spController.getBearerToken();
      var response = await _apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetFamilyRequestReceiveList,
      ) as CommonDM;
      if (response.success == true) {
        receivedFamilyList.clear();

        receivedFamilyListData.value = CommonFamilySendReceiveModel.fromJson(response.data);
        receivedFamilyList.addAll(receivedFamilyListData.value!.users!.data);
        receivedRequestCount.value = receivedFamilyList.length;
        isReceivedFamilyListLoading.value = false;
      } else {
        isReceivedFamilyListLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isReceivedFamilyListLoading.value = false;
      ll('getReceivedFamilyList error: $e');
    }
  }

  //*Accept Family Request
  final RxBool isAcceptFamilyRequestLoading = RxBool(false);
  final RxInt userId = RxInt(-1);
  Future<void> acceptFamilyRequest() async {
    try {
      isAcceptFamilyRequestLoading.value = true;
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        'user_id': userId.value.toString(),
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuAcceptFamilyRequest,
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        for (int index = 0; index <= receivedFamilyList.length; index++) {
          receivedFamilyList.removeAt(index);
        }
        isAcceptFamilyRequestLoading.value = false;
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isAcceptFamilyRequestLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isAcceptFamilyRequestLoading.value = false;
      ll('acceptFamilyRequest error: $e');
    }
  }

  //*Reject Family Request
  final RxBool isRejectFamilyRequestLoading = RxBool(false);
  final RxInt receivedRequestCount = RxInt(0);
  Future<void> rejectFamilyRequest() async {
    try {
      isRejectFamilyRequestLoading.value = true;
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        'user_id': userId.value.toString(),
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuRejectFamilyRequest,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        isRejectFamilyRequestLoading.value = false;
        for (int index = 0; index <= receivedFamilyList.length; index++) {
          receivedFamilyList.removeAt(index);
          receivedRequestCount.value--;
        }
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isRejectFamilyRequestLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isRejectFamilyRequestLoading.value = false;
      ll('rejectFamilyRequest error: $e');
    }
  }

  //* Family Request Send List(Pending)
  Rx<CommonFamilySendReceiveModel?> sendFamilyRequestData = Rx<CommonFamilySendReceiveModel?>(null);
  RxList<FamilyData> sendFamilyRequestList = RxList<FamilyData>([]);
  final RxBool isSendFamilyRequestListLoading = RxBool(false);
  Future<void> getSendFamilyRequestList() async {
    try {
      isSendFamilyRequestListLoading.value = true;
      String? token = await _spController.getBearerToken();
      var response = await _apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetFamilyRequestSendList,
      ) as CommonDM;
      if (response.success == true) {
        sendFamilyRequestList.clear();
        sendFamilyRequestData.value = CommonFamilySendReceiveModel.fromJson(response.data);
        sendFamilyRequestList.addAll(sendFamilyRequestData.value!.users!.data);
        isSendFamilyRequestListLoading.value = false;
      } else {
        isSendFamilyRequestListLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isSendFamilyRequestListLoading.value = false;
      ll('getSendFamilyRequestList error: $e');
    }
  }

  //*Cancel Family Request
  final RxBool isCancelFamilyRequestLoading = RxBool(false);
  Future<void> cancelFamilyRequest() async {
    try {
      isCancelFamilyRequestLoading.value = true;
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        'user_id': userId.value.toString(),
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuCancelFamilyRequest,
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        for (int index = 1; index <= sendFamilyRequestList.length; index++) {
          sendFamilyRequestList.removeAt(index);
        }
        isCancelFamilyRequestLoading.value = false;
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isCancelFamilyRequestLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isCancelFamilyRequestLoading.value = false;
      ll('cancelFamilyRequest error: $e');
    }
  }

  //* Add Family
  Rx<CommonFamilies?> addFamilyRequestData = Rx<CommonFamilies?>(null);
  RxList<FamilyData> addFamilyRequestList = RxList<FamilyData>([]);
  final RxBool isAddFamilyRequestListLoading = RxBool(false);
  Future<void> getAddFamilyRequestList() async {
    try {
      isAddFamilyRequestListLoading.value = true;
      String? token = await _spController.getBearerToken();
      var response = await _apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: '$kuCommonUserSearch?key=${_profileController.searchController.text.trim()}',
      ) as CommonDM;
      if (response.success == true) {
        addFamilyRequestList.clear();
        addFamilyRequestData.value = CommonFamilies.fromJson(response.data);
        addFamilyRequestList.addAll(addFamilyRequestData.value!.data);
        isAddFamilyRequestListLoading.value = false;
      } else {
        isAddFamilyRequestListLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isAddFamilyRequestListLoading.value = false;
      ll('getAddFamilyRequestList error: $e');
    }
  }

  //*Send Family Request
  final RxBool isSendFamilyRequestLoading = RxBool(false);
  Future<void> sendFamilyRequest() async {
    try {
      isSendFamilyRequestLoading.value = true;
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        'family_id': userId.value.toString(),
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuSendFriendRequest,
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        for (int index = 0; index <= addFamilyRequestList.length; index++) {
          sendFamilyRequestList.removeAt(index);
        }
        isSendFamilyRequestLoading.value = false;
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isSendFamilyRequestLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isSendFamilyRequestLoading.value = false;
      ll('sendFamilyRequest error: $e');
    }
  }
}
