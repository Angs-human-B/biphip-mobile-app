import 'package:bip_hip/controllers/post/create_post_controller.dart';
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
          controller: TextEditingController(),
          hint: ksTitle.tr,
          onChanged: (text) {},
          onSubmit: (text) {},
          inputAction: TextInputAction.next,
          inputType: TextInputType.number,
          maxLength: 100,
        ),
        if (createPostController.category.value == "Selling") kH8sizedBox,
        if (createPostController.category.value == "Selling")
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
    );
  
  }
}
