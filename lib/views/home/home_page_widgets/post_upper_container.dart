import 'package:bip_hip/controllers/create_post_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/custom_outline_button.dart';

class PostUpperContainer extends StatelessWidget {
  PostUpperContainer({super.key});

  final CreatePostController _createPostController = Get.find<CreatePostController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kW8sizedBox,
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
                      "assets/images/profileDefault.png",
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
                    "assets/images/profileDefault.png",
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
                                  text: ' is with ',
                                  style: regular16TextStyle(cBlackColor),
                                ),
                              if (_createPostController.isTagAdded.value)
                                TextSpan(
                                  text: 'Shohag Jalal & 8 others',
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
                      CustomElevatedButton(
                        label: "Post Type",
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
                                  label: "Bidding Post",
                                  textStyle: medium14TextStyle(cBlackColor),
                                ),
                                kH8sizedBox,
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Selecting bidding post will let the user write their preferred bidding price.",
                                        style: regular12TextStyle(cSmallBodyTextColor),
                                      ),
                                    ),
                                  ],
                                ),
                                kH16sizedBox,
                                Text(
                                  "Or",
                                  style: regular16TextStyle(cPlaceHolderColor),
                                ),
                                kH16sizedBox,
                                Row(
                                  children: [
                                    Text(
                                      "Platform & Action",
                                      style: medium14TextStyle(cBlackColor),
                                    ),
                                  ],
                                ),
                                kH8sizedBox,
                                Row(
                                  children: [
                                    OutLinedButton(
                                      buttonText: "Select platform",
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
                                      buttonText: "Select CTA",
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
                            rightText: 'Done',
                            rightTextStyle: medium14TextStyle(cPrimaryColor),
                            title: "Post Type",
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
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
