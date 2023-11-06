import 'dart:io';
import 'package:bip_hip/models/menu/kids/all_kids_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class KidsController extends GetxController {
  final RxInt kidId = RxInt(-1);
  final ApiController _apiController = ApiController();
  final SpController _spController = SpController();
  final GlobalController _globalController = Get.find<GlobalController>();
  //   //*Kids List Api Call
  final Rx<AllKidsModel?> kidsListData = Rx<AllKidsModel?>(null);
  final RxList<Kid> kidList = RxList<Kid>([]);
  final RxBool isKidsListLoading = RxBool(false);
  final RxInt totalKidsCount = RxInt(0);
  Future<void> getKidsList() async {
    try {
      isKidsListLoading.value = true;
      String? token = await _spController.getBearerToken();
      var response = await _apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetAllKidList,
      ) as CommonDM;
      if (response.success == true) {
        kidList.clear();
        kidsListData.value = AllKidsModel.fromJson(response.data);
        kidList.addAll(kidsListData.value!.kids);
        totalKidsCount.value = kidList.length;
        isKidsListLoading.value = false;
      } else {
        isKidsListLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isKidsListLoading.value = false;
      ll('getKidsList error: $e');
    }
  }

  //*Delete Kid
  final RxBool isKidDeleteLoading = RxBool(false);
  Future<void> kidDelete() async {
    try {
      isKidDeleteLoading.value = true;
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await _apiController.commonApiCall(
        requestMethod: kDelete,
        url: '$kuDeleteKids/${kidId.value.toString()}',
        body: body,
        token: token,
      ) as CommonDM;
      if (response.success == true) {
        for (int index = 0; index <= kidList.length; index++) {
          if (kidId.value == kidList[index].id) {
            kidList.removeAt(index);
            totalKidsCount.value--;
          }
        }
        isKidDeleteLoading.value = false;
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isKidDeleteLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isKidDeleteLoading.value = false;
      ll('kidDelete error: $e');
    }
  }

  //Edit kid
  final RxBool saveKidInfo = RxBool(false);
  final RxString kidImageLink = RxString('');
  final Rx<File> kidImageFile = File('').obs;
  final RxBool isKidImageChanged = RxBool(false);
  final TextEditingController kidNameTextEditingController = TextEditingController();
  final TextEditingController kidAgeTextEditingController = TextEditingController();
  final RxBool isSaveKidButtonEnabled = RxBool(false);
  final RxBool isKidAdded = RxBool(false);
  final RxBool isKidSelected = RxBool(false);
  final RxString kidName = RxString('');
  final RxString kidAge = RxString('');

  void checkCanEditKidInfo() {
    if ((kidNameTextEditingController.text.trim() != '' &&
            kidNameTextEditingController.text.trim() != kidName.value &&
            kidNameTextEditingController.text.trim().length > 2) ||
        (kidAgeTextEditingController.text.trim() != '' &&
            kidAgeTextEditingController.text.trim() != kidAge.value &&
            kidAgeTextEditingController.text.trim() != '0') ||
        isKidImageChanged.value) {
      isSaveKidButtonEnabled.value = true;
    } else {
      isSaveKidButtonEnabled.value = false;
    }
  }

  void setupEditKid() {
    for (int i = 0; i < kidList.length; i++) {
      if (kidId.value == kidList[i].id) {
        kidNameTextEditingController.text = kidList[i].name ?? '';
        kidAgeTextEditingController.text = kidList[i].age.toString();
        kidImageLink.value = kidList[i].kidImage.toString();
        kidName.value = kidNameTextEditingController.text;
        kidAge.value = kidAgeTextEditingController.text;
      }
    }
    checkCanEditKidInfo();
  }

  final RxBool isEditKidLoading = RxBool(false);
  Future<void> editKid() async {
    try {
      isEditKidLoading.value = true;
      String? token = await _spController.getBearerToken();

      Map<String, String> body = {
        'id': kidId.value.toString(),
        'name': kidNameTextEditingController.text.trim(),
        'age': kidAgeTextEditingController.text.trim(),
      };
      var response;
      if (isKidImageChanged.value) {
        response = await _apiController.mediaUpload(
          // requestMethod: kPost,
          url: kuUpdateKid,
          body: body,
          token: token,
          key: 'image',
          value: kidImageFile.value.path,
        ) as CommonDM;
      } else {
        response = await _apiController.commonApiCall(
          requestMethod: kPost,
          url: kuUpdateKid,
          body: body,
          token: token,
        ) as CommonDM;
      }

      if (response.success == true) {
        await getKidsList();
        isEditKidLoading.value = false;
        isKidImageChanged.value = false;
        Get.back();
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditKidLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isEditKidLoading.value = false;
      ll('editKid error: $e');
    }
  }
}
