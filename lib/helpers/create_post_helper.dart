import 'dart:io';

import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class CreatePostHelper{
  final CreatePostController _createPostController = Get.find<CreatePostController>();

  void selectAudienceStatusChange(index) {
    for (int i = 0; i < _createPostController.audienceStatusList.length; i++) {
      if (index == i) {
        _createPostController.audienceStatusList[i] = true;
      } else {
        _createPostController.audienceStatusList[i] = false;
      }
    }
  }

  void selectAudienceTextChange() {
    for (int i = 0; i < _createPostController.audienceTypeList.length; i++) {
      if (_createPostController.audienceStatusList[i]) {
        _createPostController.postType.value = _createPostController.audienceTypeList[i]['title'];
        _createPostController.postTypeIcon.value = _createPostController.audienceTypeList[i]['icon'];
        break;
      }
    }
  }

  void initializeAudienceText() {
    for (int i = 0; i < _createPostController.audienceStatusList.length; i++) {
      if (_createPostController.audienceTypeList[i]['title'] == _createPostController.postType.value) {
        _createPostController.audienceStatusList[i] = true;
      } else {
        _createPostController.audienceStatusList[i] = false;
      }
    }
  }

  void selectCategoryStatusChange(index) {
    for (int i = 0; i < _createPostController.categoryStatusList.length; i++) {
      if (index == i) {
        _createPostController.categoryStatusList[i] = true;
      } else {
        _createPostController.categoryStatusList[i] = false;
      }
    }
  }
  //------------------------------
//! important:: create post bottom option functions end
//------------------------------

  void showAudienceSheet(context) {
    Get.find<GlobalController>().commonBottomSheet(
      bottomSheetHeight: height * .51,
      context: context,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${ksWhoCanSeeYourPost.tr}?",
            style: semiBold16TextStyle(cBlackColor),
          ),
          kH8sizedBox,
          Text(
            ksAudienceInformation.tr,
            style: regular14TextStyle(cBlackColor),
          ),
          kH8sizedBox,
          for (int i = 1; i <= 3; i++)
            Padding(
              padding: EdgeInsets.only(bottom: i == 3 ? 0.0 : 8.0),
              child: Obx(
                () => CustomListTile(
                  onPressed: () {
                    selectAudienceStatusChange(i - 1);
                  },
                  itemColor: _createPostController.audienceStatusList[i - 1] ? cPrimaryTint3Color : cWhiteColor,
                  title: _createPostController.audienceTypeList[i - 1]['title'],
                  subtitle: _createPostController.audienceTypeList[i - 1]['subtitle'],
                  leading: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: cNeutralColor,
                    ),
                    height: h28,
                    width: h28,
                    child: Icon(
                      _createPostController.audienceTypeList[i - 1]['icon'],
                      color: cBlackColor,
                      size: isDeviceScreenLarge() ? h18 : h14,
                    ),
                  ),
                  trailing: CustomRadioButton(
                    onChanged: () {
                      selectAudienceStatusChange(i - 1);
                    },
                    isSelected: _createPostController.audienceStatusList[i - 1],
                  ),
                ),
              ),
            ),
        ],
      ),
      onPressCloseButton: () {
        Get.back();
      },
      onPressRightButton: () {
        ll("message");
        selectAudienceTextChange();
        Get.back();
      },
      rightText: ksDone.tr,
      rightTextStyle: medium14TextStyle(cPrimaryColor),
      title: ksEditAudience.tr,
      isRightButtonShow: true,
    );
  }

   void initializeCategory() {
    for (int i = 0; i < _createPostController.categoryList.length; i++) {
      if (_createPostController.categoryList[i]['title'] == _createPostController.category.value) {
        _createPostController.categoryStatusList[i] = true;
      } else {
        _createPostController.categoryStatusList[i] = false;
      }
    }
  }

  void selectPlatformStatusChange(index) {
    for (int i = 0; i < _createPostController.platformStatusList.length; i++) {
      if (index == i) {
        _createPostController.platformStatusList[i] = true;
      } else {
        _createPostController.platformStatusList[i] = false;
      }
    }
  }
  void selectPlatformTextChange(context) {
    for (int i = 0; i < _createPostController.platformList.length; i++) {
      if (_createPostController.platformStatusList[i]) {
        // categoryID.value = categoryList[i]['id'];
        // category.value = categoryList[i]['title'];
        // categoryIcon.value = categoryList[i]['icon'];
        // categoryIconColor.value = categoryList[i]['icon_color'];
        break;
      }
    }
    // ll(categoryID);
    Get.back();
  }

  void initializePlatform() {
    for (int i = 0; i < _createPostController.platformList.length; i++) {
      if (_createPostController.platformList[i]['title'] == _createPostController.category.value) {
        _createPostController.platformStatusList[i] = true;
      } else {
        _createPostController.platformStatusList[i] = false;
      }
    }
  }

  void selectActionStatusChange(index) {
    for (int i = 0; i < _createPostController.actionStatusList.length; i++) {
      if (index == i) {
        _createPostController.actionStatusList[i] = true;
      } else {
        _createPostController.actionStatusList[i] = false;
      }
    }
  }

  void initializeAction() {
    for (int i = 0; i < _createPostController.actionList.length; i++) {
      if (_createPostController.actionList[i]['title'] == _createPostController.category.value) {
        _createPostController.actionStatusList[i] = true;
      } else {
        _createPostController.actionStatusList[i] = false;
      }
    }
  }

  void selectKidStatusChange(index) {
    for (int i = 0; i < _createPostController.selectedKidStatusList.length; i++) {
      if (index == i) {
        _createPostController.selectedKidStatusList[i] = true;
      } else {
        _createPostController.selectedKidStatusList[i] = false;
      }
    }
  }

   void selectBrandTextChange() {
    for (int i = 0; i < _createPostController.brandList.length; i++) {
      if (_createPostController.selectedBrandStatusList[i]) {
        _createPostController.selectedBrandName.value = _createPostController.brandList[i]['name'];
        _createPostController.selectedBrandImage.value = _createPostController.brandList[i]['image_url'];
        break;
      }
    }
  }

  void initializeBrandText() {
    for (int i = 0; i < _createPostController.selectedBrandStatusList.length; i++) {
      if (_createPostController.brandList[i]['name'] == _createPostController.selectedBrandName.value) {
        _createPostController.selectedBrandStatusList[i] = true;
      } else {
        _createPostController.selectedBrandStatusList[i] = false;
      }
    }
  }

  void resetCategoryData() {
    _createPostController.category.value = "";
    _createPostController.categoryIcon.value = null;
    _createPostController.categoryIconColor.value = null;
  }

   void resetAddBrandPage() {
    _createPostController.brandImageLink.value = '';
    _createPostController.brandImageFile.value = File('');
    _createPostController.isBrandImageChanged.value = false;
    _createPostController.isSaveBrandButtonEnabled.value = false;
    _createPostController.brandNameTextEditingController.clear();
    _createPostController.brandWebLinkTextEditingController.clear();
    _createPostController.brandFacebookLinkTextEditingController.clear();
    _createPostController.brandTwitterTextEditingController.clear();
    _createPostController.brandLinkedInLinkTextEditingController.clear();
    _createPostController.brandYoutubeLinkTextEditingController.clear();
  }
}