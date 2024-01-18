import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/helpers/post/create_post_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/auth/onboarding/picture_upload_screen.dart';
import 'package:bip_hip/views/post/widgets/create_post_bottom_sheet_contents.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';

import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';
import 'package:flutter_svg/svg.dart';

class CreatePostUpperSection extends StatelessWidget {
  CreatePostUpperSection({super.key});
  final CreatePostController createPostController = Get.find<CreatePostController>();
  final CreatePostHelper createPostHelper = CreatePostHelper();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                width: (createPostController.category.value == 'Kids' || createPostController.selectedBrandName.value != '') ? 70 : h45,
                child: Row(
                  children: [
                    Container(
                      height: h45,
                      width: h45,
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: cBlackColor),
                      child: ClipOval(
                        child: Image.network(
                          Get.find<GlobalController>().userImage.value.toString(),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => imageErrorBuilderCover(context, error, stackTrace, BipHip.user, kIconSize20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (createPostController.category.value == 'Kids')
                Positioned(
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: Container(
                    height: h45,
                    width: h45,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: createPostController.selectedKid.value != null
                          ? Image.network(
                              createPostController.postSecondaryCircleAvatar.value,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const Icon(
                                BipHip.imageFile,
                                size: kIconSize120,
                                color: cIconColor,
                              ),
                              // loadingBuilder: imageLoadingBuilder,
                            )
                          : ClipOval(
                              child: Image.file(
                                createPostController.postSecondaryLocalCirclerAvatar.value,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => const Icon(
                                  BipHip.imageFile,
                                  size: kIconSize40,
                                  color: cIconColor,
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
              if (createPostController.category.value == "Selling" && createPostController.selectedBrandName.value != '')
                Positioned(
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: Container(
                    height: h45,
                    width: h45,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: cBlackColor),
                    child: ClipOval(
                        child:
                            // createPostController.selectedKid.value != null?
                            Image.network(
                      createPostController.postSecondaryCircleAvatar.value,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        BipHip.imageFile,
                        size: kIconSize24,
                        color: cIconColor,
                      ),
                    )),
                  ),
                ),
            ],
          ),
          kW8sizedBox,
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: RichText(
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.clip,
                            maxLines: 2,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: Get.find<GlobalController>().userName.value.toString(),
                                  style: semiBold16TextStyle(cBlackColor),
                                ),
                                if (createPostController.isTagAdded.value)
                                  TextSpan(
                                    text: ' ${ksIsWithSmall.tr} ',
                                    style: regular16TextStyle(cBlackColor),
                                  ),
                                if (createPostController.isTagAdded.value)
                                  TextSpan(
                                    text: 'Shohag Jalal & 8 ${ksOthersSmall.tr}',
                                    style: semiBold16TextStyle(cBlackColor),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                kH4sizedBox,
                Obx(
                  () => Row(
                    children: [
                      Wrap(
                        alignment: WrapAlignment.center,
                        direction: Axis.horizontal,
                        spacing: 4,
                        children: [
                          if (createPostController.category.value != "Selling")
                            CustomElevatedButton(
                              isCustomButton: true,
                              label: createPostController.createPostSelectedPrivacy.value,
                              prefixIcon: createPostController.createPostSelectedPrivacyIcon.value,
                              onPressed: () {
                                // createPostHelper.initializeAudienceText();
                                createPostController.createPostSelectedPrivacy.value;
                                createPostHelper.showAudienceSheet(context);
                              },
                              buttonHeight: 22,
                              suffixIcon: BipHip.downArrow,
                              buttonColor: cGreyBoxColor,
                              prefixIconColor: cBlackColor,
                              suffixIconColor: cBlackColor,
                              textStyle: regular12TextStyle(cBlackColor),
                            ),
                          // kW8sizedBox,
                          CustomElevatedButton(
                            label: createPostController.category.value == "" ? "Category" : createPostController.category.value,
                            prefixIcon: createPostController.category.value == "" ? null : createPostController.categoryIcon.value,
                            prefixIconColor: createPostController.category.value == "" ? null : createPostController.categoryIconColor.value,
                            onPressed: () async {
                              if (createPostController.category.value != '') {
                                categoryResetAlertDialog(
                                  context: context,
                                  content: const CategoryResetWarningContent(),
                                  title: ksWarning,
                                );
                              } else {
                                createPostHelper.initializeCategory();
                                createPostController.tempCategory.value = createPostController.category.value;
                                Get.toNamed(krSelectCategory);
                                await createPostController.getPostCategoryList();
                              }
                            },
                            buttonHeight: 22,
                            isCustomButton: true,
                            buttonColor: cGreyBoxColor,
                            suffixIcon: createPostController.category.value == "" ? BipHip.plus : BipHip.edit,
                            suffixIconColor: cBlackColor,
                            textStyle: regular12TextStyle(cBlackColor),
                          ),
                          // kW8sizedBox,
                          if (createPostController.category.value != "Selling")
                            ElevatedButton(
                                onPressed: createPostController.category.value != ''
                                    ? () {
                                        createPostController.tempSubCategory.value = createPostController.subCategory.value;
                                        createPostController.tempSubCategoryIndex.value = createPostController.subCategoryIndex.value;
                                        // log(createPostController.tempSubCategoryIndex.value.toString());
                                        if (createPostController.tempSubCategory.value == '' &&
                                            Get.find<CreatePostController>().tempSubCategoryIndex.value == -1) {
                                          Get.find<GlobalController>().isBottomSheetRightButtonActive.value = false;
                                        } else {
                                          Get.find<GlobalController>().isBottomSheetRightButtonActive.value = true;
                                        }
                                        Get.find<GlobalController>().commonBottomSheet(
                                          context: context,
                                          content: const SubCategoryContent(),
                                          onPressCloseButton: () {
                                            Get.back();
                                          },
                                          onPressRightButton: () {
                                            createPostController.subCategory.value = createPostController.tempSubCategory.value;
                                            createPostController.subCategoryIndex.value = createPostController.tempSubCategoryIndex.value;
                                            createPostHelper.checkCanCreatePost();
                                            Get.back();
                                          },
                                          rightText: ksDone.tr,
                                          rightTextStyle: semiBold12TextStyle(cPrimaryColor),
                                          title: ksSelectSubCategory.tr,
                                          isRightButtonShow: createPostController.createPostSubCategoryList.isEmpty ? false : true,
                                          isScrollControlled: true,
                                          bottomSheetHeight: createPostController.subCategoryCustomBottomSheetHeight(),
                                          // bottomSheetHeight: height * .9
                                        );
                                      }
                                    : null,
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                                  minimumSize: MaterialStateProperty.all(Size.zero),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(k4BorderRadius),
                                  )),
                                  backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                    if (states.contains(MaterialState.disabled)) {
                                      return cGreyBoxColor;
                                    } else {
                                      return cGreyBoxColor;
                                    }
                                  }),
                                  splashFactory: InkRipple.splashFactory,
                                ),
                                child: SizedBox(
                                  height: 22,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 6),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(createPostController.subCategory.value == "" ? "Sub Category" : createPostController.subCategory.value,
                                            textAlign: TextAlign.center,
                                            style: createPostController.category.value == ""
                                                ? regular12TextStyle(cPlaceHolderColor2)
                                                : regular12TextStyle(cBlackColor)),
                                        Padding(
                                          padding: const EdgeInsets.only(left: k4Padding),
                                          child: Icon(
                                            createPostController.subCategory.value == "" ? BipHip.plus : BipHip.edit,
                                            color: createPostController.category.value == "" ? cIconColor : cBlackColor,
                                            size: screenWiseSize(kIconSize16, 4),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          if (createPostController.category.value == "Selling")
                            CustomElevatedButton(
                              label: createPostController.sellingPostType.value == '' ? ksPostType.tr : createPostController.sellingPostType.value,
                              onPressed: () {
                                createPostController.tempSellingPostType.value = createPostController.sellingPostType.value;
                                createPostHelper.sellingPostTypeSelect();
                                Get.find<GlobalController>().commonBottomSheet(
                                  context: context,
                                  bottomSheetHeight: isDeviceScreenLarge() ? height * .25 : height * 0.35,
                                  content: SellingCategoryBottomSheetContent(),
                                  onPressCloseButton: () {
                                    Get.back();
                                  },
                                  onPressRightButton: () {
                                    createPostController.sellingPostType.value = createPostController.tempSellingPostType.value;
                                    createPostController.selectedBrandName.value = '';
                                    createPostController.selectedBrandId.value = -1;
                                    createPostHelper.checkCanCreatePost();
                                    createPostHelper.checkCanCreatePost();
                                    Get.find<GlobalController>().commonBottomSheet(
                                      context: context,
                                      bottomSheetHeight: isDeviceScreenLarge() ? height * 0.4 : height * 0.5,
                                      content: BrandBottomSheetContent(),
                                      onPressCloseButton: () {
                                        Get.back();
                                      },
                                      onPressRightButton: () {
                                        // boostPostAlertDialog(context: context, title: ksBoostPost.tr, content: const BoostPostContent()); //* Set it temporary for test case
                                        Get.back();
                                        Get.back();
                                        Get.back();
                                      },
                                      rightText: ksDone.tr,
                                      rightTextStyle: medium14TextStyle(cPrimaryColor),
                                      title: ksBrands.tr,
                                      isRightButtonShow: true,
                                    );
                                  },
                                  rightText: ksNext.tr,
                                  rightTextStyle: medium14TextStyle(cPrimaryColor),
                                  title: ksSelectPostType.tr,
                                  isRightButtonShow: true,
                                );
                              },
                              buttonHeight: 22,
                              isCustomButton: true,
                              prefixIcon: createPostController.sellingPostType.value == "" ? BipHip.plus : null,
                              buttonColor: cGreyBoxColor,
                              suffixIconColor: cBlackColor,
                              prefixIconColor: cBlackColor,
                              suffixIcon: createPostController.sellingPostType.value == "" ? null : BipHip.edit,
                              textStyle: regular12TextStyle(cBlackColor),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SubCategoryContent extends StatelessWidget {
  const SubCategoryContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Get.find<CreatePostController>().createPostSubCategoryList.isNotEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    direction: Axis.horizontal,
                    spacing: 8.0,
                    children: [
                      for (int i = 0; i < Get.find<CreatePostController>().createPostSubCategoryList.length; i++)
                        CustomChoiceChips(
                          label: Get.find<CreatePostController>().createPostSubCategoryList[i].name.toString(),
                          isSelected: (Get.find<CreatePostController>().tempSubCategoryIndex.value == i),
                          onSelected: (value) {
                            CreatePostHelper().onSelectPostSubCategory(i);
                            // if (Get.find<CreatePostController>().tempSubCategory.value == '' &&
                            //     Get.find<CreatePostController>().tempSubCategoryIndex.value == -1) {
                            //   Get.find<GlobalController>().isBottomSheetRightButtonActive.value = false;
                            // } else {
                            //   Get.find<GlobalController>().isBottomSheetRightButtonActive.value = true;
                            // }
                          },
                        )
                    ],
                  ),
                )
              ],
            )
          : Container(alignment: Alignment.center, child: EmptyView(height: height * 0.3, title: 'No sub category found')),
    );
  }
}

void categoryResetAlertDialog({required BuildContext context, required Widget content, required String title}) {
  showAlertDialog(
    context: context,
    child: CommonAlertDialog(
      hasCloseBtn: false,
      addContent: content,
      title: title,
    ),
  );
}

class CategoryResetWarningContent extends StatelessWidget {
  const CategoryResetWarningContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: k12Padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            kiWarningInfo,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
          kH20sizedBox,
          Text(
            ksCategoryChangeWarningMessage.tr,
            style: regular14TextStyle(cBlackColor),
            textAlign: TextAlign.center,
          ),
          kH16sizedBox,
          Text(
            ksWouldYouProceed.tr,
            style: regular14TextStyle(cBlackColor),
            textAlign: TextAlign.center,
          ),
          kH20sizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomElevatedButton(
                label: ksCancel.tr,
                onPressed: () {
                  Get.back();
                },
                buttonColor: cWhiteColor,
                borderColor: cRedColor,
                textStyle: semiBold18TextStyle(cRedColor),
                buttonHeight: h44,
                buttonWidth: 120,
              ),
              CustomElevatedButton(
                label: ksContinue.tr,
                onPressed: () async {
                  Get.find<CreatePostController>().tempCategory.value = '';
                  Get.find<CreatePostController>().category.value = '';
                  CreatePostHelper().initializeCategory();

                  CreatePostHelper().resetCreatePostData();
                  Get.back();
                  // Get.toNamed(krSelectCategory);
                  // await Get.find<CreatePostController>().getPostCategoryList();
                },
                buttonColor: cPrimaryColor,
                borderColor: cPrimaryColor,
                textStyle: semiBold18TextStyle(cWhiteColor),
                buttonHeight: h44,
                buttonWidth: 120,
              ),
            ],
          ),
          kH20sizedBox,
        ],
      ),
    );
  }
}
