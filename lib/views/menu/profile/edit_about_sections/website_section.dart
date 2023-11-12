import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/profile/edit_profile_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_about.dart';

class WebsiteSection extends StatelessWidget {
  WebsiteSection({super.key});
  final ProfileController profileController = Get.find<ProfileController>();
  final EditProfileHelper editProfileHelper = EditProfileHelper();

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
                  editProfileHelper.addWebsite();
                },
              ),
            ),
            for (int i = 0; i < profileController.linkDataList.length; i++)
              if (profileController.showAllEditOption.value)
                Padding(
                  padding: const EdgeInsets.only(bottom: k12Padding),
                  child: InfoContainer2(
                    suffixText: '',
                    prefixText: checkNullOrStringNull(profileController.linkDataList[i].link),
                    isAddButton: false,
                    suffixOnPressed: () {
                      editProfileHelper.editWebsite(i);
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
