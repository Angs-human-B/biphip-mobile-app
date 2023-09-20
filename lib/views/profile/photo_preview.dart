import 'package:bip_hip/controllers/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class PhotoPreview extends StatelessWidget {
  PhotoPreview({super.key});

  final ProfileController _profileController = Get.find<ProfileController>();

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
              title: 'Preview profile picture'.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
              action: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: TextButton(
                      style: kTextButtonStyle,
                      onPressed: () {},
                      child: Text(
                        'Cancel',
                        style: regular14TextStyle(cRedColor),
                      )),
                )
              ],
            ),
          ),
          body: SizedBox(
            height: height - kAppBarSize,
            width: width,
            child: Obx(
              () => Column(
                children: [
                  kH20sizedBox,
                  Container(
                    width: width,
                    color: cBlackColor,
                    child: Container(
                        height: width,
                        width: width,
                        decoration: BoxDecoration(
                          color: cGreyBoxColor,
                          borderRadius: BorderRadius.circular(width / 2),
                        ),
                        child: ClipOval(
                          child: Image.file(
                            _profileController.profileImageFile.value,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => ClipOval(
                              child: Image.asset(
                                'assets/images/profileDefault.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )),
                  ),
                  kH24sizedBox,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Share your update to news feed',
                          style: regular18TextStyle(cBlackColor),
                        ),
                        Checkbox(
                            value: _profileController.isSharedToNewFeed.value,
                            onChanged: (value) {
                              _profileController.isSharedToNewFeed.value = !_profileController.isSharedToNewFeed.value;
                            })
                      ],
                    ),
                  ),
                  const Spacer(),
                  CustomElevatedButton(buttonWidth: width - 40, buttonHeight: h32, label: 'Save', onPressed: () {}),
                  kHBottomSizedBox
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
