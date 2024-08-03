import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/profile/edit_profile_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_about.dart';

class ContactSection extends StatelessWidget {
  ContactSection({super.key});
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
            Text(
              ksContactDetails.tr,
              style: semiBold18TextStyle(cBlackColor),
            ),
            kH12sizedBox,
            Padding(
              padding: const EdgeInsets.only(bottom: k12Padding),
              child: InfoContainer(
                suffixText: ksPhone.tr,
                isAddButton: true,
                suffixOnPressed: () {
                  editProfileHelper.addPhone();
                },
              ),
            ),
            for (int i = 0; i < profileController.contactDataList.length; i++)
              if (profileController.contactDataList[i].type == 'phone')
                Padding(
                  padding: const EdgeInsets.only(bottom: k12Padding),
                  child: InfoContainer(
                    suffixText: '',
                    prefixText: checkNullOrStringNull(profileController.contactDataList[i].value),
                    isAddButton: false,
                    suffixOnPressed: () {
                      editProfileHelper.editPhone(i);
                    },
                  ),
                ),
            Padding(
              padding: const EdgeInsets.only(bottom: k12Padding),
              child: InfoContainer(
                suffixText: ksEmail.tr,
                isAddButton: true,
                suffixOnPressed: () {
                  editProfileHelper.addEmail();
                },
              ),
            ),
            for (int i = 0; i < profileController.contactDataList.length; i++)
              if (profileController.contactDataList[i].type == 'email')
                Padding(
                  padding: const EdgeInsets.only(bottom: k12Padding),
                  child: InfoContainer(
                    suffixText: '',
                    prefixText: checkNullOrStringNull(profileController.contactDataList[i].value),
                    isAddButton: false,
                    suffixOnPressed: () {
                      editProfileHelper.editEmail(i);
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
