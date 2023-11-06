import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_about.dart';

class ProfessionSection extends StatelessWidget {
  ProfessionSection({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();
  final GlobalController _globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          kH16sizedBox,
          RowTextButton(
            text: ksProfession.tr,
            buttonText: ksAdd.tr,
            textStyle: semiBold18TextStyle(cBlackColor),
            showAddButton: _profileController.userData.value!.profession.isEmpty ? true : false,
            onPressedAdd: () async {
              _profileController.isRouteFromAboutInfo.value = true;
              _globalController.professionIndex.value = -1;
              Get.toNamed(krSelectProfession);
              await _profileController.getProfessionList();
            },
            buttonWidth: 149,
          ),
          if (_profileController.userData.value!.profession.isNotEmpty && _profileController.showAllEditOption.value) kH12sizedBox,
          if (_profileController.userData.value!.profession.isNotEmpty && _profileController.showAllEditOption.value)
            InfoContainer2(
              suffixText: '',
              prefixText: checkNullOrStringNull(_profileController.userData.value!.profession[0]),
              isAddButton: false,
              suffixOnPressed: () async {
                _globalController.professionIndex.value = -1;
                _profileController.isRouteFromAboutInfo.value = true;
                Get.toNamed(krSelectProfession);
                await _profileController.getProfessionList();
                for (int i = 0; i < _globalController.professionList.length; i++) {
                  if (_globalController.professionList[i] == _profileController.userData.value!.profession[0]) {
                    _globalController.professionIndex.value = i;
                  }
                }
              },
            ),
          kH16sizedBox,
        ]),
      ),
    );
  }
}
