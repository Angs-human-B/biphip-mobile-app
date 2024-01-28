import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/helpers/post/create_post_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/post/widgets/common_category_button.dart';
import 'package:bip_hip/views/post/widgets/create_post_bottom_section.dart';
import 'package:bip_hip/views/post/widgets/create_post_bottom_sheet_contents.dart';
import 'package:bip_hip/views/post/widgets/create_post_media_section.dart';
import 'package:bip_hip/views/post/widgets/create_post_selling_text_fields.dart';
import 'package:bip_hip/views/post/widgets/create_post_upper_section.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class CreatePost extends StatelessWidget {
  CreatePost({super.key});
  final CreatePostController createPostController = Get.find<CreatePostController>();
  final CreatePostHelper createPostHelper = CreatePostHelper();
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    ll(width);
    return Obx(
      () => Stack(
        children: [
          Container(
            color: cWhiteColor,
            child: SafeArea(
              top: false,
              child: Scaffold(
                backgroundColor: cWhiteColor,
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(kAppBarSize),
                  //* info:: appBar
                  child: CustomAppBar(
                    appBarColor: cWhiteColor,
                    title: ksCreatePost.tr,
                    hasBackButton: true,
                    isCenterTitle: true,
                    onBack: () {
                      Get.back();
                    },
                    action: [
                      Padding(
                        padding: const EdgeInsets.only(right: h16),
                        child: Obx(
                          () => CustomElevatedButton(
                            label: ksPost.tr,
                            onPressed: createPostController.isPostButtonActive.value
                                ? () async {
                                    await createPostController.createPost();
                                  }
                                : null,
                            buttonWidth: 60,
                            buttonHeight: 32,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                body: Stack(
                  children: [
                    Container(
                      color: cWhiteColor,
                      height: height - kAppBarSize,
                      width: width,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: h16, vertical: h12),
                          child: Obx(
                            () => Column(
                              children: [
                                CreatePostUpperSection(),
                                if (createPostController.category.value == 'News') kH16sizedBox,
                                if (createPostController.category.value != 'Selling' && createPostController.category.value != 'News')
                                  CustomModifiedTextField(
                                    controller: createPostController.createPostController,
                                    maxLength: 1000,
                                    maxLines: 100,
                                    minLines: 1,
                                    isFilled: false,
                                    fillColor: cWhiteColor,
                                    inputAction: TextInputAction.newline,
                                    inputType: TextInputType.multiline,
                                    hint: "${ksWhatsOnYourMind.tr}, ${Get.find<GlobalController>().userLastName.value.toString()}?",
                                    contentPadding: const EdgeInsets.symmetric(horizontal: k8Padding, vertical: k16Padding),
                                    textHintStyle: regular20TextStyle(cPlaceHolderColor),
                                    textInputStyle:
                                        createPostController.isTextLimitCrossed.value ? regular16TextStyle(cBlackColor) : regular20TextStyle(cBlackColor),
                                    onChanged: (v) {
                                      createPostHelper.checkCanCreatePost();
                                    },
                                  ),
                                if (createPostController.category.value == 'Selling')
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: k16Padding),
                                        child: Text(
                                          ksPhotosAndVideosUploadLimit.tr,
                                          style: regular12TextStyle(cSmallBodyTextColor),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: k16Padding),
                                        child: createPostController.sellingAllMediaFileList.isEmpty
                                            ? InkWell(
                                                onTap: () async {
                                                  var status = await globalController.selectMultiMediaSourceForSelling(
                                                      createPostController.isSellingImageChanged,
                                                      createPostController.sellingImageLinkList,
                                                      createPostController.sellingImageFileList);
                                                  if (status) {
                                                    // ll("media list length : ${createPostController.sellingImageLinkList.length}");
                                                    if (createPostController.sellingAllMediaListLength.value < 10) {
                                                      createPostHelper.insertSellingMedia(
                                                          createPostController.sellingImageLinkList, createPostController.sellingImageFileList);
                                                      createPostController.isMediaChanged.value = false;
                                                      createPostController.sellingAllMediaListLength.value =
                                                          createPostController.sellingAllMediaListLength.value +
                                                              createPostController.sellingImageFileList.length;
                                                      ll(createPostController.sellingAllMediaListLength.value);
                                                      createPostController.sellingImageLinkList.clear();
                                                      createPostController.sellingImageFileList.clear();
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                  width: width,
                                                  height: isDeviceScreenLarge() ? 148 : 124,
                                                  decoration: BoxDecoration(
                                                    color: cPrimaryTint4Color,
                                                    borderRadius: BorderRadius.circular(k8BorderRadius),
                                                    border: Border.all(color: cPrimaryColor, width: 1),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      kH16sizedBox,
                                                      Container(
                                                        width: 52,
                                                        height: 52,
                                                        decoration: const BoxDecoration(color: cPrimaryTint2Color, shape: BoxShape.circle),
                                                        child: const Icon(
                                                          BipHip.imageFile,
                                                          size: kIconSize28,
                                                          color: cPrimaryColor,
                                                        ),
                                                      ),
                                                      Text(
                                                        ksAddPhotoAndVideo,
                                                        style: semiBold16TextStyle(cBlackColor),
                                                      ),
                                                      kH4sizedBox,
                                                      Text(
                                                        ksTapToUpload.tr,
                                                        style: regular12TextStyle(cPlaceHolderColor),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : GridView.builder(
                                                shrinkWrap: true,
                                                padding: EdgeInsets.zero,
                                                physics: const NeverScrollableScrollPhysics(),
                                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  mainAxisSpacing: h12,
                                                  crossAxisSpacing: h12,
                                                  childAspectRatio: 0.83,
                                                ),
                                                itemCount: createPostController.sellingAllMediaFileList.length + 1,
                                                itemBuilder: (context, index) {
                                                  return Stack(
                                                    children: [
                                                      if (createPostController.sellingAllMediaFileList.length != index)
                                                        ClipRRect(
                                                            borderRadius: const BorderRadius.all(Radius.circular(k8BorderRadius)),
                                                            child: Image.file(
                                                              createPostController.sellingAllMediaFileList[index].value,
                                                              width: (width - 40) / 3,
                                                              fit: BoxFit.cover,
                                                            )),

                                                      //     //*Add Photo container
                                                      // if (createPostController.sellingAllMediaFileList.length>)
                                                      // if (createPostController.seelingImageLength.value > createPostController.sellingAllMediaFileList.length)
                                                      if (index + 1 > createPostController.sellingAllMediaFileList.length &&
                                                          createPostController.sellingAllMediaFileList.length <= 9)
                                                        InkWell(
                                                          onTap: () async {
                                                            var status = await globalController.selectMultiMediaSourceForSelling(
                                                                createPostController.isSellingImageChanged,
                                                                createPostController.sellingImageLinkList,
                                                                createPostController.sellingImageFileList);
                                                            if (status) {
                                                              ll("media list length : ${createPostController.sellingImageLinkList.length}");
                                                              createPostHelper.insertSellingMedia(
                                                                  createPostController.sellingImageLinkList, createPostController.sellingImageFileList);
                                                              createPostController.isMediaChanged.value = false;
                                                              createPostController.sellingImageLinkList.clear();
                                                              createPostController.sellingImageFileList.clear();
                                                            }
                                                          },
                                                          child: Container(
                                                            width: (width - 40) / 3,
                                                            decoration: BoxDecoration(
                                                              color: cPrimaryTint4Color,
                                                              borderRadius: BorderRadius.circular(k8BorderRadius),
                                                              border: Border.all(color: cPrimaryColor, width: 1),
                                                            ),
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Container(
                                                                  width: 52,
                                                                  height: 52,
                                                                  decoration: const BoxDecoration(
                                                                    shape: BoxShape.circle,
                                                                    color: cPrimaryTint2Color,
                                                                  ),
                                                                  child: const Icon(
                                                                    BipHip.imageFile,
                                                                    size: kIconSize28,
                                                                    color: cPrimaryColor,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  ksAdd.tr,
                                                                  style: semiBold16TextStyle(cBlackColor),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),

                                                      if (createPostController.sellingAllMediaFileList.length != index)
                                                        Positioned(
                                                            top: 8,
                                                            right: 8,
                                                            child: Container(
                                                              width: h20,
                                                              height: h20,
                                                              decoration: const BoxDecoration(
                                                                color: cRedColor,
                                                                shape: BoxShape.circle,
                                                              ),
                                                              child: Center(
                                                                  child: CustomIconButton(
                                                                onPress: () {
                                                                  createPostHelper.removeSellingMedia(index);
                                                                },
                                                                icon: BipHip.cross,
                                                                iconColor: cWhiteColor,
                                                                size: kIconSize14,
                                                              )),
                                                            )),
                                                    ],
                                                  );
                                                }),
                                      ),
                                      kH16sizedBox,
                                      Text(
                                        ksRequiredFields.tr,
                                        style: medium14TextStyle(cBlackColor),
                                      ),
                                      kH12sizedBox,
                                      CustomModifiedTextField(
                                        controller: createPostController.biddingTitleTextEditingController,
                                        hint: ksTitle.tr,
                                        onChanged: (text) {
                                          createPostHelper.checkCanCreatePost();
                                        },
                                        onSubmit: (text) {},
                                        inputAction: TextInputAction.next,
                                        inputType: TextInputType.text,
                                        maxLength: 100,
                                      ),
                                      kH4sizedBox,
                                      TextAndIconRowSellingPost(
                                        text: createPostController.selectedProductCategory.value == ''
                                            ? ksCategory.tr
                                            : createPostController.selectedProductCategory.value,
                                        textStyle: createPostController.selectedProductCategory.value == ''
                                            ? regular16TextStyle(cPlaceHolderColor)
                                            : regular16TextStyle(cBlackColor),
                                        suffixIcon: BipHip.downArrow,
                                        onPressed: () {
                                          createPostController.tempSelectedProductCategory.value = createPostController.selectedProductCategory.value;
                                          if (createPostController.tempSelectedProductCategory.value == '') {
                                            globalController.isBottomSheetRightButtonActive.value = false;
                                          } else {
                                            globalController.isBottomSheetRightButtonActive.value = true;
                                          }
                                          globalController.commonBottomSheet(
                                              context: context,
                                              bottomSheetHeight: height * 0.9,
                                              isScrollControlled: true,
                                              content: ProductCategoryContent(),
                                              onPressCloseButton: () {
                                                Get.back();
                                              },
                                              onPressRightButton: () {
                                                createPostController.selectedProductCategory.value = createPostController.tempSelectedProductCategory.value;
                                                createPostController.selectedProductCategoryID.value = createPostController.tempSelectedProductCategoryID.value;
                                                createPostHelper.checkCanCreatePost();
                                                Get.back();
                                              },
                                              rightText: ksDone.tr,
                                              rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                                              title: ksSelectCategory.tr,
                                              isRightButtonShow: true);
                                        },
                                      ),
                                      kH12sizedBox,
                                      TextAndIconRowSellingPost(
                                        text: createPostController.selectedProductCondition.value == ''
                                            ? ksCondition.tr
                                            : createPostController.selectedProductCondition.value,
                                        textStyle: createPostController.selectedProductCondition.value == ''
                                            ? regular16TextStyle(cPlaceHolderColor)
                                            : regular16TextStyle(cBlackColor),
                                        suffixIcon: BipHip.downArrow,
                                        onPressed: () {
                                          createPostController.tempSelectedProductCondition.value = createPostController.selectedProductCondition.value;
                                          if (createPostController.tempSelectedProductCondition.value == '') {
                                            globalController.isBottomSheetRightButtonActive.value = false;
                                          } else {
                                            globalController.isBottomSheetRightButtonActive.value = true;
                                          }
                                          globalController.commonBottomSheet(
                                              context: context,
                                              bottomSheetHeight: isDeviceScreenLarge() ? height * 0.5 : height * 0.6,
                                              content: ProductConditionContent(),
                                              onPressCloseButton: () {
                                                Get.back();
                                              },
                                              onPressRightButton: () {
                                                createPostController.selectedProductCondition.value = createPostController.tempSelectedProductCondition.value;
                                                createPostController.selectedProductConditionID.value =
                                                    createPostController.tempSelectedProductConditionID.value;
                                                createPostHelper.checkCanCreatePost();
                                                Get.back();
                                              },
                                              rightText: ksDone.tr,
                                              rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                                              title: ksSelectCondition.tr,
                                              isRightButtonShow: true);
                                        },
                                      ),
                                      kH12sizedBox,
                                      CustomModifiedTextField(
                                        controller: createPostController.isRegularPost.value
                                            ? createPostController.biddingPriceTextEditingController
                                            : createPostController.biddingDesiredAmountTextEditingController,
                                        hint: createPostController.isRegularPost.value ? ksPrice.tr : ksDesiredAmount,
                                        onChanged: (text) {
                                          createPostHelper.checkCanCreatePost();
                                        },
                                        onSubmit: (text) {},
                                        inputAction: TextInputAction.next,
                                        inputType: TextInputType.number,
                                        maxLength: 10,
                                      ),
                                      if (createPostController.isRegularPost.value)
                                        // Padding(
                                        //   padding: const EdgeInsets.only(bottom: k8Padding),
                                        //   child: Text(
                                        //     'The Price now is 40',
                                        //     style: regular12TextStyle(cSmallBodyTextColor),
                                        //   ),
                                        // ),
                                        kH4sizedBox,
                                      CustomModifiedTextField(
                                        controller: createPostController.isRegularPost.value
                                            ? createPostController.biddingDiscountAmountTextEditingController
                                            : createPostController.biddingMinimumBidTextEditingController,
                                        hint: createPostController.isRegularPost.value ? ksDiscountAmountOptional.tr : ksMinimumBiddingAmount.tr,
                                        onChanged: (text) {},
                                        onSubmit: (text) {},
                                        inputAction: TextInputAction.next,
                                        inputType: TextInputType.number,
                                        maxLength: 10,
                                      ),
                                      if (createPostController.isBiddingPost.value) BiddingDateTimeSection(),
                                      if (createPostController.isBiddingPost.value) PostTypeSection(),
                                      kH4sizedBox,
                                      CustomModifiedTextField(
                                        controller: createPostController.biddingDescriptionTextEditingController,
                                        hint: ksDescription.tr,
                                        onChanged: (text) {},
                                        onSubmit: (text) {},
                                        inputAction: TextInputAction.next,
                                        maxLength: 512,
                                        maxLines: 7,
                                      ),
                                      kH4sizedBox,
                                      if (createPostController.isRegularPost.value)
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: k12Padding),
                                          child: TextAndIconRowSellingPost(
                                            text: createPostController.productAvailability.value == ''
                                                ? ksAvailability.tr
                                                : createPostController.productAvailability.value,
                                            textStyle: createPostController.productAvailability.value == ''
                                                ? regular16TextStyle(cPlaceHolderColor)
                                                : regular16TextStyle(cBlackColor),
                                            suffixIcon: BipHip.downArrow,
                                            onPressed: () {
                                              createPostController.temporaryProductAvailability.value = createPostController.productAvailability.value;
                                              createPostController.temporaryProductAvailabilityId.value = createPostController.productAvailabilityId.value;
                                              if (createPostController.temporaryProductAvailability.value == '') {
                                                globalController.isBottomSheetRightButtonActive.value = false;
                                              } else {
                                                globalController.isBottomSheetRightButtonActive.value = true;
                                              }
                                              globalController.commonBottomSheet(
                                                  context: context,
                                                  bottomSheetHeight: isDeviceScreenLarge() ? height * 0.3 : height * 0.4,
                                                  content: ProductAvailabilityContent(),
                                                  onPressCloseButton: () {
                                                    Get.back();
                                                  },
                                                  onPressRightButton: () {
                                                    createPostController.productAvailability.value = createPostController.temporaryProductAvailability.value;
                                                    createPostController.productAvailabilityId.value =
                                                        createPostController.temporaryProductAvailabilityId.value;
                                                    ll(createPostController.productAvailabilityId.value);
                                                    createPostHelper.checkCanCreatePost();
                                                    Get.back();
                                                  },
                                                  rightText: ksDone.tr,
                                                  rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                                                  title: ksSelectCondition.tr,
                                                  isRightButtonShow: true);
                                            },
                                          ),
                                        ),
                                      CustomModifiedTextField(
                                        controller: createPostController.biddingProductTagTextEditingController,
                                        hint: ksProductTag.tr,
                                        onChanged: (text) {},
                                        onSubmit: (text) {},
                                        inputAction: TextInputAction.next,
                                        maxLength: 10,
                                      ),
                                      Text(
                                        'Optional Limit:20',
                                        style: regular12TextStyle(cSmallBodyTextColor),
                                      ),
                                      kH12sizedBox,
                                      CustomModifiedTextField(
                                        controller: createPostController.biddingSKUTextEditingController,
                                        hint: ksSKU.tr,
                                        onChanged: (text) {},
                                        onSubmit: (text) {},
                                        inputAction: TextInputAction.next,
                                        maxLength: 10,
                                      ),
                                      kH4sizedBox,
                                      TextAndIconRowSellingPost(
                                        text: ksLocation.tr,
                                        suffixIcon: BipHip.downArrow,
                                        onPressed: null,
                                      ),
                                      kH16sizedBox,
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            BipHip.lock,
                                            size: kIconSize20,
                                            color: cIconColor,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: k8Padding),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  width: width - 140,
                                                  child: Text(
                                                    ksHideFromFriendAndFamily.tr,
                                                    style: semiBold16TextStyle(cBlackColor),
                                                  ),
                                                ),
                                                kH8sizedBox,
                                                SizedBox(
                                                  width: width - 140,
                                                  child: Text(
                                                    ksSellingPostHideContentFromFriendAndDFamily.tr,
                                                    style: regular12TextStyle(cSmallBodyTextColor),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Transform.scale(
                                            scale: 0.75,
                                            alignment: Alignment.topRight,
                                            child: CupertinoSwitch(
                                              value: createPostController.isHideFriendFamilySwitch.value,
                                              activeColor: cGreenColor,
                                              onChanged: (value) {
                                                createPostController.isHideFriendFamilySwitch.value = value;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      kH16sizedBox,
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            ksPlatformAndAction.tr,
                                            style: semiBold14TextStyle(cBlackColor),
                                          ),
                                          if (createPostController.selectedPlatform.value != '' && createPostController.selectedAction.value != '')
                                            InkWell(
                                              onTap: () {
                                                createPostController.selectedPlatform.value = '';
                                                createPostController.selectedAction.value = '';
                                              },
                                              child: Text(
                                                ksClear.tr,
                                                style: semiBold14TextStyle(cRedColor),
                                              ),
                                            ),
                                        ],
                                      ),
                                      kH8sizedBox,
                                      CustomListTile(
                                        onPressed: () {
                                          createPostController.tempSelectedPlatform.value = createPostController.selectedPlatform.value;
                                          createPostController.tempSelectedAction.value = createPostController.selectedAction.value;
                                          if (createPostController.tempSelectedPlatform.value == '' || createPostController.tempSelectedAction.value == '') {
                                            globalController.isBottomSheetRightButtonActive.value = false;
                                          } else {
                                            globalController.isBottomSheetRightButtonActive.value = true;
                                          }
                                          if (createPostController.tempSelectedPlatform.value == '') {
                                            for (int i = 0; i < createPostController.platformList.length; i++) {
                                              if (createPostController.tempSelectedPlatform.value == createPostController.platformList[i]['name']) {
                                                createPostController.platformStatusList[i] = true;
                                              } else {
                                                createPostController.platformStatusList[i] = false;
                                              }
                                            }
                                          }
                                          if (createPostController.tempSelectedAction.value == '') {
                                            for (int i = 0; i < createPostController.actionList.length; i++) {
                                              if (createPostController.tempSelectedAction.value == createPostController.actionList[i]['name']) {
                                                createPostController.actionStatusList[i] = true;
                                              } else {
                                                createPostController.actionStatusList[i] = false;
                                              }
                                            }
                                          }

                                          globalController.commonBottomSheet(
                                              context: context,
                                              bottomSheetHeight: isDeviceScreenLarge() ? height * 0.4 : height * 0.5,
                                              content: Column(
                                                children: [
                                                  Wrap(
                                                    children: [
                                                      for (int i = 0; i < createPostController.platformList.length; i++)
                                                        Obx(
                                                          () => CategoryComponent(
                                                            onPress: () {
                                                              createPostHelper.selectPlatformStatusChange(i);
                                                              createPostController.tempSelectedPlatform.value = createPostController.platformList[i]['name'];
                                                              if (createPostController.tempSelectedPlatform.value == '' ||
                                                                  createPostController.tempSelectedAction.value == '') {
                                                                globalController.isBottomSheetRightButtonActive.value = false;
                                                              } else {
                                                                globalController.isBottomSheetRightButtonActive.value = true;
                                                              }
                                                            },
                                                            suffixWidget: Transform.scale(
                                                              scale: .7,
                                                              child: CustomRadioButton(
                                                                onChanged: () {
                                                                  createPostHelper.selectPlatformStatusChange(i);
                                                                  createPostController.tempSelectedPlatform.value =
                                                                      createPostController.platformList[i]['name'];
                                                                  if (createPostController.tempSelectedPlatform.value == '' ||
                                                                      createPostController.tempSelectedAction.value == '') {
                                                                    globalController.isBottomSheetRightButtonActive.value = false;
                                                                  } else {
                                                                    globalController.isBottomSheetRightButtonActive.value = true;
                                                                  }
                                                                },
                                                                isSelected: createPostController.platformStatusList[i],
                                                              ),
                                                            ),
                                                            prefixWidget: SvgPicture.asset(
                                                              createPostController.platformList[i]['image'],
                                                              height: isDeviceScreenLarge() ? h20 : h16,
                                                              width: isDeviceScreenLarge() ? h20 : h16,
                                                            ),
                                                            title: createPostController.platformList[i]['name'],
                                                            titleStyle: medium14TextStyle(cBlackColor),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                  kH16sizedBox,
                                                  const CustomDivider(
                                                    thickness: 1,
                                                  ),
                                                  kH16sizedBox,
                                                  Text(
                                                    ksSelectAction.tr.toUpperCase(),
                                                    style: regular14TextStyle(cSmallBodyTextColor),
                                                  ),
                                                  kH8sizedBox,
                                                  Wrap(
                                                    children: [
                                                      for (int i = 0; i < createPostController.actionList.length; i++)
                                                        Obx(
                                                          () => CategoryComponent(
                                                            onPress: () {
                                                              createPostHelper.selectActionStatusChange(i);
                                                              createPostController.tempSelectedAction.value = createPostController.actionList[i]['name'];
                                                              if (createPostController.tempSelectedPlatform.value == '' ||
                                                                  createPostController.tempSelectedAction.value == '') {
                                                                globalController.isBottomSheetRightButtonActive.value = false;
                                                              } else {
                                                                globalController.isBottomSheetRightButtonActive.value = true;
                                                              }
                                                            },
                                                            suffixWidget: Transform.scale(
                                                              scale: .7,
                                                              child: CustomRadioButton(
                                                                onChanged: () {
                                                                  createPostHelper.selectActionStatusChange(i);
                                                                  createPostController.tempSelectedAction.value = createPostController.actionList[i]['name'];
                                                                  if (createPostController.tempSelectedPlatform.value == '' ||
                                                                      createPostController.tempSelectedAction.value == '') {
                                                                    globalController.isBottomSheetRightButtonActive.value = false;
                                                                  } else {
                                                                    globalController.isBottomSheetRightButtonActive.value = true;
                                                                  }
                                                                },
                                                                isSelected: createPostController.actionStatusList[i],
                                                              ),
                                                            ),
                                                            title: createPostController.actionList[i]['title'],
                                                            titleStyle: medium14TextStyle(cBlackColor),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              onPressCloseButton: () {
                                                Get.back();
                                              },
                                              onPressRightButton: () {
                                                createPostController.selectedPlatform.value = createPostController.tempSelectedPlatform.value;
                                                createPostController.selectedAction.value = createPostController.tempSelectedAction.value;
                                                Get.back();
                                              },
                                              rightText: ksDone.tr,
                                              rightTextStyle: semiBold16TextStyle(cPrimaryColor),
                                              title: ksSelectPlatform.tr,
                                              isRightButtonShow: true);
                                        },
                                        title: Text(
                                          (createPostController.selectedPlatform.value == '' && createPostController.selectedAction.value == '')
                                              ? ksSelectPlatform.tr
                                              : ('${createPostController.selectedPlatform.value} - ${createPostController.selectedAction.value}'),
                                          style: regular14TextStyle(cBlackColor),
                                        ),
                                        borderColor: cLineColor2,
                                        trailing: const Icon(
                                          BipHip.downArrow,
                                          size: kIconSize20,
                                          color: cIconColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                if (createPostController.allMediaList.isNotEmpty) CreatePostMediaSection(),
                                if (createPostController.category.value == "News") SellingNewsTextfield(),
                                kH50sizedBox,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      child: SizedBox(
                        width: width,
                        child: const CustomDivider(),
                      ),
                    ),
                    if (createPostController.category.value != 'Selling')
                      Positioned(
                        bottom: 44,
                        child: SizedBox(
                          width: width,
                          child: const CustomDivider(),
                        ),
                      ),
                    if (createPostController.category.value != 'Selling')
                      Positioned(
                        bottom: 0,
                        child: CreatePostBottomSection(),
                      )
                  ],
                ),
              ),
            ),
          ),
          if (createPostController.isCreatePostLoading.value == true)
            Positioned(
              child: CommonLoadingAnimation(
                onWillPop: () async {
                  if (createPostController.isCreatePostLoading.value) {
                    return false;
                  }
                  return true;
                },
              ),
            ),
        ],
      ),
    );
  }
}

class TextAndIconRowSellingPost extends StatelessWidget {
  const TextAndIconRowSellingPost({super.key, required this.text, this.suffixIcon, this.onPressed, this.prefixIcon, this.width, this.textStyle});
  final String text;
  final double? width;
  final IconData? suffixIcon, prefixIcon;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: isDeviceScreenLarge() ? 50 : 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(k8BorderRadius),
          color: cGreyBoxColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: k16Padding),
          child: Row(
            children: [
              if (prefixIcon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Icon(
                    prefixIcon!,
                    size: kIconSize20,
                    color: cPlaceHolderColor,
                  ),
                ),
              Expanded(
                child: Text(
                  text,
                  style: textStyle ?? regular16TextStyle(cPlaceHolderColor),
                ),
              ),
              if (suffixIcon != null)
                Icon(
                  suffixIcon!,
                  size: kIconSize20,
                  color: cPlaceHolderColor,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class BiddingDateTimeSection extends StatelessWidget {
  BiddingDateTimeSection({super.key});
  final CreatePostHelper createPostHelper = CreatePostHelper();
  final CreatePostController createPostController = Get.find<CreatePostController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextAndIconRowSellingPost(
                width: (width / 2) - 22,
                text: createPostController.biddingStartDate.value != '' ? createPostController.biddingStartDate.value : ksStartDate.tr,
                prefixIcon: BipHip.calendarFill,
                onPressed: () {
                  createPostHelper.selectStartDate(context);
                },
              ),
              TextAndIconRowSellingPost(
                width: (width / 2) - 22,
                text: createPostController.biddingEndDate.value != '' ? createPostController.biddingEndDate.value : ksEndDate.tr,
                prefixIcon: BipHip.calendarFill,
                onPressed: () {
                  if (createPostController.biddingStartDate.value == '') {
                    Get.find<GlobalController>().showSnackBar(title: ksWarning.tr, message: ksPickStartDateFirst.tr, color: cRedColor);
                  } else {
                    createPostHelper.selectEndDate(context);
                  }
                },
              ),
            ],
          ),
          kH12sizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextAndIconRowSellingPost(
                width: (width / 2) - 22,
                text: createPostController.biddingStartTime.value != "" ? createPostController.biddingStartTime.value : ksStartTime.tr,
                prefixIcon: Icons.schedule_rounded,
                onPressed: () {
                  if (createPostController.biddingStartDate.value == '') {
                    Get.find<GlobalController>().showSnackBar(title: ksWarning.tr, message: ksPickStartDateFirst.tr, color: cRedColor);
                  } else {
                    createPostHelper.selectStartTime(context);
                  }
                },
              ),
              TextAndIconRowSellingPost(
                width: (width / 2) - 22,
                text: createPostController.biddingEndTime.value != "" ? createPostController.biddingEndTime.value : ksEndTime.tr,
                prefixIcon: Icons.schedule_rounded,
                onPressed: () {
                  if (createPostController.biddingEndDate.value == '') {
                    Get.find<GlobalController>().showSnackBar(title: ksWarning.tr, message: ksPickEndDateFirst.tr, color: cRedColor);
                  } else if (createPostController.biddingStartTime.value == '') {
                    Get.find<GlobalController>().showSnackBar(title: ksWarning.tr, message: ksPickEndDateFirst.tr, color: cRedColor);
                  } else {
                    createPostHelper.selectEndTime(context);
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

class PostTypeSection extends StatelessWidget {
  PostTypeSection({super.key});
  final CreatePostController createPostController = Get.find<CreatePostController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: k12Padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                ksPostType.tr,
                style: semiBold16TextStyle(cBlackColor),
              ),
              kW8sizedBox,
              const Icon(
                BipHip.info,
                size: kIconSize16,
                color: cPlaceHolderColor,
              )
            ],
          ),
          kH12sizedBox,
          Obx(
            () => Row(
              children: [
                TextualRadioButton(
                  text: ksPublicPost.tr,
                  onPressed: () {
                    createPostController.isPublicPost.value = true;
                    createPostController.isPrivatePost.value = false;
                  },
                  isSelected: createPostController.isPublicPost.value,
                ),
                kW12sizedBox,
                TextualRadioButton(
                  text: ksPrivatePost.tr,
                  onPressed: () {
                    createPostController.isPublicPost.value = false;
                    createPostController.isPrivatePost.value = true;
                  },
                  isSelected: createPostController.isPrivatePost.value,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextualRadioButton extends StatelessWidget {
  const TextualRadioButton({super.key, required this.text, required this.onPressed, required this.isSelected});
  final String text;
  final VoidCallback onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius, border: Border.all(color: cLineColor2)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: k16Padding, vertical: k8Padding),
          child: Row(
            children: [
              Text(
                text,
                style: semiBold16TextStyle(cBlackColor),
              ),
              kW8sizedBox,
              CustomRadioButton(
                onChanged: onPressed,
                isSelected: isSelected,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
