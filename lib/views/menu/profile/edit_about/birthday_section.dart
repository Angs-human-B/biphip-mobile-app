import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/profile/edit_profile_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/button/custom_selection_button.dart';
import 'package:intl/intl.dart';

class BirthdaySection extends StatelessWidget {
  BirthdaySection({super.key});
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
          Text(
            ksDateOfBirth.tr,
            style: semiBold18TextStyle(cBlackColor),
          ),
          kH12sizedBox,
          CustomSelectionButton(
            prefixIcon: BipHip.birthday,
            hintText: krSelectBirthday.tr,
            text: DateFormat("yyyy-MM-dd").format(profileController.userData.value!.dob!),
            onPressed: () {
              editProfileHelper.editBirthday();
            },
          ),
          kH16sizedBox,
        ]),
      ),
    );
  }
}
