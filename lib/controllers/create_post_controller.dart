import 'dart:io';

import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/create_post/add_brand.dart';
import 'package:bip_hip/views/create_post/add_kid.dart';
import 'package:bip_hip/widgets/common/custom_outline_button.dart';

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

  final RxString selectedKidName = RxString('');
  final RxString selectedKidImage = RxString('');

  final RxString selectedBrandName = RxString('');
  final RxString selectedBrandImage = RxString('');

  // image and video picker variables
  final RxString createPostImageLink = RxString('');
  final RxList<Rx<File>> createPostImageFile = RxList<Rx<File>>([]);
  final RxBool isCreatePostImageChanged = RxBool(false);

  final RxString createPostVideoLink = RxString('');
  final RxList<Rx<File>> createPostVideoFile = RxList<Rx<File>>([]);
  final RxBool isCreatePostVideoChanged = RxBool(false);

  final RxList<RxString> mediaLinkList = RxList<RxString>([]);
  final RxList<Rx<File>> mediaFileList = RxList<Rx<File>>([]);
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
      "image_url": kiLogoImageUrl,
    },
    {
      "name": "Takin Ahmed",
      "image_url": kiLogoImageUrl,
    },
    {
      "name": "Takin Ahmed",
      "image_url": kiLogoImageUrl,
    },
    {
      "name": "Takin Ahmed",
      "image_url": kiLogoImageUrl,
    },
    {
      "name": "Takin Ahmed",
      "image_url": kiLogoImageUrl,
    },
    {
      "name": "Takin Ahmed",
      "image_url": kiLogoImageUrl,
    },
    {
      "name": "Takin Ahmed",
      "image_url": kiLogoImageUrl,
    },
    {
      "name": "Takin Ahmed",
      "image_url": kiLogoImageUrl,
    },
    {
      "name": "Takin Ahmed",
      "image_url": kiLogoImageUrl,
    },
  ];

  final RxList selectedKidStatusList = RxList([false, false, false, false, false, false, false, false, false]);
  final List kidList = [
    {
      "name": "Takin Ahmed 1",
      "image_url": kiLogoImageUrl,
    },
    {
      "name": "Takin Ahmed 2",
      "image_url": kiLogoImageUrl,
    },
    {
      "name": "Takin Ahmed 3",
      "image_url": kiLogoImageUrl,
    },
    {
      "name": "Takin Ahmed 4",
      "image_url": kiLogoImageUrl,
    },
    {
      "name": "Takin Ahmed 5",
      "image_url": kiLogoImageUrl,
    },
    {
      "name": "Takin Ahmed 6",
      "image_url": kiLogoImageUrl,
    },
    {
      "name": "Takin Ahmed 7",
      "image_url": kiLogoImageUrl,
    },
    {
      "name": "Takin Ahmed 8",
      "image_url": kiLogoImageUrl,
    },
    {
      "name": "Takin Ahmed 9",
      "image_url": kiLogoImageUrl,
    },
  ];
  final RxList selectedBrandStatusList = RxList([false, false, false, false, false, false, false, false, false]);
  final List brandList = [
    {
      "name": "Takin Ahmed 1",
      "image_url": kiLogoImageUrl,
    },
    {
      "name": "Takin Ahmed 2",
      "image_url": kiLogoImageUrl,
    },
    {
      "name": "Takin Ahmed 3",
      "image_url": kiLogoImageUrl,
    },
    {
      "name": "Takin Ahmed 4",
      "image_url": kiLogoImageUrl,
    },
    {
      "name": "Takin Ahmed 5",
      "image_url": kiLogoImageUrl,
    },
    {
      "name": "Takin Ahmed 6",
      "image_url": kiLogoImageUrl,
    },
    {
      "name": "Takin Ahmed 7",
      "image_url": kiLogoImageUrl,
    },
    {
      "name": "Takin Ahmed 8",
      "image_url": kiLogoImageUrl,
    },
    {
      "name": "Takin Ahmed 9",
      "image_url": kiLogoImageUrl,
    },
  ];

  final RxList allMediaList = RxList([]);
  final RxList<Rx<File>> allMediaFileList = RxList<Rx<File>>([]);
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

  void selectCategoryStatusChange(index) {
    for (int i = 0; i < categoryStatusList.length; i++) {
      if (index == i) {
        categoryStatusList[i] = true;
      } else {
        categoryStatusList[i] = false;
      }
    }
  }

  void selectCategoryTextChange(context) {
    for (int i = 0; i < categoryList.length; i++) {
      if (categoryStatusList[i]) {
        category.value = categoryList[i]['title'];
        categoryIcon.value = categoryList[i]['icon'];
        categoryIconColor.value = categoryList[i]['icon_color'];
        break;
      }
    }
    if (category.value == "Kids") {
      _globalController.commonBottomSheet(
        context: context,
        content: Column(
          children: [
            kH8sizedBox,
            OutLinedButton(
              onPress: () {
                _globalController.commonBottomSheet(
                  isScrollControlled: true,
                  bottomSheetHeight: height * .7,
                  context: context,
                  content: Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => kH8sizedBox,
                        itemCount: kidList.length,
                        itemBuilder: (context, i) {
                          return Obx(
                            () => CustomListTile(
                              onPressed: () {
                                selectKidStatusChange(i);
                              },
                              itemColor: selectedKidStatusList[i] ? cPrimaryTint3Color : cWhiteColor,
                              borderColor: selectedKidStatusList[i] ? cPrimaryColor : cLineColor,
                              title: kidList[i]['name'],
                              leading: CircleAvatar(
                                radius: 12,
                                backgroundImage: AssetImage(kidList[i]['image_url']),
                              ),
                              trailing: CustomRadioButton(
                                onChanged: () {
                                  selectKidStatusChange(i);
                                },
                                isSelected: selectedKidStatusList[i],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  onPressCloseButton: () {
                    Get.back();
                  },
                  onPressRightButton: null,
                  rightText: 'Done',
                  rightTextStyle: medium14TextStyle(cPrimaryColor),
                  title: "Select Kids",
                  isRightButtonShow: true,
                );
              },
              buttonText: "Select Kids",
              buttonTextStyle: medium16TextStyle(cBlackColor),
              borderColor: cLineColor,
              widget: Icon(
                BipHip.downArrowOutline,
                color: cBlackColor,
                size: isDeviceScreenLarge() ? h20 : h16,
              ),
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            // kH12sizedBox,
            // OutLinedButton(
            //   onPress: () {},
            //   buttonText: "Maria Jones",
            //   buttonTextStyle: medium16TextStyle(cBlackColor),
            //   borderColor: cPrimaryColor,
            //   buttonColor: cPrimaryTint3Color,
            //   widget: Icon(
            //     BipHip.circleCrossNew,
            //     color: cRedColor,
            //     size: isDeviceScreenLarge() ? h20 : h18,
            //   ),
            //   backgroundImage: const NetworkImage("http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg"),
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // ),
            kH12sizedBox,
            Text(
              "Or",
              style: regular16TextStyle(cPlaceHolderColor),
            ),
            kH12sizedBox,
            OutLinedButton(
              onPress: () {
                Get.to(() => AddKidPage());
              },
              buttonText: "Add Kid",
              buttonTextStyle: medium16TextStyle(cPrimaryColor),
              borderColor: cPrimaryColor,
              widget: Icon(
                BipHip.plus,
                color: cPrimaryColor,
                size: isDeviceScreenLarge() ? h20 : h16,
              ),
            ),
            kH8sizedBox,
            Text(
              "*If you don’t have any kid added in system, use ‘Custom Add’ to post directly with kid’s details.",
              style: regular14TextStyle(cSmallBodyTextColor),
            ),
          ],
        ),
        onPressCloseButton: () {
          Get.back();
        },
        onPressRightButton: null,
        rightText: 'Done',
        rightTextStyle: medium14TextStyle(cPrimaryColor),
        title: "Kids",
        isRightButtonShow: true,
      );
    } else if (category.value == "Selling") {
      _globalController.commonBottomSheet(
        context: context,
        content: Column(
          children: [
            kH8sizedBox,
            OutLinedButton(
              onPress: () {
                _globalController.commonBottomSheet(
                  isScrollControlled: true,
                  bottomSheetHeight: height * .7,
                  context: context,
                  content: Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => kH8sizedBox,
                        itemCount: brandList.length,
                        itemBuilder: (context, i) {
                          return Obx(
                            () => CustomListTile(
                              onPressed: () {
                                selectBrandStatusChange(i);
                              },
                              itemColor: selectedBrandStatusList[i] ? cPrimaryTint3Color : cWhiteColor,
                              borderColor: selectedBrandStatusList[i] ? cPrimaryColor : cLineColor,
                              title: brandList[i]['name'],
                              leading: CircleAvatar(
                                radius: 12,
                                backgroundImage: AssetImage(brandList[i]['image_url']),
                              ),
                              trailing: CustomRadioButton(
                                onChanged: () {
                                  selectBrandStatusChange(i);
                                },
                                isSelected: selectedBrandStatusList[i],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  onPressCloseButton: () {
                    Get.back();
                  },
                  onPressRightButton: null,
                  rightText: 'Done',
                  rightTextStyle: medium14TextStyle(cPrimaryColor),
                  title: "Select Kids",
                  isRightButtonShow: true,
                );
              },
              buttonText: "Select Saved Brand",
              buttonTextStyle: medium16TextStyle(cBlackColor),
              borderColor: cLineColor,
              widget: Icon(
                BipHip.downArrowOutline,
                color: cBlackColor,
                size: isDeviceScreenLarge() ? h20 : h16,
              ),
            ),
            // kH12sizedBox,
            // OutLinedButton(
            //   onPress: () {},
            //   buttonText: "Maria Jones",
            //   buttonTextStyle: medium16TextStyle(cBlackColor),
            //   borderColor: cPrimaryColor,
            //   buttonColor: cPrimaryTint3Color,
            //   widget: Icon(
            //     BipHip.circleCrossNew,
            //     color: cRedColor,
            //     size: isDeviceScreenLarge() ? h20 : h18,
            //   ),
            //   backgroundImage: const NetworkImage("http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg"),
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // ),
            kH12sizedBox,
            Text(
              "Or",
              style: regular16TextStyle(cPlaceHolderColor),
            ),
            kH12sizedBox,
            OutLinedButton(
              onPress: () {
                Get.to(() => AddBrandPage());
              },
              buttonText: "Add Brand",
              buttonTextStyle: medium16TextStyle(cPrimaryColor),
              borderColor: cPrimaryColor,
              widget: Icon(
                BipHip.plus,
                color: cPrimaryColor,
                size: isDeviceScreenLarge() ? h20 : h16,
              ),
            ),
            kH8sizedBox,
            Text(
              "*Please add your own brand to promote and grow your business.",
              style: regular14TextStyle(cSmallBodyTextColor),
            ),
          ],
        ),
        onPressCloseButton: null,
        onPressRightButton: null,
        rightText: 'Done',
        rightTextStyle: medium14TextStyle(cPlaceHolderColor),
        title: " Brands",
        isRightButtonShow: true,
      );
    } else if (category.value == "News") {
    } else {
      Get.back();
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

  void selectKidStatusChange(index) {
    for (int i = 0; i < selectedKidStatusList.length; i++) {
      if (index == i) {
        selectedKidStatusList[i] = true;
      } else {
        selectedKidStatusList[i] = false;
      }
    }
  }

  void selectKidTextChange() {
    for (int i = 0; i < kidList.length; i++) {
      if (selectedKidStatusList[i]) {
        selectedKidName.value = kidList[i]['name'];
        selectedKidImage.value = kidList[i]['image_url'];
        break;
      }
    }
  }

  void initializeKidText() {
    for (int i = 0; i < selectedKidStatusList.length; i++) {
      if (kidList[i]['name'] == selectedKidName.value) {
        selectedKidStatusList[i] = true;
      } else {
        selectedKidStatusList[i] = false;
      }
    }
  }

  void selectBrandStatusChange(index) {
    for (int i = 0; i < selectedBrandStatusList.length; i++) {
      if (index == i) {
        selectedBrandStatusList[i] = true;
      } else {
        selectedBrandStatusList[i] = false;
      }
    }
  }

  void selectBrandTextChange() {
    for (int i = 0; i < brandList.length; i++) {
      if (selectedBrandStatusList[i]) {
        selectedBrandName.value = brandList[i]['name'];
        selectedBrandImage.value = brandList[i]['image_url'];
        break;
      }
    }
  }

  void initializeBrandText() {
    for (int i = 0; i < selectedBrandStatusList.length; i++) {
      if (brandList[i]['name'] == selectedBrandName.value) {
        selectedBrandStatusList[i] = true;
      } else {
        selectedBrandStatusList[i] = false;
      }
    }
  }

  void resetCategoryData() {
    category.value = "";
    categoryIcon.value = null;
    categoryIconColor.value = null;
  }

  void insertMedia(mediaLink, mediaFile) {
    allMediaList.addAll(mediaLink);
    allMediaFileList.addAll(mediaFile);
    ll(allMediaFileList);
    // ll(allMediaList);
  }

  void removeMedia(index) {
    allMediaList.removeAt(index);
    allMediaFileList.removeAt(index);
  }

  void resetData() {
    isMediaChanged.value = false;
    mediaLinkList.clear();
    mediaFileList.clear();
    isCreatePostImageChanged.value = false;
    createPostImageLink.value = "";
    createPostImageFile.clear();
    isCreatePostVideoChanged.value = false;
    createPostVideoLink.value = "";
    createPostVideoFile.clear();

    allMediaList.clear();
    allMediaFileList.clear();
  }

//------------------------------
//! important:: create post related functions end
//------------------------------
//------------------------------
//! important:: create post bottom option functions start
//------------------------------
  void getBottomRowOnPressed(index, [context]) async {
    ll(index);
    if (index == 1) {
      var status = await _globalController.selectMultiMediaSource(isMediaChanged, mediaLinkList, mediaFileList);
      if (status) {
        ll("media list length : ${mediaLinkList.length}");
        insertMedia(mediaLinkList, mediaFileList);
        isMediaChanged.value = false;
        mediaLinkList.clear();
        mediaFileList.clear();
      }
    } else if (index == 2) {
      var status = await _globalController.selectImageSource(isCreatePostImageChanged, createPostImageLink, createPostImageFile, 'camera', false, true);
      if (status) {
        insertMedia([createPostImageLink], createPostImageFile);
        isCreatePostImageChanged.value = false;
        createPostImageLink.value = "";
        createPostImageFile.clear();
      }
    } else if (index == 3) {
      var status = await _globalController.selectVideoSource(isCreatePostVideoChanged, createPostVideoLink, createPostVideoFile, 'camera', true);
      if (status) {
        insertMedia([createPostVideoLink], createPostVideoFile);
        isCreatePostVideoChanged.value = false;
        createPostVideoLink.value = "";
        createPostVideoFile.clear();
      }
    } else {
      _globalController.commonBottomSheet(
        isScrollControlled: true,
        bottomSheetHeight: height * .9,
        context: context,
        isSearchShow: true,
        content: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: k2Padding),
                child: Text(
                  "Selected",
                  style: semiBold14TextStyle(cBlackColor),
                ),
              ),
              kH8sizedBox,
              Container(
                color: cWhiteColor,
                height: 40,
                width: width,
                child: ListView.separated(
                  separatorBuilder: (context, index) => kW8sizedBox,
                  scrollDirection: Axis.horizontal,
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(tagFiendList[index]["image_url"]),
                        ),
                        Positioned(
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: cWhiteColor,
                            ),
                            child: const Icon(
                              BipHip.circleCrossNew,
                              size: 12,
                              color: cRedColor,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              kH12sizedBox,
              Padding(
                padding: const EdgeInsets.only(left: k2Padding),
                child: Text(
                  "SUGGESTION",
                  style: regular14TextStyle(cSmallBodyTextColor),
                ),
              ),
              kH8sizedBox,
              ListView.builder(
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
                          padding: const EdgeInsets.symmetric(horizontal: k0Padding, vertical: k4Padding),
                          // borderColor: cRedColor,
                          leading: CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(tagFiendList[index]["image_url"]),
                          ),
                          title: tagFiendList[index]["name"],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
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
}
