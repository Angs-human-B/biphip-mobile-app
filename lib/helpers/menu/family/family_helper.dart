import 'package:bip_hip/controllers/menu/family_controller.dart';
import 'package:bip_hip/controllers/menu/friend_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class FamilyHelper {
  final GlobalController globalController = Get.find<GlobalController>();
  final FamilyController familyController = Get.find<FamilyController>();
  //*Family Page
  void familySearchFieldReset() {
    globalController.searchController.clear();
    familyController.isFamilySuffixIconVisible.value = false;
  }

  Widget totalFamilyCountShow() {
    if (globalController.tapAbleButtonState[0]) {
      if (familyController.allFamilyCount.value == 0) {
        return const SizedBox();
      } else {
        return Text(
          '${ksTotalFamilyMembers.tr}: ${familyController.allFamilyCount.value}',
          style: semiBold14TextStyle(cBlackColor),
        );
      }
    } else {
      if (familyController.receivedRequestCount.value == 0) {
        return const SizedBox();
      } else {
        return Text(
          '${ksFamilyRequests.tr}: ${familyController.receivedRequestCount.value}',
          style: semiBold14TextStyle(cBlackColor),
        );
      }
    }
  }

  void routeToAddFamilyPage() {
    familySearchFieldReset();
    familyController.clearAddFamilyData();
    Get.toNamed(krAddFamily);
    Get.find<FriendController>().getFriendListForAddFamily();
  }

  void searchFamily() {
    if (globalController.searchController.text.trim() != '') {
      familyController.isFamilySuffixIconVisible.value = true;
    } else {
      familyController.isFamilySuffixIconVisible.value = false;
    }
  }

  void allFamilyTapableButtOnPressed() async {
    globalController.toggleType(0);
    familySearchFieldReset();
    await familyController.getFamilyList();
  }

  void receivedFamilyTapableButtOnPressed() async {
    globalController.toggleType(1);
    familySearchFieldReset();
    await familyController.getReceivedFamilyList();
  }

  void pendingFamilyTapableButtOnPressed() async {
    globalController.toggleType(2);
    familySearchFieldReset();
    await familyController.getSendFamilyRequestList();
  }

  void addFamily() async {
    await familyController.sendFamilyRequest();
    familyController.isFamilySuffixIconVisible.value = false;
  }

  //*Add family page
  void selectRelation() {
    familyController.isFamilyRelationListLoading.value = true;
    familyController.relation.value = familyController.temporaryRelation.value;
    for (int index = 0; index < familyController.familyRelationList.length; index++) {
      if (familyController.temporaryRelation.value == familyController.familyRelationList[index].name) {
        familyController.relationId.value = familyController.familyRelationList[index].id;
      }
    }
    Get.back();
  }

  void setRelationBottomSheetValue() {
    familyController.temporaryRelation.value = familyController.relation.value;
    if (familyController.temporaryRelation.value == '') {
      Get.find<GlobalController>().isBottomSheetRightButtonActive.value = false;
    } else {
      Get.find<GlobalController>().isBottomSheetRightButtonActive.value = true;
    }
  }

  void familySearchReset() {
    globalController.searchController.clear();
    familyController.isFamilySuffixIconVisible.value = false;
    familyController.userId.value = -1;
  }

  void addFamilySetAutoComplete({required String option}) {
    globalController.searchController.text = option.toString();
    for (int i = 0; i < Get.find<FriendController>().friendListForAddFamily.length; i++) {
      if (Get.find<FriendController>().friendListForAddFamily[i].fullName == option) {
        familyController.userId.value = Get.find<FriendController>().friendListForAddFamily[i].id!;
      }
    }
  }

  void addSearchResultToFamilyList() {
    if (globalController.searchController.text.trim() != '') {
      familyController.isFamilySuffixIconVisible.value = true;
    } else {
      familyController.isFamilySuffixIconVisible.value = false;
    }
    for (int i = 0; i < Get.find<FriendController>().temporaryFriendList.length; i++) {
      if (Get.find<FriendController>().temporaryFriendList[i] == globalController.searchController.text.trim()) {
        familyController.userId.value = Get.find<FriendController>().friendList[i].id!;
      } else {
        familyController.userId.value = -1;
      }
    }
  }
}
