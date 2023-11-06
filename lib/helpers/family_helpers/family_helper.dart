import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class FamilyHelper {
  final ProfileController _profileController = Get.find<ProfileController>();
  final FamilyController _familyController = Get.find<FamilyController>();
  //*Family Search field reset
  void familySearchFieldReset() {
    _profileController.searchController.clear();
    _familyController.isFamilySuffixIconVisible.value = false;
  }

  Widget totalFamilyCountShow() {
    if (_profileController.tapAbleButtonState[0]) {
      if (_familyController.allFamilyCount.value == 0) {
        return const SizedBox();
      } else {
        return Text(
          '${ksTotalFamilyMembers.tr}: ${_familyController.allFamilyCount.value}',
          style: semiBold14TextStyle(cBlackColor),
        );
      }
    } else {
      if (_familyController.receivedRequestCount.value == 0) {
        return const SizedBox();
      } else {
        return Text(
          '${ksFamilyRequests.tr}: ${_familyController.receivedRequestCount.value}',
          style: semiBold14TextStyle(cBlackColor),
        );
      }
    }
  }
}
