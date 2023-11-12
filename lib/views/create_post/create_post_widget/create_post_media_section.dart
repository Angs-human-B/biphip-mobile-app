import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class CreatePostMediaSection extends StatelessWidget {
  CreatePostMediaSection({super.key});
  final CreatePostController _createPostController = Get.find<CreatePostController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        color: cWhiteColor,
        height: 302,
        width: width - 40,
        child: Column(
          children: [
            Stack(
              children: [
                TextButton(
                  style: kTextButtonStyle,
                  onPressed: () {},
                  child: Container(
                    color: cWhiteColor,
                    height: _createPostController.allMediaList.length < 2 ? 302 : 150,
                    width: width - 40,
                    child: Image.file(
                      _createPostController.allMediaFileList[0].value,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: TextButton(
                    style: kTextButtonStyle,
                    onPressed: () {
                      _createPostController.removeMedia(0);
                    },
                    child: const Icon(
                      BipHip.circleCrossNew,
                      color: cWhiteColor,
                    ),
                  ),
                ),
              ],
            ),
            if (_createPostController.allMediaList.length > 1)
              const SizedBox(
                height: 2,
              ),
            Row(
              children: [
                if (_createPostController.allMediaList.length > 1)
                  Stack(
                    children: [
                      TextButton(
                        style: kTextButtonStyle,
                        onPressed: () {},
                        child: Container(
                          color: cWhiteColor,
                          height: 150,
                          width: _createPostController.allMediaList.length < 3 ? (width - 40) : (width - 42) / 2,
                          child: Image.file(
                            _createPostController.allMediaFileList[1].value,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 5,
                        child: TextButton(
                          style: kTextButtonStyle,
                          onPressed: () {
                            _createPostController.removeMedia(1);
                          },
                          child: const Icon(
                            BipHip.circleCrossNew,
                            color: cWhiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                if (_createPostController.allMediaList.length > 2)
                  const SizedBox(
                    width: 2,
                  ),
                if (_createPostController.allMediaList.length > 2)
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      TextButton(
                        style: kTextButtonStyle,
                        onPressed: () {
                          if (_createPostController.allMediaList.length > 3) {
                            Get.toNamed(krUploadedImageListPage);
                          }
                        },
                        child: Container(
                          color: cWhiteColor,
                          height: 150,
                          width: (width - 42) / 2,
                          child: Image.file(
                            _createPostController.allMediaFileList[2].value,
                            fit: BoxFit.cover,
                            color: cBlackColor.withOpacity(0.3),
                            colorBlendMode: BlendMode.multiply,
                          ),
                        ),
                      ),
                      if (_createPostController.allMediaList.length == 3)
                        Positioned(
                          top: 5,
                          right: 5,
                          child: TextButton(
                            style: kTextButtonStyle,
                            onPressed: () {
                              _createPostController.removeMedia(2);
                            },
                            child: const Icon(
                              BipHip.circleCrossNew,
                              color: cWhiteColor,
                            ),
                          ),
                        ),
                      if (_createPostController.allMediaList.length > 3)
                        Positioned(
                          child: TextButton(
                            style: kTextButtonStyle,
                            onPressed: () {
                              Get.toNamed(krUploadedImageListPage);
                            },
                            child: Text(
                              "${_createPostController.allMediaList.length - 2} ${ksMore.tr}",
                              style: semiBold16TextStyle(cWhiteColor),
                            ),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
