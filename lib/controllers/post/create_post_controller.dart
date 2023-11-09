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
  final ApiController apiController = ApiController();
  final SpController spController = SpController();
  final GlobalController globalController = Get.find<GlobalController>();

  final RxBool isPostButtonActive = RxBool(false);
  final RxBool isTextLimitCrossed = RxBool(false);
  final TextEditingController createPostController = TextEditingController();
  final RxString postType = RxString('Public');
  final Rx<IconData> postTypeIcon = Rx<IconData>(BipHip.world);
  final RxString category = RxString('');
  final RxInt categoryID = RxInt(-1);
  final Rx<IconData?> categoryIcon = Rx<IconData?>(null);
  final Rx<Color?> categoryIconColor = Rx<Color?>(null);
  final RxBool isTagAdded = RxBool(false);
  // final RxString selectedKidName = RxString('');
  // final RxString selectedKidImage = RxString('');
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
    if (createPostController.text.trim().isNotEmpty) {
      isPostButtonActive.value = true;
      if (createPostController.text.length > 150) {
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
    {"title": "Public", "subtitle": "Anyone from BipHip", "icon": BipHip.world},
    {"title": "Friends", "subtitle": "Your friends from BipHip", "icon": BipHip.friends},
    {"title": "Only me", "subtitle": "Only you can see", "icon": BipHip.lock},
  ];

  final List categoryList = [
    {"id": '', "name": '', "title": "Poetry", "icon": BipHip.poetry, "icon_color": cPoetryColor},
    {"id": '', "name": '', "title": "Painting", "icon": BipHip.painting, "icon_color": cPaintingColor},
    {"id": '', "name": '', "title": "Kids", "icon": BipHip.kids, "icon_color": cKidsColor},
    {"id": '', "name": '', "title": "Storytelling", "icon": BipHip.storytelling, "icon_color": cStoryTellingColor},
    {"id": '', "name": '', "title": "Photography", "icon": BipHip.photography, "icon_color": cPhotographyColor},
    {"id": '', "name": '', "title": "News", "icon": BipHip.newsFill, "icon_color": cBlackColor},
    {"id": '', "name": '', "title": "Selling", "icon": BipHip.selling, "icon_color": cSellingColor},
  ];

  final RxList categoryStatusList = RxList([false, false, false, false, false, false, false]);

  final List tagFiendList = [
    {"name": "Takin Ahmed", "image_url": kiLogoImageUrl},
    {"name": "Takin Ahmed", "image_url": kiLogoImageUrl},
    {"name": "Takin Ahmed", "image_url": kiLogoImageUrl},
    {"name": "Takin Ahmed", "image_url": kiLogoImageUrl},
    {"name": "Takin Ahmed", "image_url": kiLogoImageUrl},
    {"name": "Takin Ahmed", "image_url": kiLogoImageUrl},
    {"name": "Takin Ahmed", "image_url": kiLogoImageUrl},
    {"name": "Takin Ahmed", "image_url": kiLogoImageUrl},
    {"name": "Takin Ahmed", "image_url": kiLogoImageUrl},
  ];

  final RxList selectedKidStatusList = RxList([false, false, false, false, false, false, false, false, false]);
  final RxList selectedBrandStatusList = RxList([false, false, false, false, false, false, false, false, false]);
  final List brandList = [
    {"name": "Takin Ahmed 1", "image_url": kiLogoImageUrl},
    {"name": "Takin Ahmed 2", "image_url": kiLogoImageUrl},
    {"name": "Takin Ahmed 3", "image_url": kiLogoImageUrl},
    {"name": "Takin Ahmed 4", "image_url": kiLogoImageUrl},
    {"name": "Takin Ahmed 5", "image_url": kiLogoImageUrl},
    {"name": "Takin Ahmed 6", "image_url": kiLogoImageUrl},
    {"name": "Takin Ahmed 7", "image_url": kiLogoImageUrl},
    {"name": "Takin Ahmed 8", "image_url": kiLogoImageUrl},
    {"name": "Takin Ahmed 9", "image_url": kiLogoImageUrl},
  ];

  final RxList allMediaList = RxList([]);
  final RxList<Rx<File>> allMediaFileList = RxList<Rx<File>>([]);

  final List platformList = [
    {"id": '', "name": 'Facebook', "title": "Facebook", "image": kiFacebookSvgImageUrl},
    {"id": '', "name": 'Website', "title": "Website", "image": kiWebSvgImageUrl},
    {"id": '', "name": 'LinkedIn', "title": "LinkedIn", "image": kiLinkedInSvgImageUrl},
    {"id": '', "name": 'Twitter', "title": "Twitter", "image": kiTwitterXSvgImageUrl},
    {"id": '', "name": 'Youtube', "title": "Youtube", "image": kiYoutubeSvgImageUrl},
  ];

  final RxList platformStatusList = RxList([false, false, false, false, false]);
  final List actionList = [
    {"id": '', "name": 'Learn More', "title": "Learn More"},
    {"id": '', "name": 'Message', "title": "Message"},
    {"id": '', "name": 'Buy Now', "title": "Buy Now"},
    {"id": '', "name": 'See Post', "title": "See Post"},
  ];

  final RxList actionStatusList = RxList([false, false, false, false]);
//------------------------------
//! important:: create post related functions start
//------------------------------

  

  void selectCategoryTextChange(context) {
    for (int i = 0; i < categoryList.length; i++) {
      if (categoryStatusList[i]) {
        ll(categoryList[i]['id'].runtimeType);
        // categoryID.value = categoryList[i]['id'];
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
        globalController.isBottomSheetRightButtonActive.value = false;
      } else {
        globalController.isBottomSheetRightButtonActive.value = true;
      }
      globalController.commonBottomSheet(
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
                              globalController.isBottomSheetRightButtonActive.value = false;
                            } else {
                              globalController.isBottomSheetRightButtonActive.value = true;
                            }
                            globalController.commonBottomSheet(
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
                                                    globalController.isBottomSheetRightButtonActive.value = false;
                                                  } else {
                                                    globalController.isBottomSheetRightButtonActive.value = true;
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
                                                      globalController.isBottomSheetRightButtonActive.value = false;
                                                    } else {
                                                      globalController.isBottomSheetRightButtonActive.value = true;
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
                                  globalController.isBottomSheetRightButtonActive.value = false;
                                } else {
                                  globalController.isBottomSheetRightButtonActive.value = true;
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
                          globalController.isBottomSheetRightButtonActive.value = false;
                        } else {
                          globalController.isBottomSheetRightButtonActive.value = true;
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
                          globalController.isBottomSheetRightButtonActive.value = false;
                        } else {
                          globalController.isBottomSheetRightButtonActive.value = true;
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
      globalController.commonBottomSheet(
        context: context,
        content: Column(
          children: [
            kH8sizedBox,
            OutLinedButton(
              onPress: () {
                globalController.commonBottomSheet(
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

  void selectBrandStatusChange(index) {
    for (int i = 0; i < selectedBrandStatusList.length; i++) {
      if (index == i) {
        selectedBrandStatusList[i] = true;
      } else {
        selectedBrandStatusList[i] = false;
      }
    }
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
    resetCreatePost();
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
      var status = await globalController.selectMultiMediaSource(isMediaChanged, mediaLinkList, mediaFileList);
      if (status) {
        ll("media list length : ${mediaLinkList.length}");
        insertMedia(mediaLinkList, mediaFileList);
        isMediaChanged.value = false;
        mediaLinkList.clear();
        mediaFileList.clear();
      }
    } else if (index == 2) {
      var status = await globalController.selectImageSource(isCreatePostImageChanged, createPostImageLink, createPostImageFile, 'camera', false, true);
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
      globalController.commonBottomSheet(
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

  //Get all post catagories API implementation
  Rx<PostCategoryListModel?> postCategoryData = Rx<PostCategoryListModel?>(null);
  final RxBool isAddKidPageLoading = RxBool(false);
  final RxBool isPostCategoryListLoading = RxBool(false);
  Future<void> getPostCategoryList() async {
    try {
      isPostCategoryListLoading.value = true;
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetAllPostCatagories,
      ) as CommonDM;
      if (response.success == true) {
        postCategoryList.clear();
        postCategoryData.value = PostCategoryListModel.fromJson(response.data);
        postCategoryList.addAll(postCategoryData.value!.postCategories);
        for (int i = 0; i < postCategoryList.length; i++) {
          for (int j = 0; j < categoryList.length; j++) {
            if (categoryList[j]['title'].toLowerCase() == postCategoryList[i].name!.toLowerCase()) {
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
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
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
  final RxBool isSaveKidButtonEnabled = RxBool(false);
  final RxBool isKidAdded = RxBool(false);
  final RxBool isKidSelected = RxBool(false);

  void checkCanAddKidInfo() {
    if (kidNameTextEditingController.text.trim() != '' && kidAgeTextEditingController.text.trim() != '' && isKidImageChanged.value) {
      isSaveKidButtonEnabled.value = true;
    } else {
      isSaveKidButtonEnabled.value = false;
    }
  }

  void resetAddKidPage() {
    isKidAdded.value = false;
    saveKidInfo.value = false;
    isSaveKidButtonEnabled.value = false;
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
      String? token = await spController.getBearerToken();
      Map<String, String> body = {
        'name': kidNameTextEditingController.text.trim(),
        'age': kidAgeTextEditingController.text.trim(),
      };
      var response = await apiController.mediaUpload(
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
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isAddKidPageLoading.value = false;

        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isAddKidPageLoading.value = false;
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
      String? token = await spController.getBearerToken();
      var response = await apiController.commonApiCall(
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
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isKidListLoading.value = true;
      ll('getKidList error: $e');
    }
  }

  // Add Brand API Implementation
  final RxString brandImageLink = RxString('');
  final Rx<File> brandImageFile = File('').obs;
  final RxBool isBrandImageChanged = RxBool(false);
  final RxBool isSaveBrandButtonEnabled = RxBool(false);
  final RxBool isAddBrandPageLoading = RxBool(false);
  final TextEditingController brandNameTextEditingController = TextEditingController();
  final TextEditingController brandWebLinkTextEditingController = TextEditingController();
  final TextEditingController brandFacebookLinkTextEditingController = TextEditingController();
  final TextEditingController brandLinkedInLinkTextEditingController = TextEditingController();
  final TextEditingController brandYoutubeLinkTextEditingController = TextEditingController();
  final TextEditingController brandTwitterTextEditingController = TextEditingController();
  final RxList brandSocialLinkList = RxList([]);
  Future<void> addBrand() async {
    try {
      isAddBrandPageLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, String> body = {
        'name': brandNameTextEditingController.text.trim(),
        'social_links': json.encode(brandSocialLinkList),
      };
      var response = await apiController.mediaUpload(
        url: kuAddBrand,
        body: body,
        token: token,
        key: 'image',
        value: brandImageFile.value.path,
      ) as CommonDM;

      if (response.success == true) {
        isAddBrandPageLoading.value = false;
        Get.back();
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isAddBrandPageLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isAddBrandPageLoading.value = false;
      ll('addBrand error: $e');
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

  void checkCanSaveBrand() {
    if (isBrandImageChanged.value &&
        brandNameTextEditingController.text.trim() != '' &&
        (brandWebLinkTextEditingController.text.trim() != '' ||
            brandFacebookLinkTextEditingController.text.trim() != '' ||
            brandLinkedInLinkTextEditingController.text.trim() != '' ||
            brandTwitterTextEditingController.text.trim() != '' ||
            brandYoutubeLinkTextEditingController.text.trim() != '')) {
      isSaveBrandButtonEnabled.value = true;
    } else {
      isSaveBrandButtonEnabled.value = false;
    }
  }

  // Create post API Implementation
  final RxBool isCreatePostLoading = RxBool(false);
  Future<void> createPost() async {
    ll(allMediaList);
    try {
      isCreatePostLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, String> body = {
        'post_category_id': categoryID.value.toString(),
        'content': createPostController.text.trim(),
        'is_public': '1',
      };
      var response = await apiController.multiMediaUpload(
        url: kuCreatePost,
        body: body,
        token: token,
        key: 'images[]',
        values: allMediaList,
      ) as CommonDM;

      if (response.success == true) {
        isCreatePostLoading.value = false;
        Get.back();
        resetCreatePost();
        globalController.showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isCreatePostLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isCreatePostLoading.value = false;
      ll('createPost error: $e');
    }
  }

  void resetCreatePost() {
    createPostController.clear();
    categoryID.value = -1;
    category.value = '';
    isPostButtonActive.value = false;
  }
}
