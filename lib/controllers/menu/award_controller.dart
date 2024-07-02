import 'package:bip_hip/models/menu/award/award_model.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class AwardController extends GetxController {
  final ApiController apiController = ApiController();
  final SpController spController = SpController();
  final GlobalController globalController = Get.find<GlobalController>();
  final TextEditingController awardTextEditingController = TextEditingController();
  final RxBool isAwardSuffixVisible = RxBool(false);
  final RxInt selectedCatagoriesIndex = RxInt(0);
  final RxBool isCategoriesSelected = RxBool(false);
  final imageList = [
    "https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/featured_hu6547841b230d5bd693e155a5fda2f54e_25956_768x0_resize_q75_lanczos.jpg"
  ];
  final RxBool isCommentOnPressed = RxBool(false);
  final RxBool isOthersWinner = RxBool(false);
  void resetAwardData() {
    selectedCatagoriesIndex.value = 0;
    isCategoriesSelected.value = false;
    awardTextEditingController.clear();
  }

  //*Award APi implement
  final Rx<AwardModel?> awardListData = Rx<AwardModel?>(null);
  final RxList<AwardData> myAwardList = RxList<AwardData>([]);
  final RxList<AwardData> friendAwardList = RxList<AwardData>([]);
  final Rx<String?> awardListSubLink = Rx<String?>(null);
  final RxBool awardListScrolled = RxBool(false);
  final RxBool isawardListLoading = RxBool(false);
  Future<void> getAwardList() async {
    try {
      isawardListLoading.value = true;
      String suffixUrl = '?take=15';
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetMyAward + suffixUrl,
      ) as CommonDM;
      if (response.success == true) {
        myAwardList.clear();
        friendAwardList.clear();
        awardListScrolled.value = false;
        awardListData.value = AwardModel.fromJson(response.data);
        myAwardList.addAll(awardListData.value!.myAwards!.data!);
        friendAwardList.addAll(awardListData.value!.otherAwards!.data!);
        awardListSubLink.value = awardListData.value!.otherAwards!.nextPageUrl;
        if (awardListSubLink.value != null) {
          awardListScrolled.value = false;
        } else {
          awardListScrolled.value = true;
        }
        isawardListLoading.value = false;
      } else {
        isawardListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isawardListLoading.value = true;
      ll('getAwardList error: $e');
    }
  }
}
