import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/helpers/post/create_post_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class UploadImageListPage extends StatelessWidget {
  UploadImageListPage({super.key});

  final CreatePostController createPostController = Get.find<CreatePostController>();
  final CreatePostHelper createPostHelper = CreatePostHelper();

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
            child: CustomAppBar(
              appBarColor: cWhiteColor,
              title: ksImages.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
              action: [
                Padding(
                  padding: const EdgeInsets.only(right: h16),
                  child: TextButton(
                    style: kTextButtonStyle,
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      ksDone.tr,
                      style: medium14TextStyle(cPrimaryColor),
                    ),
                  ),
                )
              ],
            ),
          ),
          body: SizedBox(
            height: height - kAppBarSize,
            width: width,
            child: SingleChildScrollView(
              child: Obx(
                () => Column(
                  children: [kH8sizedBox, for (int i = 0; i < createPostController.allMediaFileList.length; i++) SeparateImageView(index: i)],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SeparateImageView extends StatelessWidget {
  SeparateImageView({super.key, required this.index});
  final CreatePostController createPostController = Get.find<CreatePostController>();
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: k4Padding),
              child: TextButton(
                style: kTextButtonStyle,
                onPressed: () {},
                child: Container(
                  color: cWhiteColor,
                  height: 150,
                  width: width - 40,
                  child: Image.file(
                    createPostController.allMediaFileList[index].value,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: TextButton(
                style: kTextButtonStyle,
                onPressed: () {
                  CreatePostHelper().removeMedia(index);
                  createPostController.imageDescriptionTextEditingController[index].clear();
                  createPostController.imageLocationsList.removeAt(index);
                  createPostController.imageTimesList.removeAt(index);
                  createPostController.imageTagIdList.removeAt(index);
                },
                child: const Icon(
                  BipHip.circleCrossNew,
                  color: cWhiteColor,
                ),
              ),
            ),
          ],
        ),
       
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: CustomModifiedTextField(
            controller: createPostController.imageDescriptionTextEditingController[index],
            maxLength: 1000,
            maxLines: 100,
            minLines: 1,
            isFilled: false,
            fillColor: cWhiteColor,
            inputAction: TextInputAction.newline,
            inputType: TextInputType.multiline,
            hint: ksAddACaption.tr,
            contentPadding: const EdgeInsets.symmetric(vertical: k12Padding),
            textHintStyle: regular14TextStyle(cPlaceHolderColor),
            textInputStyle: regular14TextStyle(cBlackColor),
            onChanged: (v) {},
          ),
        ),
      ],
    );
  }
}
