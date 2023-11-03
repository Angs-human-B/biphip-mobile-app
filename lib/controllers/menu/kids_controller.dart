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

  final RxList allKidsActionList = RxList([
    {'icon': BipHip.edit, 'action': 'Edit', 'actionSubtitle': 'Edit the kid information'},
    {'icon': BipHip.delete, 'action': 'Delete', 'actionSubtitle': 'Delete the kid'}
  ]);
  final RxString allKidsActionSelect = RxString('');
  final RxString tempAllKidActionSelect = RxString('');
}
