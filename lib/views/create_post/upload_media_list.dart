import 'package:bip_hip/controllers/create_post_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class UploadImageListPage extends StatelessWidget {
  UploadImageListPage({super.key});

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
                  children: [
                    kH8sizedBox,
                    for (int i = 0; i < _createPostController.allMediaFileList.length; i++)
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: h16),
                            child: TextButton(
                              style: kTextButtonStyle,
                              onPressed: () {},
                              child: Container(
                                color: cWhiteColor,
                                height: 150,
                                width: width - 40,
                                child: Image.file(
                                  _createPostController.allMediaFileList[i].value,
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
                                _createPostController.removeMedia(i);
                              },
                              child: const Icon(
                                BipHip.circleCrossNew,
                                color: cWhiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
