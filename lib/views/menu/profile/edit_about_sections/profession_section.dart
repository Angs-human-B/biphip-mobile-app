import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/profile_helpers/edit_profile_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_about.dart';

class ProfessionSection extends StatelessWidget {
  ProfessionSection({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();
  final EditProfileHelper _editProfileHelper = EditProfileHelper();

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
              _editProfileHelper.setProfession();
            },
            buttonWidth: 149,
          ),
          if (_profileController.userData.value!.profession.isNotEmpty && _profileController.showAllEditOption.value) kH12sizedBox,
          if (_profileController.userData.value!.profession.isNotEmpty && _profileController.showAllEditOption.value)
            InfoContainer2(
              suffixText: '',
              prefixText: checkNullOrStringNull(_profileController.userData.value!.profession[0]),
              isAddButton: false,
              suffixOnPressed: () {
                _editProfileHelper.editProfession();
              },
            ),
          kH16sizedBox,
        ]),
      ),
    );
  }
}
