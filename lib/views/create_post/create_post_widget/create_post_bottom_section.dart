import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class CreatePostBottomSection extends StatelessWidget {
  CreatePostBottomSection({super.key});
  final CreatePostController _createPostController = Get.find<CreatePostController>();

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
