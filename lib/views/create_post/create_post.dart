import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_profile.dart';
import 'package:bip_hip/widgets/common/button/custom_outline_button.dart';

class CreatePost extends StatelessWidget {
  CreatePost({super.key});
  final CreatePostController _createPostController = Get.find<CreatePostController>();

  @override
  Widget build(BuildContext context) {
    ll(width);
    return Container(
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
                      onPressed: _createPostController.isPostButtonActive.value
                          ? () {
                              unfocus(context);
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // kW8sizedBox,
                              Stack(
                                children: [
                                  SizedBox(
                                    width: (_createPostController.category.value == "Kids" || _createPostController.category.value == "Selling") ? 70 : h45,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: h45,
                                          width: h45,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                            kiProfileDefaultImageUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (_createPostController.category.value == "Kids" || _createPostController.category.value == "Selling")
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
                                        child: Image.asset(
                                          kiProfileDefaultImageUrl,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              kW8sizedBox,
                              Expanded(
                                child: Column(
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
                                                      text: 'Jane Smith',
                                                      style: semiBold16TextStyle(cBlackColor),
                                                    ),
                                                    if (_createPostController.isTagAdded.value)
                                                      TextSpan(
                                                        text: ' ${ksIsWithSmall.tr} ',
                                                        style: regular16TextStyle(cBlackColor),
                                                      ),
                                                    if (_createPostController.isTagAdded.value)
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
                                          CustomElevatedButton(
                                            isCustomButton: true,
                                            label: _createPostController.postType.value,
                                            prefixIcon: _createPostController.postTypeIcon.value,
                                            onPressed: () {
                                              _createPostController.initializeAudienceText();
                                              _createPostController.showAudienceSheet(context);
                                            },
                                            buttonHeight: 22,
                                            suffixIcon: BipHip.downArrow,
                                            buttonColor: cGreyBoxColor,
                                            prefixIconColor: cBlackColor,
                                            suffixIconColor: cBlackColor,
                                            textStyle: medium12TextStyle(cBlackColor),
                                          ),
                                          kW8sizedBox,
                                          CustomElevatedButton(
                                            label: _createPostController.category.value == "" ? "Select Category" : _createPostController.category.value,
                                            prefixIcon: _createPostController.category.value == "" ? null : _createPostController.categoryIcon.value,
                                            prefixIconColor: _createPostController.category.value == "" ? null : _createPostController.categoryIconColor.value,
                                            onPressed: () {
                                              _createPostController.initializeCategory();
                                              Get.toNamed(krSelectCategory);
                                            },
                                            buttonHeight: 22,
                                            isCustomButton: true,
                                            suffixIcon: _createPostController.category.value == "" ? BipHip.plus : BipHip.edit,
                                            buttonColor: cGreyBoxColor,
                                            suffixIconColor: cBlackColor,
                                            textStyle: medium12TextStyle(cBlackColor),
                                          ),
                                          if (_createPostController.category.value == "Selling") kW8sizedBox,
                                          if (_createPostController.category.value == "Selling")
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
                                                              buttonText: ksSelectCTA.tr,
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
                                                    onPressRightButton: () {
                                                      Get.back();
                                                    },
                                                    rightText: ksDone.tr,
                                                    rightTextStyle: medium14TextStyle(cPrimaryColor),
                                                    title: ksPostType.tr,
                                                    isRightButtonShow: true,
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
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Obx(
                            () => CustomModifiedTextField(
                              controller: _createPostController.createPostTEController,
                              maxLength: 1000,
                              maxLines: 100,
                              minLines: 1,
                              isFilled: false,
                              fillColor: cWhiteColor,
                              inputAction: TextInputAction.newline,
                              inputType: TextInputType.multiline,
                              hint: "${ksWhatsOnYourMind.tr}, Rana?",
                              contentPadding: const EdgeInsets.symmetric(horizontal: k8Padding, vertical: k16Padding),
                              textHintStyle: regular20TextStyle(cPlaceHolderColor),
                              textInputStyle:
                                  _createPostController.isTextLimitCrossed.value ? regular16TextStyle(cBlackColor) : regular20TextStyle(cBlackColor),
                              onChanged: (v) {
                                _createPostController.postButtonStateCheck();
                              },
                            ),
                          ),
                          // if (_createPostController.isCreatePostImageChanged.value)
                          if (_createPostController.allMediaList.isNotEmpty)
                            Obx(
                              () => Container(
                                color: cWhiteColor,
                                height: 302,
                                width: width - 40,
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        TextButton(
                                          style: kTextButtonStyle,
                                          onPressed: () {},
                                          child: Container(
                                            color: cWhiteColor,
                                            height: _createPostController.allMediaList.length < 2 ? 302 : 150,
                                            width: width - 40,
                                            child: Image.file(
                                              _createPostController.allMediaFileList[0].value,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 5,
                                          right: 5,
                                          child: TextButton(
                                            style: kTextButtonStyle,
                                            onPressed: () {
                                              _createPostController.removeMedia(0);
                                            },
                                            child: const Icon(
                                              BipHip.circleCrossNew,
                                              color: cWhiteColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (_createPostController.allMediaList.length > 1)
                                      const SizedBox(
                                        height: 2,
                                      ),
                                    Row(
                                      children: [
                                        if (_createPostController.allMediaList.length > 1)
                                          Stack(
                                            children: [
                                              TextButton(
                                                style: kTextButtonStyle,
                                                onPressed: () {},
                                                child: Container(
                                                  color: cWhiteColor,
                                                  height: 150,
                                                  width: _createPostController.allMediaList.length < 3 ? (width - 40) : (width - 42) / 2,
                                                  child: Image.file(
                                                    _createPostController.allMediaFileList[1].value,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 5,
                                                right: 5,
                                                child: TextButton(
                                                  style: kTextButtonStyle,
                                                  onPressed: () {
                                                    _createPostController.removeMedia(1);
                                                  },
                                                  child: const Icon(
                                                    BipHip.circleCrossNew,
                                                    color: cWhiteColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        if (_createPostController.allMediaList.length > 2)
                                          const SizedBox(
                                            width: 2,
                                          ),
                                        if (_createPostController.allMediaList.length > 2)
                                          Stack(
                                            alignment: AlignmentDirectional.center,
                                            children: [
                                              TextButton(
                                                style: kTextButtonStyle,
                                                onPressed: () {
                                                  if (_createPostController.allMediaList.length > 3) {
                                                    Get.toNamed(krUploadedImageListPage);
                                                  }
                                                },
                                                child: Container(
                                                  color: cWhiteColor,
                                                  height: 150,
                                                  width: (width - 42) / 2,
                                                  child: Image.file(
                                                    _createPostController.allMediaFileList[2].value,
                                                    fit: BoxFit.cover,
                                                    color: cBlackColor.withOpacity(0.3),
                                                    colorBlendMode: BlendMode.multiply,
                                                  ),
                                                ),
                                              ),
                                              if (_createPostController.allMediaList.length == 3)
                                                Positioned(
                                                  top: 5,
                                                  right: 5,
                                                  child: TextButton(
                                                    style: kTextButtonStyle,
                                                    onPressed: () {
                                                      _createPostController.removeMedia(2);
                                                    },
                                                    child: const Icon(
                                                      BipHip.circleCrossNew,
                                                      color: cWhiteColor,
                                                    ),
                                                  ),
                                                ),
                                              if (_createPostController.allMediaList.length > 3)
                                                Positioned(
                                                  child: TextButton(
                                                    style: kTextButtonStyle,
                                                    onPressed: () {
                                                      Get.toNamed(krUploadedImageListPage);
                                                    },
                                                    child: Text(
                                                      "${_createPostController.allMediaList.length - 2} ${ksMore.tr}",
                                                      style: semiBold16TextStyle(cWhiteColor),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          if (_createPostController.category.value == "Selling" || _createPostController.category.value == "News")
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (_createPostController.allMediaList.isNotEmpty) kH20sizedBox,
                                Text(
                                  ksRequiredFields.tr,
                                  style: medium14TextStyle(cBlackColor),
                                ),
                                kH8sizedBox,
                                CustomModifiedTextField(
                                  controller: TextEditingController(),
                                  hint: ksTitle.tr,
                                  onChanged: (text) {},
                                  onSubmit: (text) {},
                                  inputAction: TextInputAction.next,
                                  inputType: TextInputType.number,
                                  maxLength: 100,
                                ),
                                if (_createPostController.category.value == "Selling") kH8sizedBox,
                                if (_createPostController.category.value == "Selling")
                                  CustomModifiedTextField(
                                    controller: TextEditingController(),
                                    hint: ksPrice.tr,
                                    onChanged: (text) {},
                                    onSubmit: (text) {},
                                    inputAction: TextInputAction.next,
                                    inputType: TextInputType.number,
                                    maxLength: 10,
                                  ),
                                kH8sizedBox,
                                CustomModifiedTextField(
                                  controller: TextEditingController(),
                                  hint: ksDescription.tr,
                                  onChanged: (text) {},
                                  onSubmit: (text) {},
                                  inputAction: TextInputAction.next,
                                  inputType: TextInputType.number,
                                  maxLength: 512,
                                  maxLines: 7,
                                ),
                              ],
                            ),

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
                child: Container(
                  color: cWhiteColor,
                  width: width,
                  height: 44,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (int i = 0; i < 4; i++)
                        TextButton(
                          onPressed: () {
                            _createPostController.getBottomRowOnPressed(i + 1, context);
                          },
                          style: kTextButtonStyle,
                          child: SizedBox(
                            width: width * .25,
                            height: 40,
                            child: Icon(
                              _createPostController.getBottomRowIcon(i + 1),
                              color: _createPostController.getBottomIconColor(i + 1),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
