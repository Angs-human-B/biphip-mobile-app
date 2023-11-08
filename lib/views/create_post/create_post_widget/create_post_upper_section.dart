import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/helpers/create_post_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_outline_button.dart';

class CreatePostUpperSection extends StatelessWidget {
  CreatePostUpperSection({super.key});
  final CreatePostController _createPostController = Get.find<CreatePostController>();
  final CreatePostHelper _createPostHelper = Get.find<CreatePostHelper>();

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
                width: (_createPostController.category.value == "Kids" || _createPostController.category.value == "Selling") ? 70 : h45,
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
                    child: ClipOval(
                      child: _createPostController.selectedKid.value != null
                          ? Image.network(
                              Environment.imageBaseUrl + _createPostController.postSecondaryCircleAvatar.value,
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
                                _createPostController.postSecondaryLocalCirclerAvatar.value,
                                fit: BoxFit.cover,
                              ),
                            ),
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
                                  text: Get.find<GlobalController>().userName.value.toString(),
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
                          _createPostHelper.initializeAudienceText();
                          _createPostHelper.showAudienceSheet(context);
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
                        onPressed: () async {
                          _createPostHelper.initializeCategory();
                          Get.toNamed(krSelectCategory);
                          await _createPostController.getPostCategoryList();
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
    );
  }
}
