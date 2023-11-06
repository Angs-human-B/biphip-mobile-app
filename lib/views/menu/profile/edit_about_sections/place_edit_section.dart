import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/profile_helpers/edit_profile_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_about.dart';
import 'package:intl/intl.dart';

class PlaceEditSection extends StatelessWidget {
  PlaceEditSection({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();
  final EditProfileHelper _editProfileHelper = EditProfileHelper();

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
            if (_profileController.hometownData.value == null)
              InfoContainer2(
                suffixText: ksHomeTown.tr,
                isAddButton: true,
                suffixOnPressed: () async {
                  _editProfileHelper.setHometown();
                },
              ),
            if (_profileController.hometownData.value != null)
              InfoContainer2(
                subtitlePrefixText: ksHomeTown.tr,
                suffixText: checkNullOrStringNull(_profileController.hometownData.value?.city),
                isAddButton: false,
                suffixOnPressed: () async {
                  _editProfileHelper.editHometown();
                },
              ),
            kH12sizedBox,
            if (_profileController.currentCityData.value == null)
              InfoContainer2(
                suffixText: ksPresentAddress.tr,
                isAddButton: true,
                suffixOnPressed: () async {
                  _editProfileHelper.setCurrentCity();
                },
              ),
            if (_profileController.currentCityData.value != null)
              InfoContainer2(
                subtitlePrefixText: ksCurrentCity.tr,
                suffixText: checkNullOrStringNull(_profileController.currentCityData.value!.city),
                isAddButton: false,
                suffixOnPressed: () async {
                  _editProfileHelper.editCurrentCity();
                },
              ),
            kH12sizedBox,
            if (_profileController.currentCityData.value != null && _profileController.hometownData.value != null)
              InfoContainer2(
                suffixText: ksPreviousPlacesLived.tr,
                isAddButton: true,
                suffixOnPressed: () async {
                  _editProfileHelper.setOtherCity();
                },
              ),
            if (_profileController.currentCityData.value != null && _profileController.hometownData.value != null) kH12sizedBox,
            for (int i = 0; i < _profileController.otherCityList.length; i++)
              if (_profileController.otherCityList[i].isCurrent == 0 && _profileController.otherCityList[i].isHometown == 0)
                Padding(
                  padding: const EdgeInsets.only(bottom: k12Padding),
                  child: InfoContainer2(
                    suffixText: _profileController.otherCityList[i].city!,
                    subtitlePrefixText: _profileController.otherCityList[i].moved != null ? ksMovedIn.tr : null,
                    subtitleSuffixText: _profileController.otherCityList[i].moved != null
                        ? DateFormat("MMMM dd, yyyy").format(_profileController.otherCityList[i].moved!)
                        : null,
                    isAddButton: false,
                    suffixOnPressed: () async {
                      _editProfileHelper.editOtherCity(i);
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
