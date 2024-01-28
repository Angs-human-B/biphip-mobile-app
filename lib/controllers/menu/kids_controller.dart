import 'dart:io';
import 'package:bip_hip/models/menu/kids/all_kids_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class KidsController extends GetxController {
  final RxInt kidId = RxInt(-1);
  final ApiController apiController = ApiController();
  final SpController spController = SpController();
  final GlobalController globalController = Get.find<GlobalController>();
  //   //*Kids List Api Call
  final Rx<AllKidsModel?> kidsListData = Rx<AllKidsModel?>(null);
  final RxList<Kid> kidList = RxList<Kid>([]);
  final RxBool isKidsListLoading = RxBool(false);
  final RxInt totalKidsCount = RxInt(0);
  Future<void> getKidsList() async {
    try {
      isKidsListLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
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
        isKidsListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isKidsListLoading.value = true;
      ll('getKidsList error: $e');
    }
  }

  //*Delete Kid Api Call
  final RxBool isKidDeleteLoading = RxBool(false);
  Future<void> kidDelete() async {
    try {
      isKidDeleteLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiController.commonApiCall(
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
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isKidDeleteLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
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
  final TextEditingController kidSchoolNameTextEditingController = TextEditingController();
  final RxBool isSaveKidButtonEnabled = RxBool(false);
  final RxBool isKidAdded = RxBool(false);
  final RxBool isKidSelected = RxBool(false);
  final RxString kidName = RxString('');
  final RxString kidAge = RxString('');
  final Rx<String?> kidNameErrorText = Rx<String?>(null);
  final Rx<String?> kidAgeErrorText = Rx<String?>(null);
  final RxBool isNextButtonEnabled = RxBool(false);
  void checkNextButtonEnable() {
    if (kidNameTextEditingController.text.trim().length >= 3 && int.parse(kidAgeTextEditingController.text.trim()) <= 17) {
      isNextButtonEnabled.value = true;
    } else {
      isNextButtonEnabled.value = false;
    }
  }

  void kidNameOnChanged() {
    if (kidNameTextEditingController.text.toString().trim() == '') {
      kidNameErrorText.value = ksEmptyNameErrorText.tr;
    } else if (kidNameTextEditingController.text.trim().length < 3) {
      kidNameErrorText.value = ksKidNameLengthErrorText.tr;
    } else {
      kidNameErrorText.value = null;
    }
  }

  void kidAgeOnChanged() {
    checkNextButtonEnable();
    if (kidAgeTextEditingController.text.isEmpty) {
      kidAgeErrorText.value = ksEmptyKidAgeErrorText.tr;
    } else if (kidAgeTextEditingController.text.isNotEmpty && int.parse(kidAgeTextEditingController.text) > 17) {
      kidAgeErrorText.value = ksKidAgeErrorText.tr;
    } else {
      kidAgeErrorText.value = null;
    }
  }

  final TextEditingController kidParentEmailController = TextEditingController();
  final TextEditingController kidParentPhoneController = TextEditingController();
  final TextEditingController kidParentAddressController = TextEditingController();
  final TextEditingController kidBioController = TextEditingController();
  void resetKidsData() {
    kidNameTextEditingController.clear();
    kidAgeTextEditingController.clear();
    kidSchoolNameTextEditingController.clear();
    kidNameErrorText.value = null;
    kidAgeErrorText.value = null;
    isNextButtonEnabled.value = false;
  }

  //*Edit Kid Api Call
  final RxBool isEditKidLoading = RxBool(false);
  Future<void> editKid() async {
    try {
      isEditKidLoading.value = true;
      String? token = await spController.getBearerToken();

      Map<String, String> body = {
        'id': kidId.value.toString(),
        'name': kidNameTextEditingController.text.trim(),
        'age': kidAgeTextEditingController.text.trim(),
      };
      var response;
      if (isKidImageChanged.value) {
        response = await apiController.mediaUpload(
          url: kuUpdateKid,
          body: body,
          token: token,
          key: 'image',
          value: kidImageFile.value.path,
        ) as CommonDM;
      } else {
        response = await apiController.commonApiCall(
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
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isEditKidLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isEditKidLoading.value = false;
      ll('editKid error: $e');
    }
  }
}
