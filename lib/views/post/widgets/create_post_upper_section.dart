import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/helpers/post/create_post_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';
import 'package:bip_hip/widgets/common/button/custom_outline_button.dart';
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
                width: (createPostController.category.value == "Kids" || createPostController.category.value == "Selling") ? 70 : h45,
                child: Row(
                  children: [
                    Container(
                      height: h45,
                      width: h45,
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: cBlackColor),
                      child: ClipOval(
                        child: Image.network(
                          Environment.imageBaseUrl + Get.find<GlobalController>().userImage.value.toString(),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => imageErrorBuilderCover(context, error, stackTrace, BipHip.user, kIconSize20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (createPostController.category.value == "Kids" || createPostController.category.value == "Selling")
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
                              ),
                            ),
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
                  () => Row(
                    children: [
                      Wrap(
                        alignment: WrapAlignment.center,
                        direction: Axis.horizontal,
                        spacing: 2.5,
                        children: [
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
                              Get.toNamed(krSelectCategory);
                              await createPostController.getPostCategoryList();
                            },
                            buttonHeight: 22,
                            isCustomButton: true,
                            suffixIcon: createPostController.category.value == "" ? BipHip.plus : BipHip.edit,
                            buttonColor: cGreyBoxColor,
                            suffixIconColor: cBlackColor,
                            textStyle: regular12TextStyle(cBlackColor),
                          ),
                          // kW8sizedBox,
                          if (createPostController.category.value != "Selling Post")
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
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
                                              Get.back();
                                            },
                                            rightText: ksDone.tr,
                                            rightTextStyle: semiBold12TextStyle(cPrimaryColor),
                                            title: ksSelectSubCategory.tr,
                                            isRightButtonShow: createPostController.subCategoryList.isEmpty ? false : true,
                                            isScrollControlled: true,
                                            bottomSheetHeight: createPostController.customBottomSheetHeight(),
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
                                      // side: BorderSide(color: (buttonColor == cWhiteColor) ? (borderColor ?? cPrimaryColor) : cTransparentColor, width: 1),
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
                                ),
                              ],
                            ),
                          if (createPostController.category.value == "Selling") kW8sizedBox,
                          if (createPostController.category.value == "Selling")
                            Expanded(
                              child: CustomElevatedButton(
                                label: ksPostType.tr,
                                onPressed: () {
                                  Get.find<GlobalController>().commonBottomSheet(
                                    context: context,
                                    content: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        kH8sizedBox,
                                        CustomCheckBox(
                                          value: true,
                                          onChanged: (v) {},
                                          label: ksBiddingPost.tr,
                                          textStyle: medium14TextStyle(cBlackColor),
                                        ),
                                        kH8sizedBox,
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                ksBiddingPostDescription.tr,
                                                style: regular12TextStyle(cSmallBodyTextColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                        kH16sizedBox,
                                        Text(
                                          ksOr.tr,
                                          style: regular16TextStyle(cPlaceHolderColor),
                                        ),
                                        kH16sizedBox,
                                        Row(
                                          children: [
                                            Text(
                                              ksPlatformAndAction.tr,
                                              style: medium14TextStyle(cBlackColor),
                                            ),
                                          ],
                                        ),
                                        kH8sizedBox,
                                        Row(
                                          children: [
                                            OutLinedButton(
                                              buttonText: ksSelectPlatform.tr,
                                              buttonTextStyle: regular14TextStyle(cSmallBodyTextColor),
                                              borderColor: cLineColor,
                                              buttonWidth: width * .55 - 20,
                                              buttonHeight: 44,
                                              widget: const Icon(
                                                BipHip.downArrow,
                                                color: cPlaceHolderColor,
                                              ),
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            ),
                                            kW8sizedBox,
                                            OutLinedButton(
                                              buttonText: ksSelectAction.tr,
                                              buttonTextStyle: regular14TextStyle(cSmallBodyTextColor),
                                              borderColor: cLineColor,
                                              buttonWidth: width * .45 - 20,
                                              buttonHeight: 44,
                                              widget: const Icon(
                                                BipHip.downArrow,
                                                color: cPlaceHolderColor,
                                              ),
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    onPressCloseButton: () {
                                      Get.back();
                                    },
                                    onPressRightButton: null,
                                    rightText: '',
                                    rightTextStyle: medium14TextStyle(cPrimaryColor),
                                    title: ksPostType.tr,
                                    isRightButtonShow: false,
                                  );
                                },
                                buttonHeight: 22,
                                isCustomButton: true,
                                prefixIcon: BipHip.plus,
                                buttonColor: cGreyBoxColor,
                                suffixIconColor: cBlackColor,
                                prefixIconColor: cBlackColor,
                                textStyle: medium12TextStyle(cBlackColor),
                              ),
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
                // if (Get.find<CreatePostController>().subCategoryList.isEmpty)
                // Center(
                //   child: SizedBox(
                //     // height: height * 0.4,
                //     child: Text(
                //       'No sub category found',
                //       style: semiBold16TextStyle(cPlaceHolderColor),
                //       textAlign: TextAlign.center,
                //     ),
                //   ),
                // ),

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
