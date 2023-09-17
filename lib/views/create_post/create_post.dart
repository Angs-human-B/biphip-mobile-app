import 'package:bip_hip/controllers/create_post_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/custom_app_bar.dart';
import 'package:bip_hip/widgets/common/custom_button.dart';
import 'package:bip_hip/widgets/textfields/custom_textfield.dart';

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
                  child: Column(
                    children: [
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
                          contentPadding: const EdgeInsets.symmetric(horizontal: k16Padding, vertical: k16Padding),
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
                        Icon(
                          _createPostController.getBottomRowIcon(i + 1),
                          color: _createPostController.getBottomIconColor(i + 1),
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
