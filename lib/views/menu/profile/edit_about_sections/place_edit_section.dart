import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/profile/edit_profile_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_about.dart';
import 'package:intl/intl.dart';

class PlaceEditSection extends StatelessWidget {
  PlaceEditSection({super.key});
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
              ksAddress.tr,
              style: semiBold18TextStyle(cBlackColor),
            ),
            kH12sizedBox,
            if (profileController.hometownData.value == null)
              InfoContainer2(
                suffixText: ksHomeTown.tr,
                isAddButton: true,
                suffixOnPressed: () async {
                  editProfileHelper.setHometown();
                },
              ),
            if (profileController.hometownData.value != null)
              InfoContainer2(
                subtitlePrefixText: ksHomeTown.tr,
                suffixText: checkNullOrStringNull(profileController.hometownData.value?.city),
                isAddButton: false,
                suffixOnPressed: () async {
                  editProfileHelper.editHometown();
                },
              ),
            kH12sizedBox,
            if (profileController.currentCityData.value == null)
              InfoContainer2(
                suffixText: ksPresentAddress.tr,
                isAddButton: true,
                suffixOnPressed: () async {
                  editProfileHelper.setCurrentCity();
                },
              ),
            if (profileController.currentCityData.value != null)
              InfoContainer2(
                subtitlePrefixText: ksCurrentCity.tr,
                suffixText: checkNullOrStringNull(profileController.currentCityData.value!.city),
                isAddButton: false,
                suffixOnPressed: () async {
                  editProfileHelper.editCurrentCity();
                },
              ),
            kH12sizedBox,
            if (profileController.currentCityData.value != null && profileController.hometownData.value != null)
              InfoContainer2(
                suffixText: ksPreviousPlacesLived.tr,
                isAddButton: true,
                suffixOnPressed: () async {
                  editProfileHelper.setOtherCity();
                },
              ),
            if (profileController.currentCityData.value != null && profileController.hometownData.value != null) kH12sizedBox,
            for (int i = 0; i < profileController.otherCityList.length; i++)
              if (profileController.otherCityList[i].isCurrent == 0 && profileController.otherCityList[i].isHometown == 0)
                Padding(
                  padding: const EdgeInsets.only(bottom: k12Padding),
                  child: InfoContainer2(
                    suffixText: profileController.otherCityList[i].city!,
                    subtitlePrefixText: profileController.otherCityList[i].moved != null ? ksMovedIn.tr : null,
                    subtitleSuffixText: profileController.otherCityList[i].moved != null
                        ? DateFormat("MMMM dd, yyyy").format(profileController.otherCityList[i].moved!)
                        : null,
                    isAddButton: false,
                    suffixOnPressed: () async {
                      editProfileHelper.editOtherCity(i);
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
