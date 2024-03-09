import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/helpers/menu/kids/kid_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/kids/kid_profile/edit_kid_gender_section.dart';
import 'package:bip_hip/views/menu/profile/edit_about.dart';
import 'package:intl/intl.dart';

class KidBasicInfoSection extends StatelessWidget {
  KidBasicInfoSection({super.key});
  final KidsController kidsController = Get.find<KidsController>();
  final KidHelper kidHelper = KidHelper();

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
              suffixOnPressed: null,
            ),
            kH16sizedBox,
            InfoContainer(
              // suffixText: profileController.userData.value!.gender == null
              //     ? ksGender.tr
              //     : checkNullOrStringNull(profileController.userData.value!.gender.toString().trim()),
              suffixText: kidsController.kidGender.value == null ? ksGender.tr : checkNullOrStringNull(kidsController.kidGender.value),
              subtitlePrefixText: ksGender,
              isAddButton: false,
              suffixOnPressed: () {
                // Get.toNamed(krEditBasicInfo);
                Get.to(() => EditKidGenderSection());
              },
            ),
            kH16sizedBox,
            InfoContainer(
              // suffixText:
              //     profileController.userData.value!.dob == null ? ksDateOfBirth.tr : DateFormat("yyyy-MM-dd").format(profileController.userData.value!.dob!),
              suffixText: kidsController.kidDob.value == null ? ksDateOfBirth.tr : DateFormat("yyyy-MM-dd").format(kidsController.kidDob.value!),
              subtitlePrefixText: ksDateOfBirth.tr,
              isAddButton: null,
              suffixOnPressed: () {
                // editProfileHelper.editBirthday();
              },
            ),
            kH16sizedBox,
            InfoContainer(
              suffixOnPressed: () {
                // Get.toNamed(krEditBasicInfo);
              },
              // suffixText: profileController.userData.value!.languages.isEmpty
              //     ? ksLanguage.tr
              //     : editProfileHelper.languageSorting(profileController.userData.value!.languages),
              suffixText: kidsController.kidLanguageList.isEmpty ? ksLanguage.tr : kidHelper.languageSorting(kidsController.kidLanguageList),
              // isAddButton: profileController.userData.value!.languages.isEmpty ? true : false,
              isAddButton: kidsController.kidLanguageList.isEmpty ? true : false,
              subtitlePrefixText: kidsController.kidLanguageList.isEmpty ? null : ksLanguages.tr,
            ),
            kH16sizedBox,
          ],
        ),
      ),
    );
  }
}
