import 'package:bip_hip/controllers/create_post_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class CreatePost extends StatelessWidget {
  CreatePost({super.key});
  final CreatePostController _createPostController = Get.find<CreatePostController>();

  @override
  Widget build(BuildContext context) {
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
              title: 'Create post'.tr,
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
                      label: "Post",
                      onPressed: _createPostController.isPostButtonActive.value ? () {} : null,
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
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            kW8sizedBox,
                            Stack(
                              children: [
                                SizedBox(
                                  width: (_createPostController.postType.value == "kids" || _createPostController.postType.value == "selling") ? 70 : h45,
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
                                if (_createPostController.postType.value == "kids" || _createPostController.postType.value == "selling")
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    top: 0,
                                    child: Container(
                                      height: h50,
                                      width: h50,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        "assets/images/profilePic.png",
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
                                  Row(
                                    children: [
                                      Obx(
                                        () => CustomElevatedButton(
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
                                      ),
                                      kW8sizedBox,
                                      CustomElevatedButton(
                                        label: _createPostController.category.value == "" ? "Select Category" : _createPostController.category.value,
                                        prefixIcon: _createPostController.category.value == "" ? null : BipHip.sellNew,
                                        prefixIconColor: _createPostController.category.value == "" ? null : cPrimaryColor,
                                        onPressed: () {
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
                                          label: "Web",
                                          onPressed: () {},
                                          buttonHeight: 22,
                                          isCustomButton: true,
                                          suffixIcon: BipHip.edit,
                                          prefixIcon: BipHip.webLink,
                                          buttonColor: cGreyBoxColor,
                                          suffixIconColor: cBlackColor,
                                          prefixIconColor: cPrimaryColor,
                                          textStyle: medium12TextStyle(cBlackColor),
                                        ),
                                    ],
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
                            hint: "What's on your mind, Rana?",
                            contentPadding: const EdgeInsets.symmetric(horizontal: k8Padding, vertical: k16Padding),
                            textHintStyle: regular20TextStyle(cPlaceHolderColor),
                            textInputStyle: _createPostController.isTextLimitCrossed.value ? regular16TextStyle(cBlackColor) : regular20TextStyle(cBlackColor),
                            onChanged: (v) {
                              _createPostController.postButtonStateCheck();
                            },
                          ),
                        ),
                        kH50sizedBox,
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                child: SizedBox(
                  width: width,
                  child: const Divider(
                    thickness: 1,
                    height: 1,
                    color: cLineColor,
                  ),
                ),
              ),
              Positioned(
                bottom: 44,
                child: SizedBox(
                  width: width,
                  child: const Divider(
                    thickness: 1,
                    height: 1,
                    color: cLineColor,
                  ),
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
                            _createPostController.getBottomRowOnPressed(i + 1);
                          },
                          style: kTextButtonStyle,
                          child: Icon(
                            _createPostController.getBottomRowIcon(i + 1),
                            color: _createPostController.getBottomIconColor(i + 1),
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
