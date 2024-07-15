import 'package:bip_hip/controllers/post/create_post_controller.dart';
import 'package:bip_hip/helpers/post/create_post_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class CreatePostMediaSection extends StatelessWidget {
  CreatePostMediaSection({super.key});
  final CreatePostController createPostController = Get.find<CreatePostController>();
  final CreatePostHelper createPostHelper = CreatePostHelper();

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
                  onPressed: () {
                    if (createPostController.allMediaList.length > 1) {
                      Get.toNamed(krUploadedImageListPage);
                    }
                  },
                  child: Container(
                    color: cWhiteColor,
                    height: (createPostController.allMediaList.length < 2) ? 302 : 150,
                    width: width - 40,
                    child: createPostController.allMediaList[0] is String
                        ? Image.network(
                            createPostController.allMediaList[0] ?? "",
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            createPostController.allMediaList[0].value,
                            filterQuality: FilterQuality.high,
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
                      createPostHelper.removeMedia(0);
                      if (createPostController.isEditPost.value) {
                        if (createPostController.allMediaList.isEmpty && createPostController.createPostTextEditingController.text.trim() == "") {
                          createPostController.isPostButtonActive.value = false;
                        } else {
                          createPostController.isImageChanged.value = true;
                          createPostController.isPostButtonActive.value = true;
                        }
                      } else {
                        createPostHelper.checkCanCreatePost();
                      }
                      createPostController.imageDescriptionTextEditingController[0].clear();
                      createPostController.imageLocationsList.removeAt(0);
                      createPostController.imageTimesList.removeAt(0);
                      createPostController.imageTagIdList.removeAt(0);
                    },
                    child: const Icon(
                      BipHip.circleCrossNew,
                      color: cWhiteColor,
                    ),
                  ),
                ),
              ],
            ),
            if (createPostController.allMediaList.length > 1)
              const SizedBox(
                height: 2,
              ),
            Row(
              children: [
                if (createPostController.allMediaList.length > 1)
                  Stack(
                    children: [
                      TextButton(
                        style: kTextButtonStyle,
                        onPressed: () {
                          Get.toNamed(krUploadedImageListPage);
                        },
                        child: Container(
                          color: cWhiteColor,
                          height: 150,
                          width: (createPostController.allMediaList.length < 3) ? (width - 40) : (width - 42) / 2,
                          child: createPostController.allMediaList[1] is String
                              ? Image.network(
                                  createPostController.allMediaList[1] ?? "",
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  createPostController.allMediaList[1].value,
                                  filterQuality: FilterQuality.high,
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
                            createPostHelper.removeMedia(1);
                            if (createPostController.isEditPost.value) {
                              createPostController.isImageChanged.value = true;
                              createPostController.isPostButtonActive.value = true;
                            }
                            createPostController.imageDescriptionTextEditingController[1].clear();
                            createPostController.imageLocationsList.removeAt(1);
                            createPostController.imageTimesList.removeAt(1);
                            createPostController.imageTagIdList.removeAt(1);
                          },
                          child: const Icon(
                            BipHip.circleCrossNew,
                            color: cWhiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                if (createPostController.allMediaList.length > 2)
                  const SizedBox(
                    width: 2,
                  ),
                if (createPostController.allMediaList.length > 2)
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      TextButton(
                        style: kTextButtonStyle,
                        onPressed: () {
                          Get.toNamed(krUploadedImageListPage);
                        },
                        child: Container(
                          color: cWhiteColor,
                          height: 150,
                          width: (width - 42) / 2,
                          child: createPostController.allMediaList[2] is String?
                              ? Image.network(
                                  createPostController.allMediaList[2] ?? "",
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  createPostController.allMediaList[2].value,
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.cover,
                                  color: cBlackColor.withOpacity(0.3),
                                  colorBlendMode: BlendMode.multiply,
                                ),
                        ),
                      ),
                      if (createPostController.allMediaList.length == 3)
                        Positioned(
                          top: 5,
                          right: 5,
                          child: TextButton(
                            style: kTextButtonStyle,
                            onPressed: () {
                              if (createPostController.isEditPost.value) {
                                createPostController.isImageChanged.value = true;
                                createPostController.isPostButtonActive.value = true;
                              }
                              createPostHelper.removeMedia(2);
                            },
                            child: const Icon(
                              BipHip.circleCrossNew,
                              color: cWhiteColor,
                            ),
                          ),
                        ),
                      if (createPostController.allMediaList.length > 3)
                        Positioned(
                          child: TextButton(
                            style: kTextButtonStyle,
                            onPressed: () {
                              Get.toNamed(krUploadedImageListPage);
                            },
                            child: Text(
                              "${createPostController.allMediaList.length - 2} ${ksMore.tr}",
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
