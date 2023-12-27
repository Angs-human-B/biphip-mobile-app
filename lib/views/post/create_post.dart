import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/helpers/post/create_post_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/post/widgets/create_post_bottom_section.dart';
import 'package:bip_hip/views/post/widgets/create_post_media_section.dart';
import 'package:bip_hip/views/post/widgets/create_post_selling_text_fields.dart';
import 'package:bip_hip/views/post/widgets/create_post_upper_section.dart';
import 'package:bip_hip/widgets/common/button/custom_outline_button.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:flutter/cupertino.dart';

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
                                                  var status = await globalController.selectMultiMediaSource(createPostController.isSellingImageChanged,
                                                      createPostController.sellingImageLinkList, createPostController.sellingImageFileList);
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
                                                  mainAxisSpacing: 12,
                                                  crossAxisSpacing: 12,
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
                                                      if (index + 1 > createPostController.sellingAllMediaFileList.length)
                                                        InkWell(
                                                          onTap: () async {
                                                            var status = await globalController.selectMultiMediaSource(
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
                                        onChanged: (text) {},
                                        onSubmit: (text) {},
                                        inputAction: TextInputAction.next,
                                        inputType: TextInputType.text,
                                        maxLength: 100,
                                      ),
                                      kH4sizedBox,
                                      TextAndIconRowSellingPost(
                                        text: ksCategory.tr,
                                        suffixIcon: BipHip.downArrow,
                                        onPressed: null,
                                      ),
                                      kH12sizedBox,
                                      TextAndIconRowSellingPost(
                                        text: createPostController.selectedProductCondition.value == ''
                                            ? ksCondition.tr
                                            : createPostController.selectedProductCondition.value,
                                        suffixIcon: BipHip.downArrow,
                                        onPressed: () {
                                          globalController.commonBottomSheet(
                                              context: context,
                                              bottomSheetHeight: isDeviceScreenLarge() ? height * 0.5 : height * 0.75,
                                              content: SingleChildScrollView(
                                                  child: Column(
                                                children: [
                                                  ListView.builder(
                                                      shrinkWrap: true,
                                                      physics: const NeverScrollableScrollPhysics(),
                                                      itemCount: createPostController.productConditionList.length,
                                                      itemBuilder: (context, index) {
                                                        // return Padding(
                                                        //   padding: const EdgeInsets.only(top: k12Padding),
                                                        //   child: Text(createPostController.productConditionList[index].toString()),
                                                        // );
                                                        return Padding(
                                                          padding: const EdgeInsets.only(top: k12Padding),
                                                          child: Obx(() => OutLinedButton(
                                                                onPress: () {
                                                                  createPostHelper.selectConditionStatusChange(index);
                                                                  globalController.isBottomSheetRightButtonActive.value = true;
                                                                },
                                                                buttonText: createPostController.productConditionList[index].toString(),
                                                                buttonTextStyle: regular16TextStyle(cBlackColor),
                                                                borderColor: createPostController.productConditionState[index] ? cPrimaryColor : cLineColor2,
                                                                buttonColor:
                                                                    createPostController.productConditionState[index] ? cPrimaryTint3Color : cWhiteColor,
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              )),
                                                        );
                                                      }),
                                                ],
                                              )),
                                              onPressCloseButton: () {
                                                Get.back();
                                              },
                                              // onPressRightButton: () {
                                              //   Get.back();
                                              // },
                                              onPressRightButton: () {
                                                createPostHelper.selectProductConditionTextChange();
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
                                        onChanged: (text) {},
                                        onSubmit: (text) {},
                                        inputAction: TextInputAction.next,
                                        inputType: TextInputType.number,
                                        maxLength: 10,
                                      ),
                                      if (createPostController.isRegularPost.value)
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: k8Padding),
                                          child: Text(
                                            'The Price now is 40',
                                            style: regular12TextStyle(cSmallBodyTextColor),
                                          ),
                                        ),
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
                                            text: ksAvailability.tr,
                                            suffixIcon: BipHip.downArrow,
                                            onPressed: null,
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
  const TextAndIconRowSellingPost({super.key, required this.text, this.suffixIcon, this.onPressed, this.prefixIcon, this.width});
  final String text;
  final double? width;
  final IconData? suffixIcon, prefixIcon;
  final VoidCallback? onPressed;
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
                  style: regular16TextStyle(cPlaceHolderColor),
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
                text: ksEndTime.tr,
                prefixIcon: Icons.schedule_rounded,
                onPressed: null,
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
