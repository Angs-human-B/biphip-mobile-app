import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/helpers/menu/kids/kid_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_about.dart';

class KidEducationBackground extends StatelessWidget {
  KidEducationBackground({super.key});
  final KidsController kidsController = Get.find<KidsController>();
  final KidHelper kidHelper = KidHelper();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        color: cWhiteColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kH16sizedBox,
              InfoContainer(
                suffixText: ksEducationalBackground.tr,
                suffixTextStyle: semiBold18TextStyle(cBlackColor),
                isAddButton: true,
                suffixOnPressed: () {
                  kidHelper.addKidEducationBackground();
                },
              ),
              kH12sizedBox,
              for (int i = 0; i < kidsController.kidSchoolList.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: k12Padding),
                  child: InfoContainer(
                    suffixText: checkNullOrStringNull(kidsController.kidSchoolList[i].school),
                    prefixText: kidsController.kidSchoolList[i].ended != null ? ksStudiedAt.tr : ksStudiesAt.tr,
                    subtitlePrefixText:
                        kidHelper.schoolSubtitleText(kidsController.kidSchoolList[i].started ?? DateTime.now(), kidsController.kidSchoolList[i].ended),
                    isAddButton: false,
                    suffixOnPressed: () async {
                      kidHelper.editKidSchool(i);
                    },
                  ),
                ),
              kH4sizedBox
            ],
          ),
        ),
      ),
    );
  }
}
