import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/helpers/menu/kids/kid_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/kids/kid_profile/edit_kid_gender_section.dart';
import 'package:bip_hip/views/menu/kids/kid_profile/edit_kid_language_section.dart';
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
        child: Obx(
          () => Column(
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
                suffixText: kidsController.kidGender.value == '' ? ksGender.tr : checkNullOrStringNull(kidsController.kidGender.value),
                subtitlePrefixText: ksGender,
                isAddButton: false,
                suffixOnPressed: () async {
                  Get.to(() => EditKidGenderSection());
                },
              ),
              kH16sizedBox,
              InfoContainer(
                suffixText: kidsController.kidDob.value == null ? ksDateOfBirth.tr : DateFormat("yyyy-MM-dd").format(kidsController.kidDob.value!),
                subtitlePrefixText: ksDateOfBirth.tr,
                isAddButton: null,
                suffixOnPressed: null,
              ),
              kH16sizedBox,
              InfoContainer(
                suffixOnPressed: () {
                  Get.to(() => EditKidLanguageSection());
                },
                suffixText:
                    kidsController.kidsData.value!.languages.isEmpty ? ksLanguage.tr : kidHelper.languageSorting(kidsController.kidsData.value!.languages),
                isAddButton: kidsController.userLanguages.isEmpty ? true : false,
                subtitlePrefixText: kidsController.userLanguages.isEmpty ? null : ksLanguages.tr,
              ),
              kH16sizedBox,
            ],
          ),
        ),
      ),
    );
  }
}
