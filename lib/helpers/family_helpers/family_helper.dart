import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class FamilyHelper {
  final ProfileController _profileController = Get.find<ProfileController>();
  final GlobalController _globalController = Get.find<GlobalController>();
  final FamilyController _familyController = Get.find<FamilyController>();
  //*Family Page
  void familySearchFieldReset() {
    _profileController.searchController.clear();
    _familyController.isFamilySuffixIconVisible.value = false;
  }

  Widget totalFamilyCountShow() {
    if (_globalController.tapAbleButtonState[0]) {
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

  void familyAddButtonOnPressed() {
    familySearchFieldReset();
    _familyController.clearAddFamilyData();
    Get.toNamed(krAddFamily);
    Get.find<FriendController>().getFriendListForAddFamily();
  }

  void familyOnChanged() {
    if (_profileController.searchController.text.trim() != '') {
      _familyController.isFamilySuffixIconVisible.value = true;
    } else {
      _familyController.isFamilySuffixIconVisible.value = false;
    }
  }

  void allFamilyTapableButtOnPressed() async {
    _globalController.toggleType(0);
    familySearchFieldReset();
    await _familyController.getFamilyList();
  }

  void receivedFamilyTapableButtOnPressed() async {
    _globalController.toggleType(1);
    familySearchFieldReset();
    await _familyController.getReceivedFamilyList();
  }

  void pendingFamilyTapableButtOnPressed() async {
    _globalController.toggleType(2);
    familySearchFieldReset();
    await _familyController.getSendFamilyRequestList();
  }

  void addFamilySendOnPressed() async {
    await _familyController.sendFamilyRequest();
    _familyController.isFamilySuffixIconVisible.value = false;
  }

  //*Add family page
  void addFamilyOnPressedRightButton() {
    _familyController.isFamilyRelationListLoading.value = true;
    _familyController.relation.value = _familyController.tempRelation.value;
    for (int index = 0; index < _familyController.familyRelationList.length; index++) {
      if (_familyController.tempRelation.value == _familyController.familyRelationList[index].name) {
        _familyController.relationId.value = _familyController.familyRelationList[index].id;
      }
    }
    Get.back();
  }

  void addFamilyOnPressed() {
    _familyController.tempRelation.value = _familyController.relation.value;
    if (_familyController.tempRelation.value == '') {
      Get.find<GlobalController>().isBottomSheetRightButtonActive.value = false;
    } else {
      Get.find<GlobalController>().isBottomSheetRightButtonActive.value = true;
    }
  }

  void addFamilySuffixPressed() {
    _profileController.searchController.clear();
    _familyController.isFamilySuffixIconVisible.value = false;
    _familyController.userId.value = -1;
  }

  void addFamilyRawAutoCompleteOnPressed({required String option}) {
    _profileController.searchController.text = option.toString();
    for (int i = 0; i < Get.find<FriendController>().friendListForAddFamily.length; i++) {
      if (Get.find<FriendController>().friendListForAddFamily[i].fullName == option) {
        _familyController.userId.value = Get.find<FriendController>().friendListForAddFamily[i].id!;
      }
    }
  }
}
