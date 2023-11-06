import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_about.dart';

class WebsiteSection extends StatelessWidget {
  WebsiteSection({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kH16sizedBox,
            Padding(
              padding: const EdgeInsets.only(bottom: k12Padding),
              child: InfoContainer2(
                suffixText: ksWebsiteAndSocialLinks.tr,
                suffixTextStyle: semiBold18TextStyle(cBlackColor),
                isAddButton: true,
                suffixOnPressed: () {
                  _profileController.resetTextEditor();
                  _profileController.linkSource.value = '';
                  _profileController.commonEditPageIcon.value = null;
                  _profileController.getMethod(15);
                },
              ),
            ),
            for (int i = 0; i < _profileController.linkDataList.length; i++)
              if (_profileController.showAllEditOption.value)
                Padding(
                  padding: const EdgeInsets.only(bottom: k12Padding),
                  child: InfoContainer2(
                    suffixText: '',
                    prefixText: checkNullOrStringNull(_profileController.linkDataList[i].link),
                    isAddButton: false,
                    suffixOnPressed: () {
                      _profileController.resetTextEditor();
                      _profileController.enableSaveButton.value = true;
                      _profileController.commonEditPageIcon.value = null;
                      _profileController.linkTextEditingController.text = _profileController.linkDataList[i].link!;
                      _profileController.linkID.value = _profileController.linkDataList[i].id!;
                      _profileController.linkSource.value = _profileController.linkDataList[i].type!;
                      _profileController.getMethod(16);
                    },
                  ),
                ),
            kH4sizedBox
          ],
        ),
      ),
    );
  }
}
