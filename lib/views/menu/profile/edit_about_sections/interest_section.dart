import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/profile_helpers/edit_profile_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_about.dart';

class InterestSection extends StatelessWidget {
  InterestSection({super.key});
  final ProfileController profileController = Get.find<ProfileController>();
  final EditProfileHelper editProfileHelper = EditProfileHelper();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          kH16sizedBox,
          InfoContainer2(
            suffixText: ksInterest.tr,
            suffixTextStyle: semiBold18TextStyle(cBlackColor),
            isAddButton: profileController.userData.value!.interest.isEmpty ? true : false,
            suffixOnPressed: () async {
              editProfileHelper.setInterest();
            },
          ),
          kH8sizedBox,
          Wrap(
            alignment: WrapAlignment.start,
            direction: Axis.horizontal,
            spacing: 8.0,
            children: [
              for (int i = 0; i < profileController.userData.value!.interest.length; i++)
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
                        profileController.userData.value!.interest[i],
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
    );
  }
}
