import 'dart:convert';
import 'dart:io';
import 'package:bip_hip/models/create_post/kid_model.dart';
import 'package:bip_hip/models/menu/profile/common_list_models.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/create_post/add_brand.dart';
import 'package:bip_hip/views/create_post/add_kid.dart';
import 'package:bip_hip/views/create_post/select_category.dart';
import 'package:bip_hip/widgets/common/button/custom_outline_button.dart';

class CreatePostController extends GetxController {
  final ApiController _apiController = ApiController();
  final SpController _spController = SpController();
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
  final RxString postSecondaryCircleAvatar = RxString('');
  final Rx<File> postSecondaryLocalCirclerAvatar = File('').obs;

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
      "id": '',
      "name": '',
      "title": "Poetry",
      "icon": BipHip.poetry,
      "icon_color": cPoetryColor,
    },
    {
      "id": '',
      "name": '',
      "title": "Painting",
      "icon": BipHip.painting,
      "icon_color": cPaintingColor,
    },
    {
      "id": '',
      "name": '',
      "title": "Kids",
      "icon": BipHip.kids,
      "icon_color": cKidsColor,
    },
    {
      "id": '',
      "name": '',
      "title": "Storytelling",
      "icon": BipHip.storytelling,
      "icon_color": cStoryTellingColor,
    },
    {
      "id": '',
      "name": '',
      "title": "Photography",
      "icon": BipHip.photography,
      "icon_color": cPhotographyColor,
    },
    {
      "id": '',
      "name": '',
      "title": "News",
      "icon": BipHip.newsFill, // todo:: icon will be changed
      "icon_color": cBlackColor,
    },
    {
      "id": '',
      "name": '',
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
  // final List kidList = [
  //   {
  //     "name": "Takin Ahmed 1",
  //     "image_url": kiLogoImageUrl,
  //   },
  //   {
  //     "name": "Takin Ahmed 2",
  //     "image_url": kiLogoImageUrl,
  //   },
  //   {
  //     "name": "Takin Ahmed 3",
  //     "image_url": kiLogoImageUrl,
  //   },
  //   {
  //     "name": "Takin Ahmed 4",
  //     "image_url": kiLogoImageUrl,
  //   },
  //   {
  //     "name": "Takin Ahmed 5",
  //     "image_url": kiLogoImageUrl,
  //   },
  //   {
  //     "name": "Takin Ahmed 6",
  //     "image_url": kiLogoImageUrl,
  //   },
  //   {
  //     "name": "Takin Ahmed 7",
  //     "image_url": kiLogoImageUrl,
  //   },
  //   {
  //     "name": "Takin Ahmed 8",
  //     "image_url": kiLogoImageUrl,
  //   },
  //   {
  //     "name": "Takin Ahmed 9",
  //     "image_url": kiLogoImageUrl,
  //   },
  // ];
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
      selectedKid.value = null;
      resetAddKidPage();
      if (selectedKid.value == null || isKidAdded.value) {
        _globalController.isBottomSheetRightButtonActive.value = false;
      } else {
        _globalController.isBottomSheetRightButtonActive.value = true;
      }
      _globalController.commonBottomSheet(
        context: context,
        content: Obx(() => Column(
              children: [
                kH8sizedBox,
                if (selectedKid.value == null)
                  OutLinedButton(
                    buttonHeight: isDeviceScreenLarge() ? 45 : 40,
                    borderRadius: k8CircularBorderRadius,
                    onPress: !isKidAdded.value
                        ? () async {
                            isKidListLoading.value = true;
                            tempSelectedKid.value = null;
                            kidID.value = -1;
                            if (tempSelectedKid.value == null) {
                              _globalController.isBottomSheetRightButtonActive.value = false;
                            } else {
                              _globalController.isBottomSheetRightButtonActive.value = true;
                            }
                            _globalController.commonBottomSheet(
                              isScrollControlled: true,
                              bottomSheetHeight: height * .7,
                              context: context,
                              content: Obx(() => isKidListLoading.value
                                  ? const KidListShimmer()
                                  : Column(
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
                                                  // selectKidStatusChange(i);
                                                  kidID.value = kidList[i].id!;
                                                  tempSelectedKid.value = kidList[i];
                                                  if (tempSelectedKid.value == null) {
                                                    _globalController.isBottomSheetRightButtonActive.value = false;
                                                  } else {
                                                    _globalController.isBottomSheetRightButtonActive.value = true;
                                                  }
                                                },
                                                itemColor: kidID.value == kidList[i].id! ? cPrimaryTint3Color : cWhiteColor,
                                                borderColor: kidID.value == kidList[i].id! ? cPrimaryColor : cLineColor,
                                                title: kidList[i].name,
                                                leading: Container(
                                                  height: h24,
                                                  width: h24,
                                                  decoration: const BoxDecoration(
                                                    color: cWhiteColor,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: ClipOval(
                                                    child: Image.network(
                                                      Environment.imageBaseUrl + kidList[i].kidImage,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context, error, stackTrace) => const Icon(
                                                        BipHip.imageFile,
                                                        size: kIconSize120,
                                                        color: cIconColor,
                                                      ),
                                                      // loadingBuilder: imageLoadingBuilder,
                                                    ),
                                                  ),
                                                ),
                                                trailing: CustomRadioButton(
                                                  onChanged: () {
                                                    // selectKidStatusChange(i);
                                                    kidID.value = kidList[i].id!;
                                                    tempSelectedKid.value = kidList[i];
                                                    if (tempSelectedKid.value == null) {
                                                      _globalController.isBottomSheetRightButtonActive.value = false;
                                                    } else {
                                                      _globalController.isBottomSheetRightButtonActive.value = true;
                                                    }
                                                  },
                                                  isSelected: kidID.value == kidList[i].id!,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    )),
                              onPressCloseButton: () {
                                Get.back();
                              },
                              onPressRightButton: () {
                                selectedKid.value = tempSelectedKid.value;
                                Get.back();
                                tempSelectedKid.value = null;
                                if (selectedKid.value == null || isKidAdded.value) {
                                  _globalController.isBottomSheetRightButtonActive.value = false;
                                } else {
                                  _globalController.isBottomSheetRightButtonActive.value = true;
                                }
                              },
                              rightText: ksDone.tr,
                              rightTextStyle: medium14TextStyle(cPrimaryColor),
                              title: ksSelectKids.tr,
                              isRightButtonShow: true,
                            );
                            await getKidList();
                          }
                        : null,
                    buttonText: ksSelectKids.tr,
                    buttonTextStyle: !isKidAdded.value ? medium16TextStyle(cBlackColor) : medium16TextStyle(cLineColor2),
                    borderColor: cLineColor,
                    widget: Icon(
                      BipHip.downArrowOutline,
                      color: !isKidAdded.value ? cBlackColor : cLineColor2,
                      size: isDeviceScreenLarge() ? h20 : h16,
                    ),
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                if (selectedKid.value != null)
                  CustomListTile(
                    borderColor: cPrimaryColor,
                    itemColor: cPrimaryTint3Color,
                    leading: Container(
                      height: h24,
                      width: h24,
                      decoration: const BoxDecoration(
                        color: cWhiteColor,
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.network(
                          Environment.imageBaseUrl + selectedKid.value!.kidImage,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Icon(
                            BipHip.imageFile,
                            size: kIconSize120,
                            color: cIconColor,
                          ),
                          // loadingBuilder: imageLoadingBuilder,
                        ),
                      ),
                    ),
                    title: Text(
                      selectedKid.value!.name!,
                      style: medium14TextStyle(cBlackColor),
                    ),
                    trailing: InkWell(
                      onTap: () {
                        selectedKid.value = null;
                        if (selectedKid.value == null || isKidAdded.value) {
                          _globalController.isBottomSheetRightButtonActive.value = false;
                        } else {
                          _globalController.isBottomSheetRightButtonActive.value = true;
                        }
                      },
                      child: const Icon(
                        BipHip.cross,
                        color: cRedColor,
                      ),
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
                  ksOr.tr,
                  style: regular16TextStyle(cPlaceHolderColor),
                ),
                kH12sizedBox,
                if (!isKidAdded.value)
                  OutLinedButton(
                    buttonHeight: isDeviceScreenLarge() ? 45 : 40,
                    borderRadius: k8CircularBorderRadius,
                    onPress: selectedKid.value == null
                        ? () {
                            resetAddKidPage();
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation1, animation2) => AddKidPage(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          }
                        : null,
                    buttonText: ksAddKid.tr,
                    buttonTextStyle: selectedKid.value == null ? medium16TextStyle(cPrimaryColor) : medium16TextStyle(cLineColor2),
                    borderColor: selectedKid.value == null ? cPrimaryColor : cLineColor2,
                    widget: Icon(
                      BipHip.plus,
                      color: selectedKid.value == null ? cPrimaryColor : cLineColor2,
                      size: isDeviceScreenLarge() ? h20 : h16,
                    ),
                  ),
                if (isKidAdded.value)
                  CustomListTile(
                    borderColor: cPrimaryColor,
                    itemColor: cPrimaryTint3Color,
                    leading: Container(
                      height: h24,
                      width: h24,
                      decoration: const BoxDecoration(
                        color: cWhiteColor,
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.file(
                          kidImageFile.value,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      kidNameTextEditingController.text,
                      style: medium14TextStyle(cBlackColor),
                    ),
                    trailing: InkWell(
                      onTap: () {
                        resetAddKidPage();
                        if (selectedKid.value == null || isKidAdded.value) {
                          _globalController.isBottomSheetRightButtonActive.value = false;
                        } else {
                          _globalController.isBottomSheetRightButtonActive.value = true;
                        }
                      },
                      child: const Icon(
                        BipHip.cross,
                        color: cRedColor,
                      ),
                    ),
                  ),
                kH8sizedBox,
                Text(
                  "*${ksCustomAddInstruction.tr}",
                  style: regular14TextStyle(cSmallBodyTextColor),
                ),
              ],
            )),
        onPressCloseButton: () {
          Get.back();
        },
        onPressRightButton: () {
          if (selectedKid.value != null) {
            postSecondaryCircleAvatar.value = selectedKid.value!.kidImage;
          } else {
            postSecondaryLocalCirclerAvatar.value = kidImageFile.value;
          }
          Get.back();
          Get.back();
        },
        rightText: ksDone.tr,
        rightTextStyle: medium14TextStyle(cPrimaryColor),
        title: ksKids.tr,
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
                  onPressRightButton: () {
                    Get.back();
                  },
                  rightText: ksDone.tr,
                  rightTextStyle: medium14TextStyle(cPrimaryColor),
                  title: ksSelectBrands.tr,
                  isRightButtonShow: true,
                );
              },
              buttonText: ksSelectSavedBrands.tr,
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
              ksOr.tr,
              style: regular16TextStyle(cPlaceHolderColor),
            ),
            kH12sizedBox,
            OutLinedButton(
              onPress: () {
                Get.to(() => AddBrandPage());
              },
              buttonText: ksAddBrand.tr,
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
              "*${ksAddBrandInstruction.tr}",
              style: regular14TextStyle(cSmallBodyTextColor),
            ),
          ],
        ),
        onPressCloseButton: () {
          Get.back();
        },
        onPressRightButton: () {
          Get.back();
        },
        rightText: ksDone.tr,
        rightTextStyle: medium14TextStyle(cPrimaryColor),
        title: ksBrands.tr,
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

  // void selectKidTextChange() {
  //   for (int i = 0; i < kidList.length; i++) {
  //     if (selectedKidStatusList[i]) {
  //       selectedKidName.value = kidList[i]['name'];
  //       selectedKidImage.value = kidList[i]['image_url'];
  //       break;
  //     }
  //   }
  // }

  // void initializeKidText() {
  //   for (int i = 0; i < selectedKidStatusList.length; i++) {
  //     if (kidList[i]['name'] == selectedKidName.value) {
  //       selectedKidStatusList[i] = true;
  //     } else {
  //       selectedKidStatusList[i] = false;
  //     }
  //   }
  // }

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
    // allMediaList.addAll(mediaLink);
    allMediaList.addAll(mediaFile);
    allMediaFileList.addAll(mediaFile);
    ll(allMediaFileList);
    // ll(allMediaList);
  }

  void removeMedia(index) {
    allMediaList.removeAt(index);
    allMediaFileList.removeAt(index);
    if (allMediaFileList.isEmpty || allMediaList.isEmpty) {
      Get.back();
    }
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
      // var status = await _globalController.selectVideoSource(isCreatePostVideoChanged, createPostVideoLink, createPostVideoFile, 'camera', true);
      // if (status) {
      //   insertMedia([createPostVideoLink], createPostVideoFile);
      //   isCreatePostVideoChanged.value = false;
      //   createPostVideoLink.value = "";
      //   createPostVideoFile.clear();
      // }
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
                  ksSelected.tr,
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
                  ksSuggestionAllCap.tr,
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
        onPressRightButton: () {
          Get.back();
        },
        rightText: ksDone.tr,
        rightTextStyle: medium14TextStyle(cPrimaryColor),
        title: ksTagPeople.tr,
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
      rightText: ksDone.tr,
      rightTextStyle: medium14TextStyle(cPrimaryColor),
      title: ksEditAudience.tr,
      isRightButtonShow: true,
    );
  }

  //Get all post catagories API implementation
  Rx<PostListModel?> postCategoryData = Rx<PostListModel?>(null);
  final RxBool isAddKidPageLoading = RxBool(false);
  final RxBool isPostCategoryListLoading = RxBool(false);
  Future<void> getPostCategoryList() async {
    try {
      isPostCategoryListLoading.value = true;
      String? token = await _spController.getBearerToken();
      var response = await _apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetAllPostCatagories,
      ) as CommonDM;
      if (response.success == true) {
        postCategoryList.clear();
        postCategoryData.value = PostListModel.fromJson(response.data);
        postCategoryList.addAll(postCategoryData.value!.postCategories);
        for (int i = 0; i < postCategoryList.length; i++) {
          for (int j = 0; j < categoryList.length; j++) {
            if (postCategoryList[i].name!.toLowerCase() == categoryList[j]['title'].toLowerCase()) {
              categoryList[j]['name'] = postCategoryList[i].name!;
              categoryList[j]['id'] = postCategoryList[i].id!;
            }
          }
        }
        isPostCategoryListLoading.value = false;
      } else {
        isPostCategoryListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isPostCategoryListLoading.value = true;
      ll('getPostCategoryList error: $e');
    }
  }

  //Add kid
  final RxBool saveKidInfo = RxBool(false);
  final RxString kidImageLink = RxString('');
  final Rx<File> kidImageFile = File('').obs;
  final RxBool isKidImageChanged = RxBool(false);
  final TextEditingController kidNameTextEditingController = TextEditingController();
  final TextEditingController kidAgeTextEditingController = TextEditingController();
  final RxBool isSaveButtonEnabled = RxBool(false);
  final RxBool isKidAdded = RxBool(false);
  final RxBool isKidSelected = RxBool(false);

  void checkCanAddKidInfo() {
    if (kidNameTextEditingController.text.trim() != '' && kidAgeTextEditingController.text.trim() != '' && isKidImageChanged.value) {
      isSaveButtonEnabled.value = true;
    } else {
      isSaveButtonEnabled.value = false;
    }
  }

  void resetAddKidPage() {
    isKidAdded.value = false;
    saveKidInfo.value = false;
    isSaveButtonEnabled.value = false;
    kidImageLink.value = '';
    kidImageFile.value = File('');
    isKidImageChanged.value = false;
    kidNameTextEditingController.clear();
    kidAgeTextEditingController.clear();
  }

  //Add kid API Implementation
  Rx<KidModel?> kidData = Rx<KidModel?>(null);
  RxList<PostCategory> postCategoryList = RxList<PostCategory>([]);
  Future<void> addKid() async {
    try {
      isAddKidPageLoading.value = true;
      String? token = await _spController.getBearerToken();
      Map<String, String> body = {
        'name': kidNameTextEditingController.text.trim(),
        'age': kidAgeTextEditingController.text.trim(),
      };
      var response = await _apiController.mediaUpload(
        url: kuAddKid,
        body: body,
        token: token,
        key: 'image',
        value: kidImageFile.value.path,
      ) as CommonDM;

      if (response.success == true) {
        kidData.value = KidModel.fromJson(response.data);
        ll(kidData.value!.name);
        isAddKidPageLoading.value = false;
        Get.back();
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isAddKidPageLoading.value = true;

        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isAddKidPageLoading.value = true;
      ll('addKid error: $e');
    }
  }

  //Get Kid List API Implementation
  Rx<KidListModel?> kidListData = Rx<KidListModel?>(null);
  RxList<Kid> kidList = RxList<Kid>([]);
  Rx<Kid?> selectedKid = Rx<Kid?>(null);
  Rx<Kid?> tempSelectedKid = Rx<Kid?>(null);
  RxInt kidID = RxInt(-1);
  RxBool isKidListLoading = RxBool(false);
  Future<void> getKidList() async {
    try {
      isKidListLoading.value = true;
      String? token = await _spController.getBearerToken();
      var response = await _apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetAllKidList,
      ) as CommonDM;
      if (response.success == true) {
        kidList.clear();
        kidListData.value = KidListModel.fromJson(response.data);
        kidList.addAll(kidListData.value!.kids);
        isKidListLoading.value = false;
      } else {
        isKidListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isKidListLoading.value = true;
      ll('getKidList error: $e');
    }
  }

  // Add Brand API Implementation
  final RxBool saveBrandInfo = RxBool(false);
  final RxString brandImageLink = RxString('');
  final Rx<File> brandImageFile = File('').obs;
  final RxBool isBrandImageChanged = RxBool(false);
  final TextEditingController brandNameTextEditingController = TextEditingController();
  final TextEditingController brandWebLinkTextEditingController = TextEditingController();
  final TextEditingController brandFacebookLinkTextEditingController = TextEditingController();
  final TextEditingController brandLinkedInLinkTextEditingController = TextEditingController();
  final TextEditingController brandYoutubeLinkTextEditingController = TextEditingController();
  final TextEditingController brandTwitterTextEditingController = TextEditingController();
  final RxList brandSocialLinkList = RxList([]);
  Future<void> addBrand() async {
    try {
      isAddKidPageLoading.value = true;
      String? token = await _spController.getBearerToken();
      Map<String, String> body = {
        'name': brandNameTextEditingController.text.trim(),
        'social_links': json.encode(brandSocialLinkList),
      };
      var response = await _apiController.mediaUpload(
        url: kuAddBrand,
        body: body,
        token: token,
        key: 'image',
        value: brandImageFile.value.path,
      ) as CommonDM;

      if (response.success == true) {
        isAddKidPageLoading.value = false;
        Get.back();
        _globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isAddKidPageLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          _globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          _globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isAddKidPageLoading.value = true;
      ll('addKid error: $e');
    }
  }

  void createLinkList() {
    brandSocialLinkList.clear();
    if (brandWebLinkTextEditingController.text.trim() != '') {
      brandSocialLinkList.add({'Web': brandWebLinkTextEditingController.text.trim()});
    }
    if (brandFacebookLinkTextEditingController.text.trim() != '') {
      brandSocialLinkList.add({'Facebook': brandFacebookLinkTextEditingController.text.trim()});
    }
    if (brandLinkedInLinkTextEditingController.text.trim() != '') {
      brandSocialLinkList.add({'LinkedIn': brandLinkedInLinkTextEditingController.text.trim()});
    }
    if (brandTwitterTextEditingController.text.trim() != '') {
      brandSocialLinkList.add({'Twitter': brandTwitterTextEditingController.text.trim()});
    }
    if (brandYoutubeLinkTextEditingController.text.trim() != '') {
      brandSocialLinkList.add({'Youtube': brandYoutubeLinkTextEditingController.text.trim()});
    }
    ll(brandSocialLinkList);
  }
}
