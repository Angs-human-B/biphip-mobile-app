import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/create_post/create_post_widget/create_post_bottom_section.dart';
import 'package:bip_hip/views/create_post/create_post_widget/create_post_media_section.dart';
import 'package:bip_hip/views/create_post/create_post_widget/create_post_selling_text_fields.dart';
import 'package:bip_hip/views/create_post/create_post_widget/create_post_upper_section.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';

class CreatePost extends StatelessWidget {
  CreatePost({super.key});
  final CreatePostController _createPostController = Get.find<CreatePostController>();

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
                            onPressed: _createPostController.isPostButtonActive.value
                                ? () async {
                                    await _createPostController.createPost();
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
                                Obx(
                                  () => CustomModifiedTextField(
                                    controller: _createPostController.createPostController,
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
                                        _createPostController.isTextLimitCrossed.value ? regular16TextStyle(cBlackColor) : regular20TextStyle(cBlackColor),
                                    onChanged: (v) {
                                      _createPostController.postButtonStateCheck();
                                    },
                                  ),
                                ),
                                if (_createPostController.allMediaList.isNotEmpty)
                                  CreatePostMediaSection(),
                                if (_createPostController.category.value == "Selling" || _createPostController.category.value == "News")
                                  SellingNewsTextfield(),
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
          if (_createPostController.isCreatePostLoading.value == true)
            Positioned(
              child: CommonLoadingAnimation(
                onWillPop: () async {
                  if (_createPostController.isCreatePostLoading.value) {
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
