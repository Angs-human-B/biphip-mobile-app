import 'package:bip_hip/utils/constants/imports.dart';

class CreatePostController extends GetxController {
  // final ApiController _apiController = ApiController();
  // final SpController _spController = SpController();
  // final GlobalController _globalController = Get.find<GlobalController>();

  final RxBool isPostButtonActive = RxBool(false);
  final RxBool isTextLimitCrossed = RxBool(false);
  final TextEditingController createPostTEController = TextEditingController();
  final RxString postType = RxString('');
  final RxBool isTagAdded = RxBool(false);

  void postButtonStateCheck() {
    if (createPostTEController.text.trim().isNotEmpty) {
      isPostButtonActive.value = true;
      if (createPostTEController.text.length > 150) {
        isTextLimitCrossed.value = true;
      } else {
        isTextLimitCrossed.value = false;
      }
    } else {
      isPostButtonActive.value = false;
    }
  }

  IconData getBottomRowIcon(index) {
    if (index == 1) {
      return BipHip.photo;
    }
    if (index == 2) {
      return BipHip.camera;
    }
    if (index == 3) {
      return BipHip.video;
    } else {
      return BipHip.tagFriends;
    }
  }

  Color getBottomIconColor(index) {
    if (index == 1) {
      return cGreenColor;
    }
    if (index == 2) {
      return cPrimaryColor;
    }
    if (index == 3) {
      return cRedColor;
    } else {
      return cSecondaryColor;
    }
  }
}
