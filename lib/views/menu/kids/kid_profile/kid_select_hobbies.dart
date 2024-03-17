import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/helpers/menu/kids/kid_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_about.dart';

class KidSelectHobbies extends StatelessWidget {
  KidSelectHobbies({super.key});
  final KidsController kidsController = Get.find<KidsController>();
  final KidHelper kidHelper = KidHelper();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        color: cWhiteColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            kH16sizedBox,
            InfoContainer(
              suffixText: ksHobbies.tr,
              suffixTextStyle: semiBold18TextStyle(cBlackColor),
              // isAddButton: profileController.userData.value!.interest.isEmpty ? true : false,
              isAddButton: kidsController.selectedHobbies.isEmpty ? true : false,
              suffixOnPressed: () async {
                kidHelper.setHobbies();
              },
            ),
            kH8sizedBox,
            Wrap(
              alignment: WrapAlignment.start,
              direction: Axis.horizontal,
              spacing: 8.0,
              children: [
                for (int i = 0; i < kidsController.kidsData.value!.hobbies.length; i++)
                  // for (int i = 0; i < kidsController.selectedHobbies.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: k8Padding),
                    child: Container(
                      decoration: BoxDecoration(
                          color: cWhiteColor,
                          border: Border.all(
                            color: cLineColor,
                          ),
                          borderRadius: k100CircularBorderRadius),
                      child: Padding(
                        padding: const EdgeInsets.all(k8Padding),
                        child: Text(
                          // profileController.userData.value!.interest[i],
                          // kidsController.kidsData.value?.hobbies[i],
                          kidsController.kidsData.value!.hobbies[i],
                          // kidsController.selectedHobbies[i],
                          style: regular14TextStyle(cBlackColor),
                        ),
                      ),
                    ),
                  )
              ],
            ),
            kH8sizedBox,
          ]),
        ),
      ),
    );
  }
}
