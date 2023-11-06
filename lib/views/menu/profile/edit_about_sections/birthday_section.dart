import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/profile_helpers/edit_profiler_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/profile/edit_about.dart';
import 'package:intl/intl.dart';

class BirthdaySection extends StatelessWidget {
  BirthdaySection({super.key});
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
          Text(
            ksDateOfBirth.tr,
            style: semiBold18TextStyle(cBlackColor),
          ),
          kH12sizedBox,
          InfoContainer2(
            suffixText: '',
            prefixText: DateFormat("yyyy-MM-dd").format(_profileController.userData.value!.dob!),
            isAddButton: false,
            suffixOnPressed: () {
              _editProfileHelper.editBirthday();
            },
          ),
          kH16sizedBox,
        ]),
      ),
    );
  }
}
