import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/helpers/post/create_post_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class SellingNewsTextfield extends StatelessWidget {
  SellingNewsTextfield({super.key});
  final CreatePostController createPostController = Get.find<CreatePostController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (createPostController.allMediaList.isNotEmpty) kH20sizedBox,
        Text(
          ksRequiredFields.tr,
          style: medium14TextStyle(cBlackColor),
        ),
        kH8sizedBox,
        CustomModifiedTextField(
          controller: createPostController.newsTitleTextEditingController,
          hint: ksTitle.tr,
          onChanged: (text) {
            CreatePostHelper().checkCanCreatePost();
          },
          onSubmit: (text) {},
          inputAction: TextInputAction.next,
          inputType: TextInputType.text,
          maxLength: 100,
        ),
        if (createPostController.category.value == "Selling") kH8sizedBox,
        kH8sizedBox,
        CustomModifiedTextField(
          controller: createPostController.newsDescriptionTextEditingController,
          hint: ksDescription.tr,
          onChanged: (text) {
            CreatePostHelper().checkCanCreatePost();
          },
          onSubmit: (text) {},
          inputAction: TextInputAction.newline,
          inputType: TextInputType.multiline,
          maxLength: 512,
          maxLines: 7,
        ),
      ],
    );
  }
}
