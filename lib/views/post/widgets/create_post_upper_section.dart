import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/helpers/post/create_post_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/post/widgets/create_post_bottom_sheet_contents.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';

import 'package:bip_hip/widgets/common/utils/common_empty_view.dart';

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
                width: (createPostController.selectedKid.value != null || createPostController.isKidAdded.value || createPostController.isBrandAdded.value)
                    ? 70
                    : h45,
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
              if (createPostController.selectedKid.value != null || createPostController.isKidAdded.value)
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
                              Environment.imageBaseUrl + createPostController.postSecondaryCircleAvatar.value,
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
              if (createPostController.category.value == "Selling" && createPostController.isBrandAdded.value)
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
                        child:
                            // createPostController.selectedKid.value != null?
                            Image.network(
                      Environment.imageBaseUrl + createPostController.postSecondaryCircleAvatar.value,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        BipHip.imageFile,
                        size: kIconSize120,
                        color: cIconColor,
                      ),
                      // loadingBuilder: imageLoadingBuilder,
                    )
                        // : Container(
                        //     decoration: const BoxDecoration(color: cBlackColor),
                        //     child: Image.file(
                        //       createPostController.postSecondaryLocalCirclerAvatar.value,
                        //       fit: BoxFit.cover,
                        //       errorBuilder: (context, error, stackTrace) => const Icon(
                        //         BipHip.imageFile,
                        //         size: kIconSize24,
                        //         color: cIconColor,
                        //       ),
                        //     ),
                        //   ),
                        ),
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
                  () => Column(
                    children: [
                      Row(
                        children: [
                          Wrap(
                            alignment: WrapAlignment.center,
                            direction: Axis.horizontal,
                            spacing: 4,
                            children: [
                              if (createPostController.category.value != "Selling")
                                CustomElevatedButton(
                                  isCustomButton: true,
                                  label: createPostController.postType.value,
                                  prefixIcon: createPostController.postTypeIcon.value,
                                  onPressed: () {
                                    createPostHelper.initializeAudienceText();
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
                                  createPostHelper.initializeCategory();
                                  createPostController.tempCategory.value = createPostController.category.value;
                                  Get.toNamed(krSelectCategory);
                                  await createPostController.getPostCategoryList();
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
                                            ll('asd');
                                            Get.find<GlobalController>().commonBottomSheet(
                                              context: context,
                                              content: const SubCategoryContent(),
                                              onPressCloseButton: () {
                                                Get.back();
                                              },
                                              onPressRightButton: () {
                                                createPostController.subCategory.value = createPostController.tempSubCategory.value;
                                                createPostController.subCategoryIndex.value = createPostController.tempSubCategoryIndex.value;
                                                Get.back();
                                              },
                                              rightText: ksDone.tr,
                                              rightTextStyle: semiBold12TextStyle(cPrimaryColor),
                                              title: ksSelectSubCategory.tr,
                                              isRightButtonShow: createPostController.subCategoryList.isEmpty ? false : true,
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
                                    if (createPostController.tempSellingPostType.value == '') {
                                      Get.find<GlobalController>().isBottomSheetRightButtonActive.value = false;
                                      createPostController.isRegularPost.value = false;
                                      createPostController.isBiddingPost.value = false;
                                    } else {
                                      Get.find<GlobalController>().isBottomSheetRightButtonActive.value = true;
                                      if (createPostController.tempSellingPostType.value == 'Regular Post') {
                                        createPostController.isRegularPost.value = true;
                                      } else {
                                        createPostController.isBiddingPost.value = true;
                                      }
                                    }
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

                              // CustomElevatedButton(
                              //     label: createPostController.sellingPostType.value == '' ? ksPostType.tr : createPostController.sellingPostType.value,
                              //     onPressed: () {
                              //       Get.find<GlobalController>().commonBottomSheet(
                              //         context: context,
                              //         bottomSheetHeight: isDeviceScreenLarge() ? height * .25 : height * 0.35,
                              //         content: Column(
                              //           children: [
                              //             Obx(() => OutLinedButton(
                              //                   onPress: () {
                              //                     createPostController.isRegularPost.value = true;
                              //                     createPostController.isBiddingPost.value = false;
                              //                     createPostController.sellingPostType.value = ksRegularPost.tr;
                              //                     Get.find<GlobalController>().isBottomSheetRightButtonActive.value = true;
                              //                   },
                              //                   suffixWidget: Padding(
                              //                     padding: const EdgeInsets.only(right: k8Padding),
                              //                     child: Stack(
                              //                       children: [
                              //                         Container(
                              //                           width: 30,
                              //                           height: 30,
                              //                           decoration: BoxDecoration(
                              //                             borderRadius: k100CircularBorderRadius,
                              //                             gradient: const LinearGradient(
                              //                               begin: Alignment.topRight,
                              //                               end: Alignment.topLeft,
                              //                               colors: [
                              //                                 cBlueLinearColor1,
                              //                                 cBlueLinearColor2,
                              //                               ],
                              //                             ),
                              //                           ),
                              //                         ),
                              //                         Positioned(
                              //                           left: 0,
                              //                           right: 0,
                              //                           top: 7,
                              //                           bottom: 7,
                              //                           child: SvgPicture.asset(
                              //                             kiRegularPostSvgUrl,
                              //                             width: 16,
                              //                             height: 16,
                              //                           ),
                              //                         ),
                              //                       ],
                              //                     ),
                              //                   ),
                              //                   buttonText: ksRegularPost.tr,
                              //                   buttonTextStyle: medium16TextStyle(cBlackColor),
                              //                   borderColor: createPostController.isRegularPost.value ? cPrimaryColor : cLineColor,
                              //                   buttonColor: createPostController.isRegularPost.value ? cPrimaryTint2Color : cWhiteColor,
                              //                 )),
                              //             kH16sizedBox,
                              //             Obx(() => OutLinedButton(
                              //                   onPress: () {
                              //                     createPostController.isRegularPost.value = false;
                              //                     createPostController.isBiddingPost.value = true;
                              //                     createPostController.sellingPostType.value = ksBiddingPost.tr;
                              //                     Get.find<GlobalController>().isBottomSheetRightButtonActive.value = true;
                              //                   },
                              //                   suffixWidget: Padding(
                              //                     padding: const EdgeInsets.only(right: k8Padding),
                              //                     child: Stack(
                              //                       children: [
                              //                         Container(
                              //                           width: 30,
                              //                           height: 30,
                              //                           decoration: BoxDecoration(
                              //                             borderRadius: k100CircularBorderRadius,
                              //                             gradient: const LinearGradient(
                              //                               begin: Alignment.topRight,
                              //                               end: Alignment.topLeft,
                              //                               colors: [
                              //                                 cYellowLinearColor1,
                              //                                 cYellowLinearColor2,
                              //                               ],
                              //                             ),
                              //                           ),
                              //                         ),
                              //                         Positioned(
                              //                           left: 0,
                              //                           right: 0,
                              //                           top: 7,
                              //                           bottom: 7,
                              //                           child: SvgPicture.asset(
                              //                             kiBiddingPostSvgUrl,
                              //                             width: 16,
                              //                             height: 16,
                              //                           ),
                              //                         ),
                              //                       ],
                              //                     ),
                              //                   ),
                              //                   buttonText: ksBiddingPost.tr,
                              //                   buttonTextStyle: medium16TextStyle(cBlackColor),
                              //                   borderColor: createPostController.isBiddingPost.value ? cPrimaryColor : cLineColor,
                              //                   buttonColor: createPostController.isBiddingPost.value ? cPrimaryTint2Color : cWhiteColor,
                              //                 )),
                              //           ],
                              //         ),
                              //         onPressCloseButton: () {
                              //           Get.back();
                              //         },
                              //         onPressRightButton: () {
                              //           createPostController.sellingPostType.value;
                              //         },
                              //         rightText: ksNext.tr,
                              //         rightTextStyle: medium14TextStyle(cPrimaryColor),
                              //         title: ksSelectPostType.tr,
                              //         isRightButtonShow: true,
                              //       );

                              //     })
                            ],
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
      () => Get.find<CreatePostController>().subCategoryList.isNotEmpty
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
                      for (int i = 0; i < Get.find<CreatePostController>().subCategoryList.length; i++)
                        CustomChoiceChips(
                          label: Get.find<CreatePostController>().subCategoryList[i]["title"],
                          // labelStyle: semiBold12TextStyle(Get.find<CreatePostController>().isSubCategorySelected.value ? cPrimaryColor : cBlackColor),
                          isSelected: (Get.find<CreatePostController>().tempSubCategoryIndex.value == i),
                          onSelected: (value) {
                            Get.find<CreatePostController>().tempSubCategory.value = Get.find<CreatePostController>().subCategoryList[i]["title"];
                            Get.find<CreatePostController>().tempSubCategoryIndex.value = i;
                            if (Get.find<CreatePostController>().tempSubCategory.value == '' &&
                                Get.find<CreatePostController>().tempSubCategoryIndex.value == -1) {
                              Get.find<GlobalController>().isBottomSheetRightButtonActive.value = false;
                            } else {
                              Get.find<GlobalController>().isBottomSheetRightButtonActive.value = true;
                            }
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
