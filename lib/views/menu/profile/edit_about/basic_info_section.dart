import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/profile/edit_profile_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_about.dart';
import 'package:intl/intl.dart';

class EditInfoSection extends StatelessWidget {
  EditInfoSection({super.key});
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
            InfoContainer(
              suffixText: ksBasicInfo.tr,
              suffixTextStyle: semiBold18TextStyle(cBlackColor),
              suffixOnPressed: () {
                Get.toNamed(krEditBasicInfo);
              },
            ),
            kH16sizedBox,
            InfoContainer(
              suffixText: profileController.userData.value!.gender == null
                  ? ksGender.tr
                  : checkNullOrStringNull(profileController.userData.value!.gender.toString().trim()),
              subtitlePrefixText: ksGender,
              isAddButton: false,
              suffixOnPressed: () {
                Get.toNamed(krEditBasicInfo);
              },
            ),
            kH16sizedBox,
            InfoContainer(
              suffixText:
                  profileController.userData.value!.dob == null ? ksDateOfBirth.tr : DateFormat("yyyy-MM-dd").format(profileController.userData.value!.dob!),
              subtitlePrefixText: ksDateOfBirth.tr,
              isAddButton: false,
              suffixOnPressed: () {
                editProfileHelper.editBirthday();
              },
            ),
            kH16sizedBox,
            InfoContainer(
              suffixOnPressed: () {
                Get.toNamed(krEditBasicInfo);
              },
              suffixText: profileController.userData.value!.languages.isEmpty
                  ? ksLanguage.tr
                  : editProfileHelper.languageSorting(profileController.userData.value!.languages),
              isAddButton: profileController.userData.value!.languages.isEmpty ? true : false,
              subtitlePrefixText: profileController.userData.value!.languages.isEmpty ? null : ksLanguages.tr,
            ),
            kH16sizedBox,
          ],
        ),
      ),
    );
  }
}
