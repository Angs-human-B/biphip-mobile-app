import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/helpers/post/create_post_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/post/widgets/create_post_bottom_section.dart';
import 'package:bip_hip/views/post/widgets/create_post_media_section.dart';
import 'package:bip_hip/views/post/widgets/create_post_selling_text_fields.dart';
import 'package:bip_hip/views/post/widgets/create_post_upper_section.dart';
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
                                        child: InkWell(
                                          onTap: () {
                                            globalController.commonBottomSheet(
                                                context: context,
                                                onPressCloseButton: () {
                                                  Get.back();
                                                },
                                                onPressRightButton: () {},
                                                rightText: '',
                                                rightTextStyle: regular14TextStyle(cBiddingColor),
                                                title: ksUploadPhoto.tr,
                                                isRightButtonShow: false,
                                                isScrollControlled: false,
                                                bottomSheetHeight: 180,
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    CustomElevatedButton(
                                                      label: ksAddPhoto.tr,
                                                      prefixIcon: BipHip.camera,
                                                      prefixIconColor: cIconColor,
                                                      suffixIconColor: cIconColor,
                                                      onPressed: () async {
                                                        await globalController.selectImageSource(createPostController.isSellingImageChanged,
                                                            createPostController.sellingImageLink, createPostController.sellingImageFile, 'camera', true);
                                                      },
                                                      buttonHeight: h32,
                                                      buttonWidth: width - 40,
                                                      buttonColor: cWhiteColor,
                                                      borderColor: cLineColor,
                                                      textStyle: semiBold14TextStyle(cBlackColor),
                                                    ),
                                                    kH16sizedBox,
                                                    CustomElevatedButton(
                                                      label: ksChooseFromGallery.tr,
                                                      prefixIcon: BipHip.photo,
                                                      prefixIconColor: cIconColor,
                                                      suffixIconColor: cIconColor,
                                                      onPressed: () async {
                                                        await globalController.selectImageSource(createPostController.isSellingImageChanged,
                                                            createPostController.sellingImageLink, createPostController.sellingImageFile, 'gallery', true);
                                                      },
                                                      buttonHeight: h32,
                                                      buttonWidth: width - 40,
                                                      buttonColor: cWhiteColor,
                                                      borderColor: cLineColor,
                                                      textStyle: semiBold14TextStyle(cBlackColor),
                                                    ),
                                                  ],
                                                ));
                                          },
                                          child: Container(
                                            width: width,
                                            height: isDeviceScreenLarge() ? 148 : 124,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(k8BorderRadius),
                                              border: Border.all(color: cLineColor, width: 1),
                                            ),
                                            child: Column(
                                              children: [
                                                kH16sizedBox,
                                                Container(
                                                  width: 52,
                                                  height: 52,
                                                  decoration: const BoxDecoration(color: cNeutralColor, shape: BoxShape.circle),
                                                  child: const Icon(
                                                    BipHip.imageFile,
                                                    size: kIconSize28,
                                                    color: cIconColor,
                                                  ),
                                                ),
                                                Text(
                                                  ksAddPhotoAndVideo,
                                                  style: semiBold16TextStyle(cBlackColor),
                                                ),
                                                kH4sizedBox,
                                                Text(
                                                  ksOrDragAndDrop,
                                                  style: regular12TextStyle(cPlaceHolderColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      kH16sizedBox,
                                      Text(
                                        ksRequiredFields.tr,
                                        style: medium14TextStyle(cBlackColor),
                                      ),
                                      kH12sizedBox,
                                      CustomModifiedTextField(
                                        controller: TextEditingController(),
                                        hint: ksTitle.tr,
                                        onChanged: (text) {},
                                        onSubmit: (text) {},
                                        inputAction: TextInputAction.next,
                                        inputType: TextInputType.number,
                                        maxLength: 100,
                                      ),
                                      kH4sizedBox,
                                      TextAndIconRowSellingPost(
                                        text: ksCategory.tr,
                                        icon: BipHip.downArrow,
                                        onPressed: null,
                                      ),
                                      kH12sizedBox,
                                      TextAndIconRowSellingPost(
                                        text: ksCondition.tr,
                                        icon: BipHip.downArrow,
                                        onPressed: null,
                                      ),
                                      kH12sizedBox,
                                      CustomModifiedTextField(
                                        controller: TextEditingController(),
                                        hint: ksPrice.tr,
                                        onChanged: (text) {},
                                        onSubmit: (text) {},
                                        inputAction: TextInputAction.next,
                                        inputType: TextInputType.number,
                                        maxLength: 10,
                                      ),
                                      Text(
                                        'The Price now is 40',
                                        style: regular12TextStyle(cSmallBodyTextColor),
                                      ),
                                      kH12sizedBox,
                                      CustomModifiedTextField(
                                        controller: TextEditingController(),
                                        hint: ksDiscountAmountOptional.tr,
                                        onChanged: (text) {},
                                        onSubmit: (text) {},
                                        inputAction: TextInputAction.next,
                                        inputType: TextInputType.number,
                                        maxLength: 10,
                                      ),
                                      kH4sizedBox,
                                      CustomModifiedTextField(
                                        controller: TextEditingController(),
                                        hint: ksDescription.tr,
                                        onChanged: (text) {},
                                        onSubmit: (text) {},
                                        inputAction: TextInputAction.next,
                                        maxLength: 512,
                                        maxLines: 7,
                                      ),
                                      kH4sizedBox,
                                      TextAndIconRowSellingPost(
                                        text: ksAvailability.tr,
                                        icon: BipHip.downArrow,
                                        onPressed: null,
                                      ),
                                      kH12sizedBox,
                                      CustomModifiedTextField(
                                        controller: TextEditingController(),
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
                                        controller: TextEditingController(),
                                        hint: ksSKU.tr,
                                        onChanged: (text) {},
                                        onSubmit: (text) {},
                                        inputAction: TextInputAction.next,
                                        maxLength: 10,
                                      ),
                                      kH4sizedBox,
                                      TextAndIconRowSellingPost(
                                        text: ksLocation.tr,
                                        icon: BipHip.downArrow,
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
                                      kH12sizedBox,
                                      GridView.builder(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: h12, mainAxisSpacing: h12),
                                          itemCount: 7,
                                          itemBuilder: (context, index) {
                                            return Stack(
                                              children: [
                                                ClipRRect(
                                                    borderRadius: const BorderRadius.all(Radius.circular(k8BorderRadius)),
                                                    child: Image.asset(
                                                      kiDummyImage1ImageUrl,
                                                      height: isDeviceScreenLarge() ? 148 : 124,
                                                    )),
                                                //*Add Photo container
                                                // Container(
                                                //   height: isDeviceScreenLarge() ? 148 : 124,
                                                //   decoration: BoxDecoration(
                                                //     color: cWhiteColor,
                                                //     borderRadius: BorderRadius.circular(k8BorderRadius),
                                                //     border: Border.all(color: cLineColor2, width: 1),
                                                //   ),
                                                //   child: Column(
                                                //     mainAxisAlignment: MainAxisAlignment.center,
                                                //     children: [
                                                //       Container(
                                                //         width: 52,
                                                //         height: 52,
                                                //         decoration: const BoxDecoration(
                                                //           shape: BoxShape.circle,
                                                //           color: cNeutralColor,
                                                //         ),
                                                //         child: const Icon(
                                                //           BipHip.imageFile,
                                                //           size: kIconSize28,
                                                //           color: cIconColor,
                                                //         ),
                                                //       ),
                                                //       Text(
                                                //         ksAdd.tr,
                                                //         style: semiBold16TextStyle(cBlackColor),
                                                //       ),
                                                //     ],
                                                //   ),
                                                // ),

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
                                                      child: const Center(
                                                        child: Icon(
                                                          BipHip.cross,
                                                          color: cWhiteColor,
                                                          size: kIconSize14,
                                                        ),
                                                      ),
                                                    )),
                                              ],
                                            );
                                          }),
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
                    Positioned(
                      bottom: 44,
                      child: SizedBox(
                        width: width,
                        child: const CustomDivider(),
                      ),
                    ),
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
  const TextAndIconRowSellingPost({super.key, required this.text, this.icon, this.onPressed});
  final String text;
  final IconData? icon;
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: regular16TextStyle(cPlaceHolderColor),
              ),
              Icon(
                icon!,
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
