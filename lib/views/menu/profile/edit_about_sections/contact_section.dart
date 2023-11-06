import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_about.dart';

class ContactSection extends StatelessWidget {
  ContactSection({super.key});
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
            Text(
              ksContactDetails.tr,
              style: semiBold18TextStyle(cBlackColor),
            ),
            kH12sizedBox,
            Padding(
              padding: const EdgeInsets.only(bottom: k12Padding),
              child: InfoContainer2(
                suffixText: ksPhone.tr,
                isAddButton: true,
                suffixOnPressed: () {
                  _profileController.resetTextEditor();
                  _profileController.getMethod(11);
                },
              ),
            ),
            for (int i = 0; i < _profileController.contactDataList.length; i++)
              if (_profileController.contactDataList[i].type == 'phone')
                Padding(
                  padding: const EdgeInsets.only(bottom: k12Padding),
                  child: InfoContainer2(
                    suffixText: '',
                    prefixText: checkNullOrStringNull(_profileController.contactDataList[i].value),
                    isAddButton: false,
                    suffixOnPressed: () {
                      _profileController.resetTextEditor();
                      _profileController.enableSaveButton.value = true;
                      _profileController.phoneID.value = _profileController.contactDataList[i].id!;
                      _profileController.phoneTextEditingController.text = _profileController.contactDataList[i].value!;
                      _profileController.getMethod(12);
                    },
                  ),
                ),
            Padding(
              padding: const EdgeInsets.only(bottom: k12Padding),
              child: InfoContainer2(
                suffixText: ksEmail.tr,
                isAddButton: true,
                suffixOnPressed: () {
                  _profileController.resetTextEditor();
                  _profileController.getMethod(13);
                },
              ),
            ),
            for (int i = 0; i < _profileController.contactDataList.length; i++)
              if (_profileController.contactDataList[i].type == 'email')
                Padding(
                  padding: const EdgeInsets.only(bottom: k12Padding),
                  child: InfoContainer2(
                    suffixText: '',
                    prefixText: checkNullOrStringNull(_profileController.contactDataList[i].value),
                    isAddButton: false,
                    suffixOnPressed: () {
                      _profileController.resetTextEditor();
                      _profileController.enableSaveButton.value = true;
                      _profileController.emailID.value = _profileController.contactDataList[i].id!;
                      _profileController.emailTextEditingController.text = _profileController.contactDataList[i].value!;
                      _profileController.getMethod(14);
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
