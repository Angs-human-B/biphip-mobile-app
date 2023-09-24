import 'dart:io';

import 'package:bip_hip/utils/constants/imports.dart';

class CreatePostController extends GetxController {
  // final ApiController _apiController = ApiController();
  // final SpController _spController = SpController();
  final GlobalController _globalController = Get.find<GlobalController>();

  final RxBool isPostButtonActive = RxBool(false);
  final RxBool isTextLimitCrossed = RxBool(false);
  final TextEditingController createPostTEController = TextEditingController();
  final RxString postType = RxString('Public');
  final Rx<IconData> postTypeIcon = Rx<IconData>(BipHip.world);
  final RxString category = RxString('');
  final Rx<IconData?> categoryIcon = Rx<IconData?>(null);
  final Rx<Color?> categoryIconColor = Rx<Color?>(null);
  final RxBool isTagAdded = RxBool(false);
  final RxInt selectedBidIndex = RxInt(-1);
  final TextEditingController bidingTextEditingController = TextEditingController();

  // image and video picker variables
  final RxString createPostImageLink = RxString('');
  final Rx<File?> createPostImageFile = File('').obs;
  final RxBool isCreatePostImageChanged = RxBool(false);

  final RxString createPostVideoLink = RxString('');
  final Rx<File?> createPostVideoFile = File('').obs;
  final RxBool isCreatePostVideoChanged = RxBool(false);

  final RxList<RxString> mediaLinkList = RxList<RxString>([]);
  final RxList<Rx<File?>> mediaFileList = RxList<Rx<File?>>([]);
  final RxBool isMediaChanged = RxBool(false);

  void postButtonStateCheck() {
    if (createPostTEController.text.trim().isNotEmpty) {
      isPostButtonActive.value = true;
      if (createPostTEController.text.length > 150) {
        isTextLimitCrossed.value = true;
      } else {
        isTextLimitCrossed.value = false;
      }
    } else {
      isPostButtonActive.value = false;
    }
  }

  final RxList audienceStatusList = RxList([true, false, false]);

  final List audienceTypeList = [
    {
      "title": "Public",
      "subtitle": "Anyone from BipHip",
      "icon": BipHip.world,
    },
    {
      "title": "Friends",
      "subtitle": "Your friends from BipHip",
      "icon": BipHip.friends,
    },
    {
      "title": "Only me",
      "subtitle": "Only you can see",
      "icon": BipHip.lock,
    },
  ];

  final List categoryList = [
    {
      "title": "Poetry",
      "icon": BipHip.poetry,
      "icon_color": cPoetryColor,
    },
    {
      "title": "Painting",
      "icon": BipHip.painting,
      "icon_color": cPaintingColor,
    },
    {
      "title": "Kids",
      "icon": BipHip.kids,
      "icon_color": cKidsColor,
    },
    {
      "title": "Storytelling",
      "icon": BipHip.storytelling,
      "icon_color": cStoryTellingColor,
    },
    {
      "title": "Photography",
      "icon": BipHip.photography,
      "icon_color": cPhotographyColor,
    },
    {
      "title": "News",
      "icon": BipHip.newsFill, // todo:: icon will be changed
      "icon_color": cBlackColor,
    },
    {
      "title": "Selling",
      "icon": BipHip.selling,
      "icon_color": cSellingColor,
    },
  ];

  final RxList categoryStatusList = RxList([false, false, false, false, false, false, false]);

  final List tagFiendList = [
    {
      "name": "Takin Ahmed",
      "image_url": kiGoogleImageUrl,
    },
    {
      "name": "Takin Ahmed",
      "image_url": kiGoogleImageUrl,
    },
    {
      "name": "Takin Ahmed",
      "image_url": kiGoogleImageUrl,
    },
    {
      "name": "Takin Ahmed",
      "image_url": kiGoogleImageUrl,
    },
    {
      "name": "Takin Ahmed",
      "image_url": kiGoogleImageUrl,
    },
    {
      "name": "Takin Ahmed",
      "image_url": kiGoogleImageUrl,
    },
    {
      "name": "Takin Ahmed",
      "image_url": kiGoogleImageUrl,
    },
    {
      "name": "Takin Ahmed",
      "image_url": kiGoogleImageUrl,
    },
    {
      "name": "Takin Ahmed",
      "image_url": kiGoogleImageUrl,
    },
  ];

//------------------------------
//! important:: create post related functions start
//------------------------------

  void selectAudienceStatusChange(index) {
    for (int i = 0; i < audienceStatusList.length; i++) {
      if (index == i) {
        audienceStatusList[i] = true;
      } else {
        audienceStatusList[i] = false;
      }
    }
  }

  void selectAudienceTextChange() {
    for (int i = 0; i < audienceTypeList.length; i++) {
      if (audienceStatusList[i]) {
        postType.value = audienceTypeList[i]['title'];
        postTypeIcon.value = audienceTypeList[i]['icon'];
        break;
      }
    }
  }

  void initializeAudienceText() {
    for (int i = 0; i < audienceStatusList.length; i++) {
      if (audienceTypeList[i]['title'] == postType.value) {
        audienceStatusList[i] = true;
      } else {
        audienceStatusList[i] = false;
      }
    }
  }

  void showAudienceSheet(context) {
    Get.find<GlobalController>().commonBottomSheet(
      bottomSheetHeight: height * .51,
      context: context,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Who can see your post?",
            style: semiBold16TextStyle(cBlackColor),
          ),
          kH8sizedBox,
          Text(
            "Your post will appear in feed, on your profile and in search results. Your default audience is set to Public, but you can change the audience of this specific post.",
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
                  itemColor: audienceStatusList[i - 1] ? cPrimaryTint3Color : cWhiteColor,
                  title: audienceTypeList[i - 1]['title'],
                  subtitle: audienceTypeList[i - 1]['subtitle'],
                  leading: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: cNeutralColor,
                    ),
                    height: h28,
                    width: h28,
                    child: Icon(
                      audienceTypeList[i - 1]['icon'],
                      color: cBlackColor,
                      size: isDeviceScreenLarge() ? h18 : h14,
                    ),
                  ),
                  trailing: CustomRadioButton(
                    onChanged: () {
                      selectAudienceStatusChange(i - 1);
                    },
                    isSelected: audienceStatusList[i - 1],
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
      rightText: "Done",
      rightTextStyle: medium14TextStyle(cPrimaryColor),
      title: "Edit Audience",
      isRightButtonShow: true,
    );
  }

  void selectCategoryStatusChange(index) {
    for (int i = 0; i < categoryStatusList.length; i++) {
      if (index == i) {
        categoryStatusList[i] = true;
      } else {
        categoryStatusList[i] = false;
      }
    }
  }

  void selectCategoryTextChange() {
    for (int i = 0; i < categoryList.length; i++) {
      if (categoryStatusList[i]) {
        category.value = categoryList[i]['title'];
        categoryIcon.value = categoryList[i]['icon'];
        categoryIconColor.value = categoryList[i]['icon_color'];
        break;
      }
    }
  }

  void initializeCategory() {
    for (int i = 0; i < 3; i++) {
      if (categoryList[i]['title'] == category.value) {
        categoryStatusList[i] = true;
      } else {
        categoryStatusList[i] = false;
      }
    }
  }

  void resetCategoryData() {
    category.value = "";
    categoryIcon.value = null;
    categoryIconColor.value = null;
  }

//------------------------------
//! important:: create post related functions end
//------------------------------
//------------------------------
//! important:: create post bottom option functions start
//------------------------------
  void getBottomRowOnPressed(index, [context]) {
    if (index == 1) {
      _globalController.selectMultiMediaSource(isMediaChanged, mediaLinkList, mediaFileList);
    }
    if (index == 2) {
      _globalController.selectImageSource(isCreatePostImageChanged, createPostImageLink, createPostImageFile, 'camera', false);
    }
    if (index == 3) {
      _globalController.selectVideoSource(isCreatePostVideoChanged, createPostVideoLink, createPostVideoFile, 'camera');
    } else {
      _globalController.commonBottomSheet(
        isScrollControlled: true,
        context: context,
        isSearchShow: true,
        content: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tagFiendList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: k10Padding),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(k8BorderRadius),
                  child: TextButton(
                    style: kTextButtonStyle,
                    onPressed: () async {
                      // ll(index);
                    },
                    child: CustomListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(tagFiendList[index]["image_url"]),
                      ),
                      title: tagFiendList[index]["name"],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        onPressCloseButton: () {
          Get.back();
        },
        onPressRightButton: () {},
        rightText: "Done",
        rightTextStyle: medium14TextStyle(cPrimaryColor),
        title: "Tag People",
        isRightButtonShow: true,
      );
    }
  }

  IconData getBottomRowIcon(index) {
    if (index == 1) {
      return BipHip.photo;
    }
    if (index == 2) {
      return BipHip.camera;
    }
    if (index == 3) {
      return BipHip.video;
    } else {
      return BipHip.tagFriends;
    }
  }

  Color getBottomIconColor(index) {
    if (index == 1) {
      return cGreenColor;
    }
    if (index == 2) {
      return cPrimaryColor;
    }
    if (index == 3) {
      return cRedColor;
    } else {
      return cSecondaryColor;
    }
  }
}

//------------------------------
//! important:: create post bottom option functions end
//------------------------------
