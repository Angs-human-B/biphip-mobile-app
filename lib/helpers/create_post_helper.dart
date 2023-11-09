import 'dart:io';
import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class CreatePostHelper{
  final CreatePostController createPostController = Get.find<CreatePostController>();

  void selectAudienceStatusChange(index) {
    for (int i = 0; i < createPostController.audienceStatusList.length; i++) {
      if (index == i) {
        createPostController.audienceStatusList[i] = true;
      } else {
        createPostController.audienceStatusList[i] = false;
      }
    }
  }

  void selectAudienceTextChange() {
    for (int i = 0; i < createPostController.audienceTypeList.length; i++) {
      if (createPostController.audienceStatusList[i]) {
        createPostController.postType.value = createPostController.audienceTypeList[i]['title'];
        createPostController.postTypeIcon.value = createPostController.audienceTypeList[i]['icon'];
        break;
      }
    }
  }

  void initializeAudienceText() {
    for (int i = 0; i < createPostController.audienceStatusList.length; i++) {
      if (createPostController.audienceTypeList[i]['title'] == createPostController.postType.value) {
        createPostController.audienceStatusList[i] = true;
      } else {
        createPostController.audienceStatusList[i] = false;
      }
    }
  }

  void selectCategoryStatusChange(index) {
    for (int i = 0; i < createPostController.categoryStatusList.length; i++) {
      if (index == i) {
        createPostController.categoryStatusList[i] = true;
      } else {
        createPostController.categoryStatusList[i] = false;
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
                  itemColor: createPostController.audienceStatusList[i - 1] ? cPrimaryTint3Color : cWhiteColor,
                  title: createPostController.audienceTypeList[i - 1]['title'],
                  subtitle: createPostController.audienceTypeList[i - 1]['subtitle'],
                  leading: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: cNeutralColor,
                    ),
                    height: h28,
                    width: h28,
                    child: Icon(
                      createPostController.audienceTypeList[i - 1]['icon'],
                      color: cBlackColor,
                      size: isDeviceScreenLarge() ? h18 : h14,
                    ),
                  ),
                  trailing: CustomRadioButton(
                    onChanged: () {
                      selectAudienceStatusChange(i - 1);
                    },
                    isSelected: createPostController.audienceStatusList[i - 1],
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
    for (int i = 0; i < createPostController.categoryList.length; i++) {
      if (createPostController.categoryList[i]['title'] == createPostController.category.value) {
        createPostController.categoryStatusList[i] = true;
      } else {
        createPostController.categoryStatusList[i] = false;
      }
    }
  }

  void selectPlatformStatusChange(index) {
    for (int i = 0; i < createPostController.platformStatusList.length; i++) {
      if (index == i) {
        createPostController.platformStatusList[i] = true;
      } else {
        createPostController.platformStatusList[i] = false;
      }
    }
  }
  void selectPlatformTextChange(context) {
    for (int i = 0; i < createPostController.platformList.length; i++) {
      if (createPostController.platformStatusList[i]) {
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
    for (int i = 0; i < createPostController.platformList.length; i++) {
      if (createPostController.platformList[i]['title'] == createPostController.category.value) {
        createPostController.platformStatusList[i] = true;
      } else {
        createPostController.platformStatusList[i] = false;
      }
    }
  }

  void selectActionStatusChange(index) {
    for (int i = 0; i < createPostController.actionStatusList.length; i++) {
      if (index == i) {
        createPostController.actionStatusList[i] = true;
      } else {
        createPostController.actionStatusList[i] = false;
      }
    }
  }

  void initializeAction() {
    for (int i = 0; i < createPostController.actionList.length; i++) {
      if (createPostController.actionList[i]['title'] == createPostController.category.value) {
        createPostController.actionStatusList[i] = true;
      } else {
        createPostController.actionStatusList[i] = false;
      }
    }
  }

  void selectKidStatusChange(index) {
    for (int i = 0; i < createPostController.selectedKidStatusList.length; i++) {
      if (index == i) {
        createPostController.selectedKidStatusList[i] = true;
      } else {
        createPostController.selectedKidStatusList[i] = false;
      }
    }
  }

   void selectBrandTextChange() {
    for (int i = 0; i < createPostController.brandList.length; i++) {
      if (createPostController.selectedBrandStatusList[i]) {
        createPostController.selectedBrandName.value = createPostController.brandList[i]['name'];
        createPostController.selectedBrandImage.value = createPostController.brandList[i]['image_url'];
        break;
      }
    }
  }

  void initializeBrandText() {
    for (int i = 0; i < createPostController.selectedBrandStatusList.length; i++) {
      if (createPostController.brandList[i]['name'] == createPostController.selectedBrandName.value) {
        createPostController.selectedBrandStatusList[i] = true;
      } else {
        createPostController.selectedBrandStatusList[i] = false;
      }
    }
  }

  void resetCategoryData() {
    createPostController.category.value = "";
    createPostController.categoryIcon.value = null;
    createPostController.categoryIconColor.value = null;
  }

   void resetAddBrandPage() {
    createPostController.brandImageLink.value = '';
    createPostController.brandImageFile.value = File('');
    createPostController.isBrandImageChanged.value = false;
    createPostController.isSaveBrandButtonEnabled.value = false;
    createPostController.brandNameTextEditingController.clear();
    createPostController.brandWebLinkTextEditingController.clear();
    createPostController.brandFacebookLinkTextEditingController.clear();
    createPostController.brandTwitterTextEditingController.clear();
    createPostController.brandLinkedInLinkTextEditingController.clear();
    createPostController.brandYoutubeLinkTextEditingController.clear();
  }
}