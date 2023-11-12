import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/profile_helpers/edit_profile_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_about.dart';

class ProfessionSection extends StatelessWidget {
  ProfessionSection({super.key});
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
          RowTextButton(
            text: ksProfession.tr,
            buttonText: ksAdd.tr,
            textStyle: semiBold18TextStyle(cBlackColor),
            showAddButton: profileController.userData.value!.profession.isEmpty ? true : false,
            onPressedAdd: () async {
              editProfileHelper.setProfession();
            },
            buttonWidth: 149,
          ),
          if (profileController.userData.value!.profession.isNotEmpty && profileController.showAllEditOption.value) kH12sizedBox,
          if (profileController.userData.value!.profession.isNotEmpty && profileController.showAllEditOption.value)
            InfoContainer2(
              suffixText: '',
              prefixText: checkNullOrStringNull(profileController.userData.value!.profession[0]),
              isAddButton: false,
              suffixOnPressed: () {
                editProfileHelper.editProfession();
              },
            ),
          kH16sizedBox,
        ]),
      ),
    );
  }
}
