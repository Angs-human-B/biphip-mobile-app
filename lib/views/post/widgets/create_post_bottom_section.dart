import 'package:bip_hip/helpers/post/create_post_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class CreatePostBottomSection extends StatelessWidget {
  CreatePostBottomSection({super.key});
  final CreatePostHelper createPostHelper = CreatePostHelper();

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
              onPressed: () async {
                createPostHelper.getBottomRowOnPressed(i + 1, context);
              },
              style: kTextButtonStyle,
              child: SizedBox(
                width: width * .25,
                height: 40,
                child: Icon(
                  createPostHelper.getBottomRowIcon(i + 1),
                  color: createPostHelper.getBottomIconColor(i + 1),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
